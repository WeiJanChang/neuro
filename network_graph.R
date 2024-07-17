# install.packages("igraph", type="binary")
# install.packages("visNetwork")
library(igraph)
library(visNetwork)

# STEP 1: read data
data <- read.csv("/Users/wei/Python/neuro/test_files/structure_tree_safe_2017.csv")

# STEP 2: extract two columns of data and creat a df
id_parentid<- data.frame(data$id, data$parent_structure_id, data$acronym)

# STEP3: creat network graph
# a vertex is a node. and an edge is a link between vertices 
# 一個network 圖裡，會有node(vertex) =唯一的id  和edge  
net <-graph.data.frame(id_parentid,directed=T) # T=TRUE 從一個node指向另一個node

#display vertex
V(net) #unique vertex name (id 和parent_id unique value)
#label the vertex

# OPTION1: set id as label
V(net)$label <- V(net)$name

# OPTION2: set acronym as label
#name_mapping <- setNames(data$acronym, data$id)
#V(net)$label <- name_mapping[V(net)$name]

#add the weight. Degree represents the number of connections to a node
V(net)$degree <- degree(net) 
# V(net):圖裡的所有點
# degree(net): 計算每個點有多少條連接線

# Histogram:
hist(V(net)$degree,,
     col = 'yellow',
     main = 'Histogram of Node Degree',
     ylab = 'Number of Nodes',
     xlab = 'Degree of Vertices') # number of connections

# Plot 1: select the first 200 degree
top_nodes <- order(degree(net), decreasing = TRUE)[1:200]
sub_net <- induced_subgraph(net, top_nodes)
plot(sub_net,
     vertex.color = 'green',
     vertex.size = 9,
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

# Plot 3: visNetwork plot
# OPTION 1: Select the top 50 nodes by degree
# top_nodes <- order(degree(net), decreasing = TRUE)[1:50]
# sub_net <- induced_subgraph(net, top_nodes)
# nodes <- data.frame(id = V(sub_net)$name, label = V(sub_net)$label, degree = V(sub_net)$degree)
#edges <- as_data_frame(sub_net, what = "edges")

# OPTION 2:select all nodes on visNetwork
nodes <- data.frame(id = V(net)$name, label = V(net)$label, degree = V(net)$degree)
edges <- as_data_frame(net, what = "edges")

# Create the visNetwork plot
visNetwork(nodes, edges) %>%
  visNodes(size = 15) %>%
  visEdges(arrows = "to") %>%
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
  visInteraction(navigationButtons = TRUE)

