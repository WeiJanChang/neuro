# compare two df
identical(tree_json, tree_csv)
all.equal(tree_json, tree_csv)

# setequal:
# setequal will only return one overall TRUE/FALSE value comparing the entire vector.
comparison_col1 <- setequal(tree_csv$id, tree_json$id)
comparison_col2 <- setequal(tree_csv$parent_structure_id, tree_json$parent_structure_id)
comparison_col3 <- setequal(tree_csv$children, tree_json$children)


