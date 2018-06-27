library(tidyverse)
library(caret)
library(randomForest)

#Leyendo la data

bh <- read.csv("data/BostonHousing.csv")

#Particionando la data

set.seed(1000)
t.idx <- createDataPartition(bh$MEDV, p = 0.7, list = FALSE)

#Contruyendo el bosque aleatorio

mod <- randomForest(x = bh[t.idx,1:13], y=bh[t.idx,14],ntree=1000,  xtest = bh[-t.idx,1:13], ytest = bh[-t.idx,14], importance=TRUE, keep.forest=TRUE)

mod$importance

#Comparando los valores predichos y reales para la partición

plot(bh[t.idx,14], predict( mod, newdata=bh[t.idx,]), xlab = "Actual", ylab = "Predicción")

#Compara las predicciones de fuera de bolsa (OOB) con los valores reales 

plot(bh[t.idx,14], mod$predicted, xlab = "Actual", ylab = "Prediccion")

#Comparando con el test

plot(bh[-t.idx,14], mod$test$predicted, xlab = "Actual", ylab = "Prediccion")


