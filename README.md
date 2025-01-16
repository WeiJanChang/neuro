# Project Overview

This project is designed to compare the tree structures from two datasets and visualize these structures.

The datasets are in CSV and JSON formats, and the functions in this project will determine whether the tree structures
from these formats are the same or not, and provide visualization for the structures.

## Features

- Compare tree structures from structure_tree_safe_2017.csv and structures.json in test_files using Statistical Analysis
  System (SAS) software.
- Supports both CSV and JSON input formats to determine if the tree structures are identical.
- visualisation the tree structures using R tools.

## Installation

- install [R](https://www.r-project.org/) or [R studio](https://posit.co/download/rstudio-desktop/)
- using [SAS OnDemand for Academics](http://welcome.oda.sas.com)

## How to use

### in SAS

---
Step I. import test files in SAS OnDemand for Academics

Step II. Create a SAS library: ``libname.sas``

Step III. Using Macros variable to create file paths: ``output_path.sas``, ``test_file_path.sas``

Step IV. To import the CSV and JSON files into a SAS dataset: ``csv_to_sas.sas``, ``structure_json.sas``

Step V. Processing the structure on the CSV file ``process_structure_csv.sas``

### in R

---

## Visualisation

![Example of Network visualisation](/figures/example_network_graph.png)
