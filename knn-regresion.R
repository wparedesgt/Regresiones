library(tidyverse)
library(dummies)
library(FNN)
library(scales)
library(caret)

#Cargando el archivo csv

educacion <- read.csv("data/education.csv")

# Generando el Dummy 

dums <- dummy(educacion$region, sep = "_")  
educacion <- cbind(educacion, dums)

#Re escalando y estandarizando

educacion$urban.s <- rescale(educacion$urban)
educacion$income.s <- rescale(educacion$income)
educacion$under18.s <- rescale(educacion$under18)

#Creando 3 particiones 

set.seed(1000)
t.idx <- createDataPartition(educacion$expense, p= 0.6, list = FALSE)
trg <-  educacion[t.idx, ]
rest <- educacion[-t.idx, ]

set.seed(2000)
v.idx <- createDataPartition(rest$expense, p= 0.5, list = FALSE)
val <- rest[v.idx, ]
test <- rest[-v.idx, ]

#Construyendo el modelo para varios valores de k, mostramos
#cómo calcular el error RMS (Root-Media-Square)desde cero
#número de vecinos considerados k = 1

resl <- knn.reg(trg[,7:12], val[,7:12], trg[,6], 1, algorithm = "brute" )
rmsel <- sqrt(mean((resl$pred - val[,6])^2))
rmsel


##Calculamos con valores distintos de k

res2 <- knn.reg(trg[, 7:12], val[,7:12], trg[,6], 2, algorithm="brute")
rmse2 <- sqrt(mean((res2$pred-val[,6])^2))
rmse2

res3 <- knn.reg(trg[, 7:12], val[,7:12], trg[,6], 3, algorithm="brute")
rmse3 <- sqrt(mean((res3$pred-val[,6])^2))
rmse3

res4 <- knn.reg(trg[, 7:12], val[,7:12], trg[,6], 4, algorithm="brute")
rmse4 <- sqrt(mean((res4$pred-val[,6])^2))
rmse4

#Obtuvimos el error RMS más bajo para k = 2. Evaluar el modelo en la prueba
#partición de la siguiente manera:


res.test <- knn.reg(trg[, 7:12], test[,7:12], trg[,6], 2, algorithm="brute")
rmse.test <- sqrt(mean((res.test$pred-test[,6])^2))
rmse.test


#Obtenemos un error de RMS mucho más bajo en la partición de prueba que en la #validación. Por supuesto, esto no se puede confiar demasiado ya que nuestro #conjunto de datos es muy pequeño

#Variaciones KNN

t.idx <- createDataPartition(educacion$expense, p = 0.7, list = FALSE)
dest <- educacion[t.idx, ]
val <- educacion[-t.idx, ]
res1 <- knn.reg(trg[,7:12], test = NULL, y = trg[,6], k=2, algorithm="brute")
rmse <- sqrt(mean(res1$residuals^2))

#Creando una funcion 

rdacb.knn.reg <- function (trg_predictors, val_predictors, trg_target, val_target, k) {
  library(FNN)
  res <- knn.reg(trg_predictors, val_predictors, trg_target,
                 k, algorithm = "brute")
  errors <- res$pred - val_target
  rmse <- sqrt(mean(errors * errors))
  cat(paste("RMSE for k=", toString(k), ":", sep = ""), rmse,
      "\n")
  rmse
}


set.seed(1000)

t.idx <- createDataPartition(educacion$expense, p = 0.6, list = FALSE)
trg <- educacion[t.idx,]
rest <- educacion[-t.idx,]

set.seed(2000)

v.idx <- createDataPartition(rest$expense, p=0.5, list=FALSE)
val <- rest[v.idx,]
test <- rest[-v.idx,]
rdacb.knn.reg(trg[,7:12], val[,7:12], trg[,6], val[,6], 1)
rdacb.knn.reg(trg[,7:12], val[,7:12], trg[,6], val[,6], 2)


rdacb.knn.reg.multi <- function (trg_predictors, val_predictors, trg_target, val_target, start_k, end_k)
{
  rms_errors <- vector()
  for (k in start_k:end_k) {
    rms_error <- rdacb.knn.reg(trg_predictors, val_predictors,
                               trg_target, val_target, k)
    rms_errors <- c(rms_errors, rms_error)
  }

  plot(rms_errors, type = "o", xlab = "k", ylab = "RMSE")
  
  }


rdacb.knn.reg.multi(trg[,7:12], val[,7:12], trg[,6], val[,6], 1, 5)


