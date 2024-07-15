/* To import the CSV file into a SAS dataset*/
PROC IMPORT 
		DATAFILE="/home/u63831316/neuro/structure_tree_safe_2017.csv" 
		DBMS=CSV OUT=neuro.structure_tree_safe_2017
		/*     DBMS(Database Management System). This can be CSV/EXCEL/XLSX, etc */
		REPLACE;
	/* REPLACE: if work.neuro_data already there, the new one will replace it*/
RUN;
