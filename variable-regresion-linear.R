library(tidyverse)
library(MASS)
library(caret)

auto <- read.csv("data/auto-mpg.csv")
auto$cylinders <- factor(auto$cylinders, levels = c(3,4,5,6,8), labels = c("3cyl", "4cyl", "5cyl", "6cyl", "8cyl"))

#Creando la particion

set.seed(1000)
t.idx <- createDataPartition(auto$mpg, p = 0.7, list = FALSE)

#Creando la regresion

fit <- lm(mpg ~ ., data = auto[t.idx, -c(1,8,9)])
step.model <- stepAIC(fit, direction = "backward")

plot(step.model)
