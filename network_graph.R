install.packages("igraph", type="binary")
install.packages("visNetwork")
library(igraph)
library(visNetwork)

# STEP 1: read data
data <- read.csv("[PATH_TO_FILE]/structure_tree_safe_2017.csv")

# STEP 2: extract two columns of data and creat a df
id_parentid<- data.frame(data$id, data$parent_structure_id, data$acronym)

# STEP3: create network graph
# a vertex is a node. and an edge is a link between vertices 
# 一個network 圖裡，會有node(vertex) =唯一的id  和edge  
net <-graph.data.frame(id_parentid,directed=T) # T=TRUE 從一個node指向另一個node

#display vertex
V(net) #unique vertex name (id 和parent_id unique value)
#label the vertex

# OPTION1: set id as label
# V(net)$label <- V(net)$name

# OPTION2: set acronym as label
name_mapping <- setNames(data$acronym, data$id)
V(net)$label <- name_mapping[V(net)$name]

#add the weight. Degree represents the number of connections to a node
V(net)$degree <- degree(net) 
# V(net):圖裡的所有點
# degree(net): 計算每個點有多少條連接線

# Histogram:
# 1000多個小孩有0-3條連接線
hist(V(net)$degree,,
     col = 'yellow',
     main = 'Histogram of Node Degree',
     ylab = 'Number of Nodes',
     xlab = 'Degree of Vertices') # number of connections

# Plot 1: select the first 200 degree
top_nodes <- order(degree(net), decreasing = TRUE)[1:200]
sub_net <- induced_subgraph(net, top_nodes) #小孩對應到母親的net
plot(sub_net,
     vertex.color = 'green',
     vertex.size = 9, #圈圈大小
     edge.arrow.size = 0.3,
     vertex.label.cex = 0.5)

# Plot 2: weighted details are in the chart
top_nodes <- order(degree(net), decreasing = TRUE)[1:200]
sub_net <- induced_subgraph(net, top_nodes)
plot(sub_net,
     vertex.color = rainbow(10), # 30 different colors
     vertex.size = 9,
     vertex.label.cex = 0.5,
     edge.arrow.size=0.5)

# Plot 3: 因為上述顯示全部太擠 看不到點跟點跟線，所以找到了visNetwork plot來show the figure
# OPTION 1: Select the top 50 nodes by degree
# top_nodes <- order(degree(net), decreasing = TRUE)[1:50]
# sub_net <- induced_subgraph(net, top_nodes)
# nodes <- data.frame(id = V(sub_net)$name, label = V(sub_net)$label, degree = V(sub_net)$degree)
#edges <- as_data_frame(sub_net, what = "edges")

# OPTION 2:select all nodes on visNetwork
#a nodes data.frame, with id column
#a edges data.frame, with from and to columns # net = 全部的columns
nodes <- data.frame(id = V(net)$name, label = V(net)$label, degree = V(net)$degree)
edges <- as_data_frame(net) # igraph 裡的語法
# what = :  whether to return info about vertices, edges, or both. The default is ‘edges’.

# Create the visNetwork plot
# 缺點：太慢 太難一次看清楚整個view, 為何不用visTREE
visNetwork(nodes, edges) %>%
  visNodes(size = 15) %>%
  visEdges(arrows = "to") %>% #從小孩到媽媽 所以用to
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
  visInteraction(navigationButtons = TRUE)

