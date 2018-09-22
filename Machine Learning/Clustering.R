# ---------------------------------------------------------------------------------------------------- #
#                                           Clustering                                                 #
# ---------------------------------------------------------------------------------------------------- #
library(dummies)
library(ggplot2)
library(dplyr)
library(dendextend)
library(purrr)
library(cluster)

# ------- Euclidean Distance --------- #

# clustering it's a form of exploratory data analysis (EDA) where observations are divided into meaningful groups that share common characteristics
# Must have no missing values and the features (data characteristics) must been in same scale
# distance = 1 - similarity

# sampling

two_players <- data.frame(x = c(0,9), y = c(0,12), row.names = c("BLUE", "RED"))

# calculating euclidean distance

dist(two_players, method = "euclidean") # distance between two players is 15

three_players <- rbind(two_players, "GREEN" = c(-2,12)) 

dist(three_players, method = "euclidean") # return a matrix with distance between all players

# putting data in the same scale for continous data

three_players_scaled <- scale(three_players)

dist(three_players_scaled)



# ------- Categorical Distance --------- #

# Jaccard distance (binary distance): similarity = (x1 intersect x2) / (x1 union x2)

# random sampling

a <- data.frame(wine = c(TRUE, FALSE, TRUE), 
                beer = c(TRUE, TRUE, FALSE), 
                whiskey = c(FALSE, TRUE, TRUE),
                vodka = c(FALSE, TRUE, FALSE)
)

dist(a, method = "binary") # the distance between three observartions

# when we have more than two categorical variables we need a dummification
# changing categorical data into a matrix of binary values

# random sampling

b <- data.frame(color = c("red", "green", "blue", 'blue'),
                sport = c("soccer", "hockey", "hockey", "soccer"))

b_dummy <- dummy.data.frame(b) # this tranform the data.frame into a data.frame with dummies for each variable in original df

# distance in the dummies df

b_dummy_dist <- dist(b_dummy, "binary")

# when we have more categorical variables, we want to find the closest variable of two close variables 

# linkage criteria to find a hieranchy between categories

# complete linkage

max(c(b_dummy_dist[1], b_dummy_dist[2]))

# simple linkage

min(c(b_dummy_dist[1], b_dummy_dist[2]))

# average linkage

mean(c(b_dummy_dist[1], b_dummy_dist[2]))



# ------- K clusters --------- #

# random sampling

players <- data.frame(x = c(-1, -2, 8, 7, -12, -15), y = c(1, -3, 6, -8, 8, 0))

dist_players <- dist(players, method = "euclidean")

hc_players <- hclust(dist_players, method = "complete") # creating clusters with complete method

cluster_assignements <- cutree(hc_players, k = 2) # creates a vector with hierarchical cluster 

players_clustered <- mutate(players, cluster = cluster_assignements)

# visualizing k-clusters

ggplot(players_clustered, aes(x, y, col = factor(cluster)))+
  geom_point()

# Dendrogram
# visualization of all clusters and their relationship

plot(hc_players)

# cutting heights to separate clusters

dend_players <- as.dendrogram(hc_players) # convert the created clusters into a dendogram object

dend_colored_15 <- color_branches(dend_players, h = 15) # coloring the cluster that are no longer than height 15

dend_colored_10 <- color_branches(dend_players, h = 10) # coloring the cluster that are no longer than height 15

# plotting clusters

plot(dend_colored_15) # two cluster with cut in 15

plot(dend_colored_10) # four cluster with cut in 10

# counting obs by cluster

count(players_clustered, cluster)

# summarized data of clusters

players_clustered %>% 
  group_by(cluster) %>% 
  summarise_all(funs(mean(.)))

# ------- k means --------- #
## how many cluster to generate
## centroid is the min distance between a point and the positions
# k menas will re calculate the position of a centroid until maximize the cluster

model <- kmeans(players, centers = 2) # centers is equally to k

model$cluster

plot(players, col = factor(model$cluster))

## elbow method use the sum of squared euclidean distance to calculate the best k
## the best point is when the curve becames flatten

total_clusters <- map_dbl(1:3, function(k){
  model <- kmeans(x = players, centers = k)
  model$tot.withinss
}
)

total_clusters # 2 clusters is the best k for this model

elbow_df <- data.frame(k = 1:3, tot_withinss = total_clusters)

ggplot(elbow_df, aes(k, tot_withinss))+
  geom_line()


# ------ Silhoutte Analysis Method ---------#
## how well each of observation fit into its cluster
## within cluster distance calculate the distance between the observation and the other components of the cluster
## the closest neighbor distance calculate the closest cluster to that observation
## the value will be between -1 and 1. When its 1, it well matched to the cluster; when 0, its on border between two clusters; when -1 is better fit in neighboring cluster

pam_k3 <- pam(players, k = 3)

pam_k3$silinfo$avg.width # this is the average distance width for each point in cluster

plot(players)

plot(silhouette(pam_k3))

# highest average silhouette width

sill_width <- map_dbl(2:5, function(k){
  mod <- pam(x = players, k = k)
  mod$silinfo$avg.width
})

sill_df <- data.frame(k = 2:5,
                      sill_width = sill_width)

print(sill_df) # the best fitted cluster is when k = 2

ggplot(sill_df, aes(x = k, y = sill_width))+
  geom_line()+
  scale_x_continuous(breaks = 2:5)

# -------------- case study -----------------#

customer_spend
