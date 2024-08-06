# assertequal dataframe??
library(dplyr)
library(jsonlite)

# Read the CSV file
df <- read.csv("/Users/wei/Python/neuro/test_files/structure_tree_safe_2017.csv")

# Create a data frame with relevant columns
data <- data.frame(id = df$id, parent_structure_id = df$parent_structure_id, acronym = df$acronym)

result <- data %>%
  group_by(parent_structure_id) %>%
  reframe(child_id = paste(sort((id)), collapse = ", ")
  ) %>%
  unique()
typeof(result)
# 比list 是錯的

tree_csv <- as.data.frame(result)
