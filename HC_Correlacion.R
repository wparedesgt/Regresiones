#Correlacion

#Hasta ahora en esta serie, nos hemos centrado principalmente en variables univariadas.

#Sin embargo, en la aplicación de ciencia de datos, es muy común estar interesado en la relación entre dos o más variables.

#Vimos esto en nuestro ejemplo de béisbol en el que estábamos interesados en la relación, por ejemplo, entre bases por bolas y carreras.

#volveremos a este ejemplo, pero presentamos los conceptos de correlación y regresión usando un ejemplo más simple.

#En realidad, es el conjunto de datos del que nació la regresión.

#Examinamos un ejemplo de genética.

#Francis Galton estudió la variación y la herencia de los rasgos humanos.

#Entre muchos otros rasgos, Galton recopiló y estudió datos de altura de las familias para tratar de comprender la herencia.

#Al hacer esto, desarrolló los conceptos de correlación y regresión, y una conexión a pares de datos que siguen una distribución normal.

#Tenga en cuenta que, en el momento en que se recopilaron estos datos, aún no se conoce lo que sabemos hoy sobre genética.

#Una pregunta muy específica que Galton trató de responder fue, cuánto de la altura de un hijo, puedo predecirla con la altura de los padres

#Tenga en cuenta que esto es similar a la predicción de carreras con bases por bolas.

#Tenemos acceso a los datos familiares de Galton a través del paquete HistData.

library(dslabs)
library(HistData)

#HistData significa datos históricos.

#Crearemos un conjunto de datos con las alturas de los padres y los primeros hijos.

#Los datos reales que Galton utilizó para descubrir y definir la regresión.

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)


#Entonces tenemos los datos de altura del padre y el hijo.

#Supongamos que debemos resumir estos datos.

#Dado que ambas distribuciones se aproximan bien por distribuciones normales, podemos usar los dos promedios y las dos desviaciones estándar como resúmenes.

#Aquí están.

galton_heights %>% 
  summarize(mean(father), sd(father), mean(son), sd(son))


#Puedes ver que la altura promedio para los padres es de 69 pulgadas.

#La desviación estándar es 2.54.

#Para los hijos varones, son un poco más altos, porque es la próxima generación.

#La altura promedio es 70.45 pulgadas, y la desviación estándar es 2.55 pulgadas.

#Sin embargo, este resumen no describe una característica muy importante de los datos que puede ver en esta figura.

galton_heights %>% ggplot(aes(father, son)) + 
  geom_point(alpha = 0.5)

#La tendencia es que cuanto más alto es el padre, más alto es el hijo, no se describe mediante las estadísticas de resumen del promedio y la desviación estándar.

#Aprenderemos que el coeficiente de correlación es un resumen de esta tendencia.