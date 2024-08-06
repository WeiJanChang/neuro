install.packages("jsonlite") # do the converting 
install.packages("tidyverse") # clean up data

library(jsonlite)
library(tidyverse)
library(readr)

df <- fromJSON("~/Python/neuro/test_files/structures.json")
parent <- df$structure_id_path[[i]]
child <- df$structure_id_path[[i]][i-1]

df_1 <- unnest(df, structure_id_path)


# Load necessary libraries
library(jsonlite)
library(dplyr)


# Function to extract list from character string
extract_ids <- function(path) {
  as.numeric(unlist(strsplit(gsub("c\\(|\\)", "", path), ",")))
}

# Create a list of parent-child relationships
relationships <- do.call(rbind, lapply(df$structure_id_path, function(path) {
  ids <- extract_ids(path)
  if (length(ids) > 1) {
    # Create parent-child pairs
    parent_child <- data.frame(parent = ids[-length(ids)], child = ids[-1])
  } else {
    parent_child <- data.frame(parent = NA, child = ids)
  }
  return(parent_child)
}))

# Remove duplicate relationships
relationships <- unique(relationships)

# Merge with data to get names
relationships_with_names <- merge(
  relationships, df[, c("id", "name")], by.x = "parent", by.y = "id", all.x = TRUE, suffixes = c("_parent", "_child")
)
relationships_with_names <- merge(
  relationships_with_names, df[, c("id", "name")], by.x = "child", by.y = "id", all.x = TRUE, suffixes = c("_parent", "_child")
)

# Display the results
view(relationships_with_names)
