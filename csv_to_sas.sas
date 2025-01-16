/* To import the CSV file into a SAS dataset on SAS OnDemand for Academics*/
/* Set up file path manually on 'test_file_path.sas' */
PROC IMPORT 
		DATAFILE="&csv_filepath"
		DBMS=CSV
		/* DBMS(Database Management System). This can be CSV/EXCEL/XLSX, etc */
		OUT=neuro.structure_tree_safe_2017
		/* neuro: libname */
		REPLACE;
		/* REPLACE: if work.neuro_data already there, the new one will replace it*/
RUN;
