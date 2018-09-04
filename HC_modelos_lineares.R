#Modelos Lineares

#Desde el desarrollo original de Galton, la regresión se ha convertido en una de las herramientas más utilizadas en la ciencia de datos.

#Una razón para esto tiene que ver con el hecho de que la regresión nos permite encontrar relaciones entre dos variables mientras nos ajustamos a otras, como acabamos de mostrar para las bases por bolas y jonrones.

#Esto ha sido particularmente popular en los campos donde los experimentos aleatorizados son difíciles de ejecutar, como la economía y la epidemiología.

#Cuando no podemos asignar aleatoriamente a cada individuo a un grupo de tratamiento o control, la confusión es particularmente prevalente.

#Por ejemplo, considere estimar el efecto de cualquier comida rápida en la esperanza de vida utilizando datos recopilados de una muestra aleatoria de personas en alguna jurisdicción.

#Los consumidores de comida rápida tienen más probabilidades de ser fumadores, bebedores y tener ingresos más bajos.

#Por lo tanto, un modelo de regresión ingenuo puede conducir a una sobreestimación de un efecto negativo a la salud de las comidas rápidas.

#Entonces, ¿cómo nos ajustamos a los factores de confusión en la práctica?
  
#Podemos usar la regresión.

#Hemos descrito cómo, si los datos son muy normales, la expectativa condicional sigue una línea de regresión, que la expectativa condicional como una línea no es una suposición extra, sino más bien un resultado derivado de la suposición de que son aproximadamente muy normales .

#Sin embargo, en la práctica es común anotar explícitamente un modelo que describe la relación entre dos o más variables usando lo que se llama un modelo lineal.

#Sabemos que lineal aquí no se refiere exclusivamente a líneas, sino al hecho de que la expectativa condicional es una combinación lineal de cantidades conocidas.

#Cualquier combinación que los multiplica por una constante y luego los suma con, tal vez, un cambio.

#Por ejemplo, 2 más 3x menos 4y más 5z es una combinación lineal de x, y y z.

#Entonces beta 0 más beta 1x1, más beta 2x 2 es una combinación lineal de x1 y x2.

#El modelo lineal más simple es una constante beta 0.

#El segundo más simple es una línea, beta 0 más beta 1x.

#Para los datos de Galton, podríamos denotar y observar las alturas de los padres con x1 a través de xn.

#Luego, modelamos las alturas del hijo final que intentamos predecir con el siguiente modelo.

#Aquí, las pequeñas xi son las alturas del padre, que se fijan no al azar, debido al condicionamiento.

#Hemos condicionado estos valores.

#Y luego Yi Yi grande es la altura del hijo al azar que queremos predecir.

#Suponemos además que los errores que se denotan con la letra griega para E, epsilon, epsilon i, son independientes entre sí, tienen un valor esperado 0, y la desviación estándar, que generalmente se llama sigma, no depende de i.

#Es lo mismo para cada individuo.

#Conocemos el xi, pero para tener un modelo útil para la predicción, necesitamos beta 0 y beta 1.

#Estimamos esto a partir de los datos.

#Una vez que lo hacemos, podemos predecir las alturas de los hijos desde la altura de cualquier padre, x.

#Tenga en cuenta que si asumimos además que los épsilon se distribuyen normalmente, entonces este modelo es exactamente el mismo que derivamos anteriormente para la distribución normal bivariada.

#Una diferencia algo matizada es que en el primer enfoque, supusimos que los datos eran una normal bivariante, y el modelo lineal se derivó, no se asumió.

#En la práctica, los modelos lineales simplemente se suponen sin asumir necesariamente la normalidad.

#La distribución de los épsilon no está especificada.

#Sin embargo, si sus datos son bivariados normales, se mantiene el modelo lineal que acabamos de mostrar.

#Si sus datos no son bivariados normales, entonces deberá tener otras formas de justificar el modelo.

#Una razón por la cual los modelos lineales son populares es que son interpretables.

#En el caso de los datos de Galton, podemos interpretar los datos de esta manera.

#Debido a los genes heredados, la predicción de altura del hijo crece en beta 1 por cada pulgada; aumentamos la altura x del padre.

#Como no todos los hijos con padres de estatura x tienen la misma altura, necesitamos el término epsilon, que explica la variabilidad restante.

#Esta variabilidad restante incluye el efecto genético de la madre, los factores ambientales y otra aleatoriedad biológica.

#Tenga en cuenta que, dada la forma en que escribimos el modelo, la interceptación beta 0 no es muy interpretable, ya que es la altura prevista de un hijo con un padre sin altura.

#Debido a la regresión a la media, la predicción generalmente será un poco mayor que 0, lo que realmente no es muy interpretable.

#Para que el parámetro de interceptación sea más interpretable, podemos reescribir el modelo ligeramente de la siguiente manera.

#Aquí, hemos cambiado xi a xi menos la altura promedio x barra.

#Hemos centrado nuestra covariable xi.

#En este caso, beta 0, la intersección, sería la altura pronosticada para el padre promedio para el caso donde xi es igual a x bar.

#Ejercicios

library(tidyverse)
library(Lahman)
library(dslabs)
library(HistData)

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)

lm(son ~ father, data = galton_heights)


#Ejercicio No2

galton_heights <- galton_heights %>%
  mutate(father_centered=father - mean(father))


lm(son ~ father_centered, data = galton_heights)


#La altura de un hijo de un padre de estatura promedio es de 70.45 pulgadas.

