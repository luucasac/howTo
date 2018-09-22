# ------------------------------------------------------------------------------------------------------------------------------------ #
# -------------------------------------------------------- Supervised Learning ------------------------------------------------------- #
# ------------------------------------------------------------------------------------------------------------------------------------ #
library(class)
library(naivebayes)
library(tm)
library(pROC)

# getting iris dataset to apply learning

data(iris)

set.seed(123)

train_index <- sample(1:nrow(iris), size = (nrow(iris)-50))

train <- iris[train_index, ]

test <- iris[ -train_index, ]

iris_types <- train$Species

# knn model with k = 3

iris_pred <- knn(train = train[, -ncol(train)], test = test[, -ncol(test)], cl = train$Species, k = 3)

# confusing table

mean(iris_pred == test[, ncol(test)]) # 98% of accuracy !

iris_probs <- knn(train = train[, -ncol(train)], test = test[, -ncol(test)], cl = train$Species, k = 3, prob = TRUE)

# probabilites

iris_probs

# function to normalize data

normalize <- function(x){
  norm <- (x - min(x)) / (max(x) - min(x))
}

summary(normalize(iris$Sepal.Length))
summary(iris$Sepal.Length)

# --------- Bayesian Methods --------------- #
# conditional probabilities

p_A <- nrow(subset(iris, Petal.Width > 1))/nrow(iris)

p_B <- nrow(subset(iris, Petal.Length > 1))/nrow(iris)

p_AB <- nrow(subset(iris, Petal.Width < 1 & Petal.Length > 1))/nrow(iris)

p_AB_B <- p_AB / p_B

# Naive Bayes

locmodel <- naive_bayes(Species ~ Petal.Width, data = iris) # a model with probabilites of an event to happen

predict(locmodel, data = iris, type = "prob")
# Laplace correction
## when an event has 0 probability to happen, we use laplace method to increment with a small value and it cant affect the other events
locmodel2 <- naive_bayes(Species ~ Petal.Width, data = iris, laplace = 1) # a model with probabilites of an event to happen

predict(locmodel2, data = iris, type = "prob")

# Binning numeric data for naive bayes
## bag of words

# ----------------- Logistic Regression --------------------- #

# bootstrapping

df <- data.frame(y = sample(0:1, 50, replace = T),
                 x = sample(0:20, 50, replace = T))

# logistic regression

mod <- glm(y ~ x, 
           data = df,
           family = "binomial") # binomial means logistic

plot(mod)

# test bootstrap

df_test <- data.frame(y = sample(0:1, 20, replace = T),
                      x = sample(0:20, 20, replace = T))

prob <- predict(mod, df_test, type = "response")

pred <- ifelse(prob > 0.50, 1, 0)

mean(pred)

# ROC

ROC <- roc(df_test$y, pred) # when more closely to 1, better is the accuraccy of a model

plot(ROC, col = "red")

auc(ROC) # area under de curve

# dummy coding categorical data
## replace na values with the sample average and create a column of dummy by each empty value in df

# -------------- decision trees --------------------#
library(rpart)
library(rpart.plot)

mod <- rpart(Species ~ ., data = iris, control = rpart.control(cp = 0)) # control will control the built of new prunes

iris$pred <- predict(mod, data = iris[120, ], type = "class") # type will refer to the output, in this case class its about to classify the output

rpart.plot(mod)

table(iris$pred, iris$Species)

# setting a different control par

prune_control <- rpart.control(maxdepth = 30, minsplit = 20)

mod2 <- rpart(Species ~ ., data = iris, control = prune_control) 

rpart.plot(mod2)

# ---------------- random Forest -------------------------- #
library(randomForest)

