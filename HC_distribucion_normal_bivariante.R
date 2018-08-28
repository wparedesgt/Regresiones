#Distribución normal bivariante

#La correlación y la línea de regresión son estadísticas de resumen ampliamente utilizadas.

#Pero a menudo se usa mal o se malinterpreta.

#Como el ejemplo proporcionó el ejemplo de conjuntos de datos en los que resumir con una correlación sería un error.

#Pero también lo vemos en los medios y en la literatura científica.

#La principal forma en que motivamos el uso de la correlación implica lo que se denomina distribución normal bivariada.

#Cuando un par de variables aleatorias se aproxima mediante una distribución normal bivariada, el diagrama de dispersión se parece a óvalos, como el fútbol americano.

#Pueden ser delgados

#Ahí es cuando tienen una alta correlación.

#Todo el camino hasta una forma de círculo cuando no tienen ninguna correlación.

#Vimos algunos ejemplos previamente.

#Aquí están de nuevo.


#Una forma más técnica para definir la distribución normal bivariada es la siguiente.

#Primero, esta distribución está definida para pares.

#Entonces tenemos dos variables, x y y.

#Y tienen valores emparejados.

#Van a ser bivariados distribuidos normalmente si sucede lo siguiente.

#Si x es una variable aleatoria distribuida normalmente, y y es también una variable aleatoria distribuida normalmente y para cualquier agrupación de x que podamos definir, digamos, con x que sea igual a un valor predeterminado, que llamamos aquí en esta fórmula poco x entonces las y en ese grupo son aproximadamente normales también.

#Si esto sucede, entonces el par es aproximadamente bivariante normal.

#Cuando arreglamos x de esta manera, nos referimos a la distribución resultante de y en el grupo definido estableciendo x de esta manera como la distribución condicional de y dada x.

#Escribimos la notación como esta para la distribución condicional y la expectativa condicional.

#Si pensamos que los datos de altura están bien aproximados por la distribución normal bivariada, entonces deberíamos ver la retención de aproximación normal para cada agrupación.

#Aquí, estratificamos la altura del hijo por las alturas estandarizadas del padre y vemos que la suposición parece mantenerse.

#Aquí está el código que nos da el plot deseado.


library(HistData)
library(dslabs)
library(tidyverse)

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)

galton_heights %>% 
  mutate(z_father = round((father - mean(father)) / sd(father))) %>% 
  filter(z_father %in% -2:2) %>%
  ggplot() +
  stat_qq(aes(sample = son)) +
  facet_wrap(~z_father)




#Ahora, volvemos a definir la correlación.

#Galton demostró usando estadísticas matemáticas que cuando dos variables siguen una distribución normal bivariada, entonces para cualquier x dada el valor esperado de y en pares para los cuales x se establece en ese valor es mu y más rho x menos mu x dividido por sigma x veces sigma y.

#Tenga en cuenta que esta es una línea con pendiente rho veces sigma y dividida por sigma x e interceptar mu y menos n veces mu x.

#Y por lo tanto, esto es lo mismo que la línea de regresión que vimos en un video anterior.

#Eso se puede escribir así.

#Entonces, en resumen, si nuestros datos son aproximadamente bivariados, entonces la xpectativa condicional cuál es la mejor predicción para y dado que sabemos que el valor de x viene dado por la línea de regresión.