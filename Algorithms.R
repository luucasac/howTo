##--------------------------------------------------------------------------------##
##                          C5.0 algorithm                                        ##
##--------------------------------------------------------------------------------##

library(C50)
library(printr)

### dividing the iris dataset to 

train <- sample(1:nrow(iris), 100)

iris.train <- iris[train, ]
iris.test <- iris[-train, ]


#### training the dataset

model <- C5.0(Species ~ ., data = iris.train)

results <- predict(object = model, newdata = iris.test, type = "class")

table(results, iris.test$Species)


##--------------------------------------------------------------------------------##
##                          K-means                                               ##
##--------------------------------------------------------------------------------##

# K-mean is an algotithm that uses a cluster analysis techinique. With it, we form groups around data that look familiar

library(printr)
library(stats)

model <- kmeans(x = subset(iris, select = -Species), centers = 3) # removing the column Species to dont know the species previusly

table(model$cluster, iris$Species) #confusion matrix

##--------------------------------------------------------------------------------##
##                          Support Vector Machines                               ##
##--------------------------------------------------------------------------------##
library(e1071)
library(printr)

train <- sample(1:nrow(iris), 100)

iris.train <- iris[train, ]
iris.test <- iris[-train, ]

model <- svm(Species ~ ., data = iris.train)

results <- predict(object = model, newdata = iris.test, type = "class")

table(results, iris.test$Species)
