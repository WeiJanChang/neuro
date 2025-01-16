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

- import test files in SAS OnDemand for Academics

- Create a SAS library: ``libname.sas``

- Using Macros variable to create file paths: ``output_path.sas``, ``test_file_path.sas``

- To import the CSV and JSON files into a SAS dataset: ``csv_to_sas.sas``, ``structure_json.sas``

- Processing the structure on the CSV file ``process_structure_csv.sas``

### in R

---

- Present the parent-child relationships in df called 'tree_csv' in ``csv_tree.R``
- Present the parent-child relationships in df called 'tree_json' in ``josnfile.R``
- Find differences between tree_csv and tree_json in ``difference_tree_structure.R``

## Visualisation

- Example of the first 200 degree
![Example of the first 200 degree](/figures/example_thefirst200.png)
- Example of the interactive network plots via visNetwork
![Example of Network visualisation](/figures/example_network_graph.png)
