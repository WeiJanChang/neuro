filename in "/home/u63831316/neuro/structures.json";
filename map 'neuro.map';
libname in json map=map automap=reuse;


filename mydata '/home/u63831316/neuro/structures.json';
libname myjson JSON fileref=mydata;

proc contents data = myjson._all_;
run;
