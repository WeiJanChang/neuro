# Task 1

- find out if there is any difference of two tree strcutures from two dataset `structure_tree_safe_2017.csv` & `structures.json`

Similar:
1. json 和 csv有一樣的id, name, acronym

different 
1. json 多了一個colunm : rgb_triplet
2. csv 和 json 有不一樣的structure_id_path..sturcture_id_path 可以看出媽媽的媽媽的媽媽的媽媽

JSON 和 CSV 都有不同的tree.
要有一個function, input 會是CSV 跟JSON, 去判斷兩個資料型態是不是一樣的，回傳是是或否



- how to provide better visualization of this tree structure, plot using any tool


a<-list(c(1,2,3))
a
b <- list(c(1,2,3))
identical(a,b) #類似這樣判斷

