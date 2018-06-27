library(tidyverse)
library(nnet)
library(caret)
library(devtools)

#Cargando los datos

bh <- read.csv("data/BostonHousing.csv")

##Particionando los datos

set.seed(1000)
t.idx <- createDataPartition(bh$MEDV, p = 0.7, list = FALSE)

#Construyendo el Modelo

fit <- nnet(MEDV/50 ~ ., data=bh[t.idx,], size=6, decay = 0.1, maxit = 1000, linout = TRUE)

source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

plot(fit, max.sp = TRUE)

t.rmse = sqrt(mean((fit$fitted.values*50 - bh[t.idx, "MEDV"])^2))
t.rmse

v.rmse <- sqrt(mean((predict(fit,bh[-t.idx,]*50 - bh[-t.idx, "MEDV"])^2)))
v.rmse

