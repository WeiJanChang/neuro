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



compare_dataframes <- function(df1, df2) {
  # Find unique IDs in each dataframe
  unique_to_df1 <- setdiff(df1$id, df2$id)
  unique_to_df2 <- setdiff(df2$id, df1$id)
  
  # Find common IDs and compare their details
  common_ids <- intersect(df1$id, df2$id)
  
  # Create a list to store differences
  differences <- list(
    unique_to_df1 = df1 %>% filter(id %in% unique_to_df1),
    unique_to_df2 = df2 %>% filter(id %in% unique_to_df2),
    differences_in_common_ids = lapply(common_ids, function(id) {
      df1_row <- df1 %>% filter(id == id)
      df2_row <- df2 %>% filter(id == id)
      if (!identical(df1_row, df2_row)) {
        list(
          id = id,
          df1_details = df1_row,
          df2_details = df2_row
        )
      } else {
        NULL
      }
    }) %>% Filter(Negate(is.null), .)
  )
  
  return(differences)
}

# Run comparison
differences <- compare_dataframes(tree_csv, tree_json)
view(differences)
# Display differences
print("Unique to DataFrame 1:")
print(differences$unique_to_df1)

print("Unique to DataFrame 2:")
print(differences$unique_to_df2)

print("Differences in common IDs:")
print(differences$differences_in_common_ids)
