/* find out the structure in csv file */

/* find the min and max value */
proc univariate data=neuro.structure_tree_safe_2017;
var id parent_structure_id; /* min:4 max: 484682492*/
run;

%let start_parentid = 4;
%let end_parentid = 1132;

/* %DO macro-variable=start %TO stop Macro Statement
doc: https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/mcrolref/p0ri72c3ud2fdtn1qzs2q9vvdiwk.htm */
%macro loop_parent_ids;
    %do i = &start_parentid %to &end_parentid;
        proc sql;
            insert into neuro.csv_structure
            select id, parent_structure_id, name, acronym
            from neuro.structure_tree_safe_2017
            where parent_structure_id = &i;
        quit;
    %end;
%mend loop_parent_ids;

%loop_parent_ids;

proc print data=neuro.csv_structure;
run;
