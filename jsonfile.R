install.packages("jsonlite") # do the converting 
install.packages("tidyverse") # clean up data

library(jsonlite)
library(dplyr)


df <- fromJSON("~/Python/neuro/test_files/structures.json")

# To extract IDs from the structure_id_path col.
extract_ids <- function(path) {
  as.numeric(unlist(strsplit(gsub("c\\(|\\)", "", path), ",")))
}

# Create a dataframe to store id and parent-child relationships
relationships <- data.frame(id = numeric(), parent = numeric(), child = numeric())

# Loop through each row of the dataframe to create id-parent-child relationships
for (i in 1:nrow(df)) {
  # Extract the IDs from the structure_id_path
  ids <- extract_ids(df$structure_id_path[i])
  
  # Extract the current id and its parent
  current_id <- ids[length(ids)]
  parent_id <- ifelse(length(ids) > 1, ids[length(ids) - 1], NA)
  
  # Add to relationships
  relationships <- rbind(relationships, data.frame(id = current_id, parent = parent_id, child = current_id))
  
  # Generate parent-child relationships for each path
  if (length(ids) > 1) {
    parent_child <- data.frame(id = current_id, parent = ids[-length(ids)], child = ids[-1])
    relationships <- rbind(relationships, parent_child)
  }
}

# Remove duplicate relationships
relationships <- unique(relationships)

# Group children by id
tree_jsn <- relationships %>%
  group_by(id) %>%
  summarize(
    parent_structure_id = first(parent),
    children = paste(unique(child[child != id]), collapse = ", ")
  )

# Merge with the original data frame to include 'id', 'parent_structure_id', and 'children'
final_treejsn <- df %>%
  select(id, structure_id_path) %>%
  left_join(tree_jsn, by = "id") %>%
  select(id, parent_structure_id, children)

tree_json <- as.data.frame(final_treejsn)
