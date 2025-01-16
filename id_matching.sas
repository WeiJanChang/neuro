/* Specify the parent_id to find matching IDs and locate the parent */
proc sql;
    create table neuro.test as
    select id, parent_structure_id, name, acronym
    from neuro.structure_tree_safe_2017
    where parent_structure_id = 500 or id = 500; /* using 500 for example */
quit;