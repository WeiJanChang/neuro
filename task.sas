/* find out if there is any difference of two tree strcutures from 
two dataset `structure_tree_safe_2017.csv` & `structures.json` */
 
/* 指定parent_id 來找id哪些符合並找到parent */
proc sql;
    create table neuro.test as
    select id, parent_structure_id, name,acronym
    from neuro.structure_tree_safe_2017
    where parent_structure_id = 500 or id = 500;
quit;

proc freq data=neuro.structure_tree_safe_2017;
table id parent_structure_id;
run;

/* find the min and max value */
proc univariate data=neuro.structure_tree_safe_2017;
var id parent_structure_id; /* min:4 max: 484682492*/
run;


%let start_parentid = 4;  
%let end_parentid = 1132;

proc sql;
    create table neuro.test as
    select id, parent_structure_id, name, acronym
    from neuro.structure_tree_safe_2017
    where 1=0;  /* where 1=0 是false, 所以會為一個empty table*/
quit;

/* %DO macro-variable=start %TO stop Macro Statement
doc: https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/mcrolref/p0ri72c3ud2fdtn1qzs2q9vvdiwk.htm */
%macro loop_parent_ids;
    %do i = &start_parentid %to &end_parentid;
        proc sql;
            insert into neuro.test
            select id, parent_structure_id, name, acronym
            from neuro.structure_tree_safe_2017
            where parent_structure_id = &i;
        quit;
    %end;
%mend loop_parent_ids;

%loop_parent_ids;





%let start_parentid =182305689;  
%let end_parentid = 484682492;

proc sql;
    create table neuro.test1 as
    select id, parent_structure_id, name, acronym
    from neuro.structure_tree_safe_2017
    where 1=0;  /* where 1=0 是false, 所以會為一個empty table*/
quit;

/* %DO macro-variable=start %TO stop Macro Statement
doc: https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/mcrolref/p0ri72c3ud2fdtn1qzs2q9vvdiwk.htm */
%macro loop_parent_ids;
    %do i = &start_parentid %to &end_parentid;
        proc sql;
            insert into neuro.test1
            select id, parent_structure_id, name, acronym
            from neuro.structure_tree_safe_2017
            where parent_structure_id = &i;
        quit;
    %end;
%mend loop_parent_ids;

%loop_parent_ids;


