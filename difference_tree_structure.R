# compare two df
identical(tree_json, tree_csv)
all.equal(tree_json, tree_csv)

# setequal:
# setequal will only return one overall TRUE/FALSE value comparing the entire vector.
comparison_id <- setequal(tree_csv$id, tree_json$id)
comparison_structure_id <- setequal(tree_csv$parent_structure_id, tree_json$parent_structure_id)
comparison_children <- setequal(tree_csv$children, tree_json$children)

# paste() to concatenate strings or variables into a single string
print(paste(comparison_id, comparison_structure_id, comparison_children))

# What are the differences in these two df?

only_in_csv_id <- setdiff(tree_csv$id, tree_json$id)
only_in_csv_parentid <- setdiff(tree_csv$parent_structure_id, tree_json$parent_structure_id)
only_in_csv_childid <- setdiff(tree_csv$children, tree_json$children)


# show the difference in df
tree_json1 <- tree_json %>%
  mutate(children = str_split(children, ", ") %>% lapply(as.numeric)) # 將children 裡的, 去掉並設為numeric 回傳list in children col 
# lapply 會回傳list 
# mutate(): 用mutate 可以修改or 添加row 

tree_csv1 <- tree_csv %>%
  mutate(children = str_split(children, ", ") %>% lapply(as.numeric))

# join 兩個df: tree_json1 join tree_csv1 based on id(會保留兩個df 所有id), 然後若沒匹配就輸入NA

merged_df <- full_join(tree_json1, tree_csv1, by = "id", suffix = c("_tree_json1", "_tree_csv1"))


# differences bewteen parent_structure_id column and children column
differences_basedonid <- merged_df %>%
  filter(parent_structure_id_tree_json1 != parent_structure_id_tree_csv1 |
           !mapply(setequal, children_tree_json1, children_tree_csv1)) %>%
  mutate(different_parent = parent_structure_id_tree_json1 != parent_structure_id_tree_csv1,
         different_children = !mapply(setequal, children_tree_json1, children_tree_csv1))
view(differences_basedonid)
