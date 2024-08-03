install.packages("jsonlite") # do the converting 
install.packages("tidyverse") # clean up data

library(jsonlite)
library(tidyverse)
library(readr)
df <- fromJSON("/Users/wei/Python/neuro/test_files/structures.json")
typeof(df$acronym)
typeof(df$id)
typeof(df$name)
typeof(df$structure_id_path)
typeof(df$rgb_triplet)
df_1 <- unnest(df, structure_id_path)
df_2 <- unnest(df_1, rgb_triplet)

# 
