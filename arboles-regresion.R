library(tidyverse)
library(rpart)
library(rpart.plot)
library(caret)

#leyendo el csv

bh <- read.csv("data/BostonHousing.csv")

#particionando la data

set.seed(1000)
t.idx <- createDataPartition(bh$MEDV, p= 0.7, list = FALSE)

#Construyendo y observando el modelo de arbol de regresion

bfit <- rpart(MEDV ~., data = bh[t.idx, ])

prp(bfit, type=2, nn=TRUE, fallen.leaves=TRUE, faclen=4, varlen=8, shadow.col="gray")

bfit$cptable

plotcp(bfit)


#Podando y graficando el Arbol

bfitpruned <- prune(bfit, cp=0.01192653)
prp(bfitpruned, type=2, nn=TRUE, fallen.leaves=TRUE, faclen=4, varlen=8, shadow.col="gray")

#Usando  el árbol elegido para calcular el error RMS para la partición de #capacitación:


preds.t <- predict(bfitpruned, bh[t.idx,])
sqrt(mean((preds.t-bh[t.idx,"MEDV"])^2))

preds.v <- predict(bfitpruned, bh[-t.idx,])
sqrt(mean((preds.v - bh[-t.idx,"MEDV"])^2))

