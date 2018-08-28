#Cuarteto / estratificación de Anscombe

#La correlación no siempre es un buen resumen de la relación entre dos variables.

#Un ejemplo famoso usado para ilustrar esto es el siguiente para conjuntos de datos artificiales, llamados cuarteto de Anscombe.

#Todos estos pares tienen una correlación de 0.82.

#La correlación solo tiene sentido en un contexto particular.

#Para ayudarnos a comprender cuándo es que la correlación es significativa como una estadística de resumen, trataremos de predecir la altura del hijo utilizando la altura del padre.

#Esto ayudará a motivar y definir la regresión lineal.

#Comenzamos por demostrar cómo la correlación puede ser útil para la predicción.

#Supongamos que se nos pide que adivinemos la altura de un hijo seleccionado al azar.

#Debido a que la distribución de la altura del hijo es aproximadamente normal, sabemos que la altura promedio de 70.5 pulgadas es un valor con la proporción más alta y sería la predicción con la posibilidad de minimizar el error.

#Pero, ¿y si nos dicen que el padre mide 72 pulgadas?
  
#¿Todavía adivinamos 70.5 pulgadas para el hijo?
  
#El padre es más alto que el promedio, específicamente él es 1,14 desviaciones estándar más alto que el padre promedio.

#Entonces, debemos predecir que el hijo también tiene 1.14 desviaciones estándar más altas que el hijo promedio?
  
#Resulta que esto sería una sobreestimación.

#Para ver esto, miramos a todos los hijos con padres que son aproximadamente 72 pulgadas.

#Hacemos esto al estratificar el lado del padre.

#Llamamos a esto un promedio condicional, ya que estamos calculando la altura promedio de los hijos condicionada a que el padre tenga 72 pulgadas de alto.

#Un desafío al usar este enfoque en la práctica es que no tenemos muchos padres que sean exactamente 72.

#En nuestro conjunto de datos, solo tenemos ocho.

#Si cambiamos el número a 72.5, solo tendríamos un padre que tenga esa altura.

#Esto daría lugar a promedios con grandes errores estándar, y no serán útiles para la predicción por este motivo.

#Pero por ahora, lo que haremos es adoptar un enfoque de crear estratos de padres con alturas muy similares.

#Específicamente, redondearemos las alturas de los padres a la pulgada más cercana.

#Esto nos da la siguiente predicción para el hijo de un padre que mide aproximadamente 72 pulgadas de alto.

#Podemos usar este código y obtener nuestra respuesta, que es 71.84.

library(HistData)
library(dslabs)
library(tidyverse)

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)

conditional_avg <- galton_heights %>% filter(round(father) == 72) %>% 
  summarize(avg = mean(son)) %>% .$avg

conditional_avg


#Esto es 0.54 desviaciones estándar más grande que el hijo promedio, un número más pequeño que las 1.14 desviaciones estándar más altas que el padre estaba por encima del padre promedio.

#La estratificación seguida de diagramas de caja nos permite ver la distribución de cada grupo.

galton_heights %>% mutate(father_strata = factor(round(father))) %>% 
  ggplot(aes(father_strata, son)) +
  geom_boxplot() + 
  geom_point()


#Aquí está ese plot.

#Podemos ver que los centros de estos grupos están aumentando con la altura, como era de esperar.

#Los medios de cada grupo parecen seguir una relación lineal.

#Podemos hacer un plot así, con este código.

galton_heights %>% mutate(father = (round(father))) %>% 
  group_by(father) %>%
  summarize(son_conditional_avg = mean(son)) %>% 
  ggplot(aes(father, son_conditional_avg)) +
  geom_point()


#Vea el plot y observe que esto parece seguir una línea.

#La pendiente de esta línea parece ser aproximadamente 0.5, que es la correlación entre las alturas padre e hijo.

#Esto no es una coincidencia.

#Para ver esta conexión, trazamos las alturas estandarizadas una contra la otra, hijo versus padre, con una línea que tiene una pendiente igual a la correlación.

#Aquí está el código.

r <- galton_heights %>% summarize(r = cor(father, son)) %>% .$r 

