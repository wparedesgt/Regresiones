library(tidyverse)
library(ggthemes)

##Cargando el CSV

datos <- read.csv("data/rmse.csv")
rmse <- sqrt(mean((datos$price-datos$pred)^2))

datos %>% ggplot(aes(price, pred, color = pred)) + geom_point() + xlab("Actual") + ylab("Pronostico") + theme_economist() 


ggsave("plots/PronosticoPrecios.PNG")


