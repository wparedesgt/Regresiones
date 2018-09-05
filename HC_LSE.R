#Estimaciones de mínimos cuadrados (LSE)

#Para que los modelos lineales sean útiles, debemos estimar los parámetros desconocidos, las betas.

#El enfoque estándar en la ciencia es encontrar los valores que minimizan la distancia del modelo ajustado a los datos.

#Para cuantificar, esto usamos la ecuación de mínimos cuadrados.

#Para datos [INAUDIBLE], escribiríamos algo como esto.

#Esta cantidad se llama Suma Residual de Cuadrados, RSS.

#Una vez que encontramos los valores que minimizan el RSS, llamamos a los valores la estimación de mínimos cuadrados, LSE, y los denotamos, en este caso, con beta 0 hat y beta 1 hat.

#Escribamos la función que calcula el RSS para cualquier par de valores, beta 0 y beta 1, para nuestros datos de alturas.


library(tidyverse)
library(Lahman)
library(dslabs)
library(HistData)

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)



#Se vería así.

rss <- function(beta0, beta1, data) {
  resid <- galton_heights$son - (beta0+beta1*galton_heights$father)
  return(sum(resid^2))
}


#Entonces, para cualquier par de valores, obtenemos un RSS.

#Entonces esta es una trama tridimensional con beta 1 y beta 2, y x y y y el RSS como una z.

#Para encontrar el mínimo, tendrías que mirar este diagrama tridimensional.

#Aquí, vamos a hacer una versión bidimensional manteniendo beta 0 fijo en 25.

#Por lo tanto, será una función del RSS como una función de beta 1.

#Podemos usar este código para producir este plot.

beta1 <- seq(0,1, len= nrow(galton_heights))

results <- data.frame(beta1 = beta1, 
                      rss = sapply(beta1, rss, beta0 = 25))

results %>% ggplot(aes(beta1, rss)) + geom_line() +
  geom_line(aes(beta1, rss), col = 2)


#Podemos ver un mínimo claro para la beta 1 en torno a 0,65.

#Para que pudieras ver cómo elegiríamos las estimaciones de mínimos cuadrados.

#Sin embargo, este mínimo es para beta 1 cuando beta 0 se fija en 25.

#Pero no sabemos si ese es el mínimo para beta 0.

#No sabemos si 25 karma 0.65 minimiza la ecuación en todos los pares.

#Podríamos usar prueba y error, pero realmente no va a funcionar aquí.

#En cambio usaremos cálculo.

#Tomaremos las derivadas parciales, las estableceremos en 0 y resolveremos para beta 1 y beta 0.

#Por supuesto, si tenemos muchos parámetros, estas ecuaciones pueden ser bastante complejas.

#Pero hay funciones en R que hacen estos cálculos para nosotros.

#Aprenderemos esto pronto.

#Para aprender las matemáticas detrás de esto, puede consultar el libro sobre modelos lineales.


#Ejercicio

beta1 = seq(0, 1, len=nrow(galton_heights))
results <- data.frame(beta1 = beta1,
                      rss = sapply(beta1, rss, beta0 = 36))
results %>% ggplot(aes(beta1, rss)) + geom_line() + 
  geom_line(aes(beta1, rss), col=2)

#En un modelo para las alturas de los hijos frente a las alturas de los padres, ¿cuál es la estimación de mínimos cuadrados (LSE) para si suponemos 36?