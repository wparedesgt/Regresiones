library(tidyverse)
library(rpart)
library(rpart.plot)
library(caret)

#Cargando el csv de datos

ed <- read.csv("data/education.csv")

#cambiando el tipo por factor "class(ed$region)" ya que es entero

ed$region <- factor(ed$region)

##Creando la particion de datos

set.seed(1000)
t.idx <- createDataPartition(ed$expense, p= 0.7, list = FALSE)

#creando la particion recursiva y arbol de regresion

fit <- rpart(expense ~ region+urban+income+under18,  data = ed[t.idx, ])

#construyendo el arbol 

prp(fit, type=2, nn=TRUE, fallen.leaves=TRUE, faclen=4, varlen=8, shadow.col="gray")