galton_heights %>% mutate(father = (round(father))) %>% 
  group_by(father) %>%
  summarize(son = mean(son)) %>% 
  mutate(z_father = scale(father), z_son = scale(son)) %>%
  ggplot(aes(z_father, z_son)) +
  geom_point() + 
  geom_abline(intercept = 0, slope = r)


#Aquí hay un plot.

#Esta línea es lo que llamamos línea de regresión.

#En un video posterior, describiremos la justificación teórica de Galton para usar esta línea para estimar los medios condicionales.

#Aquí, lo definimos y lo calculamos para los datos disponibles.

#La línea de regresión para dos variables, xey, nos dice que por cada desviación estándar sigma x aumenta por encima del promedio mu x.

#Para x, y crece rho desviaciones estándar sigma y por encima de la media mu y.

#La fórmula para el [? origination?] line es por lo tanto este.

#Si existe una correlación perfecta, predecimos un aumento que es el mismo número de SD.

#Si hay una correlación cero, entonces no usamos x en absoluto para la predicción de y.

#Para valores entre 0 y 1, la predicción está en algún punto intermedio.

#Si la correlación es negativa, predecimos una reducción, en lugar de un aumento.

#Es porque cuando la correlación es positiva pero más baja que la que pronosticamos algo más cercano a la media, la llamamos regresión.

#El hijo regresa a la altura promedio.

#De hecho, el título del artículo de Galton fue "Regresión hacia la mediocridad en estatura hereditaria".

#Tenga en cuenta que si escribimos esto en la forma estándar de una línea, y es igual a b más mx, donde b es la intersección ym es la pendiente, la línea de regresión tiene una pendiente rho veces sigma y, dividida por sigma x e interceptar mu y , menos mu x, multiplicado por la pendiente.

#Entonces, si estandarizamos la variable entonces tienen un promedio de 0 y una desviación estándar 1.

#Luego, la línea de regresión tiene la intersección 0 y la pendiente igual a la correlación rho.

#Miremos los datos originales, los datos del hijo padre, y agreguemos la línea de regresión.

#Podemos calcular la intersección y la pendiente usando las fórmulas que acabamos de derivar.

mu_x <- mean(galton_heights$father)
mu_y <- mean(galton_heights$son)
s_x <- sd(galton_heights$father)
s_y <- sd(galton_heights$son)
r <- cor(galton_heights$father, galton_heights$son)
m <- r * s_y / s_x
b <- mu_y - m*mu_x

#Aquí hay un código para hacer la gráfica con la línea de regresión.

galton_heights %>% 
  ggplot(aes(father, son)) +
  geom_point(alpha = 0.5) + 
  geom_abline(intercept = b , slope = m)



#Si graficamos los datos en unidades estándar, entonces, como discutimos, la línea de regresión como intersección 0 y pendiente rho.

#Aquí está el código para hacer ese plot.

galton_heights %>% 
  ggplot(aes(scale(father), scale(son))) +
  geom_point(alpha = 0.5) + 
  geom_abline(intercept = 0 , slope = r)

#Comenzamos esta discusión diciendo que queríamos usar los medios condicionales para predecir las alturas de los hijos.

#Pero luego nos dimos cuenta de que había muy pocos puntos de datos en cada estrato.

#Cuando hicimos esta aproximación para redondear la altura de los padres, encontramos que estos medios condicionales parecen seguir una línea.

#Y terminamos con la línea de regresión.

#Entonces la línea de regresión nos da la predicción.

#Una ventaja de usar la línea de regresión es que usamos todos los datos para estimar solo dos parámetros, la pendiente y la intersección.

#Esto lo hace mucho más estable.

#Cuando hacemos medios condicionales, tenemos menos puntos de datos, lo que hace que las estimaciones tengan un gran error estándar y, por lo tanto, sean inestables.

#Entonces, esto nos va a dar una predicción mucho más estable usando la regresión línear.

#Sin embargo, ¿estamos justificados al usar la línea de regresión para predecir?
  
#Galton nos da la respuesta.


