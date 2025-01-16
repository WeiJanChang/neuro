filename in "&json_filepath"; /* Refer this macro variable into test_file_path.sas */
filename map 'neuro.map';
libname in json map=map automap=reuse;
/* creates a library, using the JSON engine */

filename mydata '/PATH/TO/neuro/structures.json';
/* Define a fileref for the json file*/

libname myjson JSON fileref=mydata;
/* Create a library to access the JSON file as SAS dataset */

proc contents data = myjson._all_; /* Display metadata about all datasets in the myjson library*/
run;
