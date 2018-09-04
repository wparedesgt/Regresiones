#Dos lineas de regresion

#Calculamos una línea de regresión para predecir la altura del hijo desde la altura del padre.

#Usamos estos cálculos aquí está el código para obtener la pendiente y el intercepto.

library(HistData)
library(dslabs)
library(tidyverse)

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)


mu_x <- mean(galton_heights$father)
mu_y <- mean(galton_heights$son)
s_x <- sd(galton_heights$father)
s_y <- sd(galton_heights$son)
r <- cor(galton_heights$father, galton_heights$son)
m <- r * s_y / s_x
b <- mu_y - m*mu_x

#Esto nos da la función de que la expectativa condicional de y dada x es 35.7 más 0.5 veces x.

#Entonces, ¿qué pasaría si quisiéramos predecir la altura del padre basada en la del hijo?
  
#Es importante saber que esto no se determina calculando la función inversa de lo que acabamos de ver, que sería esta ecuación aquí.

#Necesitamos calcular el valor esperado de x dado y.

#Esto nos da otra función de regresión, con pendiente e intersección calculadas así.

m <-  r * s_x / s_y
b <- mu_y - m*mu_y


#Entonces ahora obtenemos que el valor esperado de x dado y, o el valor esperado de la altura del padre dada la altura del hijo, es igual a 34 más 0.5 y, una línea de regresión diferente.

#Entonces, en resumen, es importante recordar que la línea de regresión proviene de las expectativas informáticas, y éstas le dan dos líneas diferentes, dependiendo de si calcula la expectativa de y dado x o x dado y.