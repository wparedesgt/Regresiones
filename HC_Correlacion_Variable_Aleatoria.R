#Ejemplo de Correlacion como una variable aleatoria

library(dslabs)
library(HistData)

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)

#Antes de continuar describiendo la regresión, repasemos un recordatorio sobre la variabilidad aleatoria.

#En la mayoría de las aplicaciones de ciencia de datos, no observamos la población, sino más bien una muestra.

#Al igual que con el promedio y la desviación estándar, la correlación de la muestra es la estimación más comúnmente utilizada de la correlación de la población.

#Esto implica que la correlación que calculamos y usamos como un resumen es una variable aleatoria.

#Como ilustración, supongamos que los 179 pares de padres e hijos son toda nuestra población.

#Un genetista menos afortunado solo puede darse el lujo de tomar una muestra aleatoria de 25 pares.

#La correlación de muestra para esta muestra aleatoria se puede calcular utilizando este código.

set.seed(0)

R <- sample_n(galton_heights, 25, replace = TRUE)


#Aquí, la variable R es la variable aleatoria.

#Podemos ejecutar una simulación monte-carlo para ver la distribución de esta variable aleatoria.

#Aquí, recreamos R 1000 veces y trazamos su histograma.

B <- 1000
N <- 50
R <- replicate(B, {
  sample_n(galton_heights, N, replace = TRUE) %>%
    summarize(r= cor(father, son)) %>% .$r
  
})

data.frame(R) %>% ggplot(aes(R)) + geom_histogram(binwidth = 0.05, color = "black")


#Vemos que el valor esperado es la correlación de la población, la media de estos Rs es 0.5 y que tiene un error estándar relativamente alto en relación con su tamaño, SD 0.147.

mean(R)
sd(R)

#Esto es algo a tener en cuenta al interpretar las correlaciones.

#Es una variable aleatoria y puede tener un error estándar bastante grande.

#También tenga en cuenta que debido a que la correlación de la muestra es un promedio de sorteos independientes, en realidad se aplica el Teorema del Límite Central.

#Por lo tanto, para un tamaño de muestra suficientemente grande N, la distribución de estos R es aproximadamente normal.

#El valor esperado que conocemos es la correlación de la población.

#La desviación estándar es algo más compleja de derivar, pero esta es la fórmula real aquí.

#En nuestro ejemplo, N es igual a 25, no parece ser lo suficientemente grande como para hacer que la aproximación sea buena, como vemos en esto.