library(tidyverse)
library(ipred)
library(gbm)

#leyendo el csv

bh <- read.csv("data/BostonHousing.csv")

#particionando la data

set.seed(1000)
t.idx <- createDataPartition(bh$MEDV, p= 0.7, list = FALSE)

#Creando el Arbol metodo ensamble

fit <- bagging(MEDV ~., data= bh[t.idx,], control= rpart.control(minsplit=10))
prediction.t <- predict(fit, bh[t.idx,]) # on training set
sqrt(mean((prediction.t-bh[t.idx,"MEDV"])^2))# RMS for training

##Usando Gradient Boosted Machine

gbmFit <- gbm(MEDV ~., data= bh, distribution="gaussian")
prediction.t <- predict(gbmFit, bh) # on training set
sqrt(mean((prediction.t-bh$MEDV)^2))# RMS for training
