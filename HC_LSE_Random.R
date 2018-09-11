#LSE  are Random Variables


#Los LSE se derivan de los datos, Y1 a Yn, que son aleatorios.

#Esto implica que nuestras estimaciones son variables aleatorias.

#Para ver esto, podemos ejecutar una simulación de Monte Carlo en la cual suponemos que los datos de altura del hijo y padre que tenemos definen una población completa.

#Y vamos a tomar muestras aleatorias de tamaño 50 y calcular el coeficiente de la pendiente de regresión para cada una.

#Escribimos este código, que nos da varias estimaciones de la pendiente de regresión.

library(tidyverse)
library(dslabs)
library(HistData)

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)

B <- 1000
N <- 50
lse <- replicate(B, {
  sample_n(galton_heights, N, replace = TRUE) %>%
  lm(son ~ father, data = .) %>% .$coef})

lse <- data.frame(beta_0 = lse[1,], beta_1 = lse[2,])



#Podemos ver la variabilidad de las estimaciones al plotear su distribución.

library(gridExtra)
p1 <- lse %>% ggplot(aes(beta_0)) + geom_histogram(binwidth = 5, color = 'black')
p2 <- lse %>% ggplot(aes(beta_1)) + geom_histogram(binwidth = 0.1, color = 'black')

grid.arrange(p1, p2, ncol = 2)



#Aquí puede ver los histogramas de los estimados beta 0 y los estimados beta 1.

#La razón por la que se ven normales es porque también aquí se aplica el teorema del límite central.

#Para un N suficientemente grande, las estimaciones de mínimos cuadrados serán aproximadamente normales con el valor esperado beta 0 y beta 1 respectivamente.

#Los errores estándar son un poco complicados de computar, pero la teoría matemática nos permite calcularlos, y se incluyen en el resumen proporcionado por la función lm.

#Aquí están los errores estándar estimados para uno de nuestros conjuntos de datos simulados.

sample_n(galton_heights, N, replace = TRUE) %>% 
  lm(son ~ father, data = .) %>% summary()


#Podrías verlos en la segunda columna en la tabla de coeficientes.

#Puede ver que las estimaciones de errores estándar informadas por la función de resumen están cerradas, por lo que los errores estándar que obtenemos de nuestra simulación de Monte Carlo.

lse %>% summarize(se_0 = sd(beta_0), se_1 = sd(beta_1))

#La función de resumen también informa t-statistics esta es la columna del valor t y los valores p.

#Este es el Pr más grande que el valor absoluto de la columna t.

#La estadística t en realidad no se basa en el teorema del límite central, sino en el supuesto de que los épsilon siguen una distribución normal.

#Bajo esta suposición, la teoría matemática nos dice que la LSE dividida por su error estándar, que podemos ver aquí y aquí, sigue en distribución con N menos p grados de libertad, con p el número de parámetros en nuestro modelo, que en este caso es 2.

#Los valores 2p están probando la hipótesis nula de que beta 0 es 0 y beta 1 es 0, respectivamente.

#Tenga en cuenta que, como describimos anteriormente, para un N suficientemente grande, el límite central funciona, y la distribución t se vuelve casi la misma que una distribución normal.

#Entonces, si usted supone que los errores son normales y usa la distribución t, o si supone que N es lo suficientemente grande como para usar el teorema del límite central, puede construir intervalos de confianza para sus parámetros.

#Sabemos aquí que aunque no mostraremos ejemplos en este video, las pruebas de hipótesis para los modelos de regresión se usan muy comúnmente en, por ejemplo, epidemiología y economía, para hacer afirmaciones tales como el efecto de A y B fue estadísticamente significativo después del ajuste para X , Y y Z.

#Pero es muy importante tener en cuenta que varias suposiciones que acabamos de describir algunas de ellas tienen que sostener para que estas declaraciones se mantengan.

#Ejercicios


#In an earlier video, we ran the following linear model and looked at a summary of the results.
mod <- lm(son ~ father, data = galton_heights)
summary(mod)
