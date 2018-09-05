#La funcion Im()

#En r, podemos obtener las estimaciones de mínimos cuadrados usando la función lm.

#Para ajustarse al siguiente modelo donde Yi es la altura del hijo y Xi es la altura del padre, escribiríamos el siguiente fragmento de código.

library(tidyverse)
library(Lahman)
library(dslabs)
library(HistData)

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)



fit <- lm(son ~ father, data = galton_heights)


fit


#Esto nos da las estimaciones de mínimos cuadrados, que podemos ver en la salida de r.

#La forma general en que usamos lm es mediante el uso del carácter tilde para que sepamos cuál es el valor que predecimos que está en el lado izquierdo de la tilde, y qué variables estamos usando para predecir que estarán en el lado derecho de la tilde

#La intersección se agrega automáticamente al modelo.

#Entonces no tiene que incluirlo cuando lo escribe.

#El ajuste del objeto que acabamos de calcular incluye más información sobre el ajuste de mínimos cuadrados.

#Podemos usar la función summary para extraer más de esta información, así.

summary(fit)


#Para comprender parte de la información incluida en este resumen, debemos recordar que las LSE son variables aleatorias.

#Las estadísticas matemáticas nos dan algunas ideas de la distribución de estas variables aleatorias.

#Y aprenderemos algo de eso a continuación.


#Ejercicio

#Realice un modelo lineal para predecir el numero de carreras por juego basado en el numero de bases por bolas y el numero de home runs, recuerde limitar la data entre 1961 y el 2001


data("Teams")

no_carreras <- Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(bb_per_game = R/BB, hr_per_game = R/HR) 

lm(bb_per_game ~ hr_per_game, data = no_carreras)  

lm(hr_per_game ~ bb_per_game, data = no_carreras)  
