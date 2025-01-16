library(dplyr)
library(jsonlite)

# Read the CSV file
df <- read.csv("[PATH_TO_CSV_FILE]/structure_tree_safe_2017.csv")

result <- df %>%
  group_by(parent_structure_id) %>%
  reframe(child_id = paste(sort((id)), collapse = ", ")
  ) %>%
  unique()

tree_csv <- as.data.frame(result)

# Group by 'parent_structure_id' and concat 'id' values
children_df <- df %>%
  group_by(parent_structure_id) %>%
  summarise(children = paste(sort(id), collapse = ", "))

# Merge back with the original dataframe to add the children information
result <- df %>%
  left_join(children_df, by = c("id" = "parent_structure_id"))

# Select only the relevant columns: 'id', 'parent_structure_id', and 'children'
result <- result %>%
  select(id, parent_structure_id, children)

tree_csv <- as.data.frame(result)
