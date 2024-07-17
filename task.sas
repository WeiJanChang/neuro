/* find out if there is any difference of two tree strcutures from 
two dataset `structure_tree_safe_2017.csv` & `structures.json` */
 
/* 指定parent_id 來找id哪些符合並找到parent */
proc sql;
    create table neuro.test as
    select id, parent_structure_id, name,acronym
    from neuro.structure_tree_safe_2017
    where parent_structure_id = 500 or id = 500;
quit;

/* check the frequncy of id and parent id*/
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



%let parentid = 182305689 312782546 312782574 312782628 
480149202 480149230 480149258 480149286 480149314 
484682470 484682475 484682492;  

proc sql;
    create table neuro.test1 as
    select id, parent_structure_id, name, acronym
    from neuro.structure_tree_safe_2017
    where 1=0;  /* where 1=0 是false, 所以會為一個empty table*/
quit;

/* 依序尋找parentid insert to test1裡 */
%macro loop_parent_ids;
    %let n = %sysfunc(countw(&parentid)); 
    /* sysfunc裡有countw來算paretid 裡面有多少值，然後給variable "n" */
    %do i = 1 %to &n;
    /* 當i = 1, n 就是第一個數值182305689.. 以此類推  */
        %let id = %scan(&parentid, &i);
        /*  %scan(string, n, delimiters:空格by default)        */
        proc sql;
            insert into neuro.test1
            select id, parent_structure_id, name, acronym
            from neuro.structure_tree_safe_2017
            where parent_structure_id = &id or id = &id;
        quit;
    %end;
%mend loop_parent_ids;

%loop_parent_ids;

proc print data=neuro.test1;
run;


/* combine test and test1 dataset */
data neuro.structure_test;
    set neuro.test1 neuro.test;
run;


