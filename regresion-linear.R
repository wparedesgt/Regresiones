library(tidyverse)
library(caret)

#Se realizaran prediciones acorde a  mpg basado en variables cylinders, displacement#, horsepower, weight, y acceleration.

auto <- read.csv("data/auto-mpg.csv")

#Cambiando a factores los cilindros

auto$cylinders <- factor(auto$cylinders, levels = c(3,4,5,6,8), labels = c("3cyl", "4cyl", "5cyl", "6cyl", "8cyl"))

#Creando las particiones

set.seed(1000)
t.idx <- createDataPartition(auto$mpg, p= 0.7, list = FALSE)


#Creando un modelo de regresion linear

mod <- lm(mpg ~ ., data = auto[t.idx, -c(1,8,9)])

#Generando la Prediccion

pred <- predict(mod, auto[-t.idx, -c(1,8,9)])
sqrt(mean((pred - auto[-t.idx, 2])^2))

#Generando un Plot

par(mfrow = c(2,2))
plot(mod)
par(mfrow = c(1,1))


auto <- within(auto, cylinders <- relevel(cylinders, ref = "4cyl") )
mod <- lm(mpg ~., data = auto[t.idx, -c(1, 8, 9)])

par(mfrow = c(2,2))
plot(mod)

