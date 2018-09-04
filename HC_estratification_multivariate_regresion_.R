#Estratificación y regresión multivariante

#Para tratar de determinar si las bases por bolas todavía son útiles para hacer carreras, una primera aproximación es mantener los jonrones fijos en un cierto valor y luego examinar la relación entre carreras y bases por bolas.

#Como lo hicimos cuando estratificamos a los padres al redondear a la pulagada más cercana, aquí podemos estratificar los jonrones por juego al décimo más cercano.

#Filtramos nuestros estratos con pocos puntos.

#Usamos este código para generar un conjunto de datos informativos.




#Y luego, podemos hacer un diagrama de dispersión para cada estrato.

#Un diagrama de dispersión de carreras versus bases por bolas.

#Esto es lo que parece.

#Recuerde que la pendiente de regresión para predecir carreras con bases por bolas cuando ignoramos jonrones fue 0.735.

#Pero una vez que estratificamos por jonrones, estas pendientes se reducen sustancialmente.

#Podemos ver realmente cuáles son las pendientes usando este código.

#Estratificamos por cuadrangulares y luego calculamos la pendiente usando la fórmula que le mostramos anteriormente.

#Estos valores están más cerca de la pendiente que obtuvimos de singles, que es 0.449.

#Lo cual es más consistente con nuestra intuición.

#Dado que tanto los singles como las bases por bolas nos llevan a la primera base, deberían tener aproximadamente el mismo poder predictivo.

#Ahora, aunque nuestra comprensión de la aplicación (nuestra comprensión del béisbol) nos dice que los jonrones causan bases por bolas y no al revés, aún podemos verificar si, después de estratificar por base por bolas, todavía vemos un home run, o en efecto si se cae.

#Usamos el mismo código que acabamos de utilizar para las bases por bolas.

#Pero ahora, intercambiamos jonrones por bases por bolas para obtener esta trama.

#En este caso, las pendientes son las siguientes.

#Puedes ver que están alrededor de 1.5, 1.6, 1.7.

#Entonces no cambian mucho de la estimación original de la pendiente, que fue 1.84.

#A pesar de todo, parece que si estratificamos por jonrones, tenemos una distribución normal aproximadamente bivariada para carreras versus bases por bolas.

#De manera similar, si estratificamos por bases por bolas, tenemos una distribución bivariada aproximadamente normal para carreras versus jonrones.

#¿Asi que que hacemos?
  
#Es algo complejo calcular líneas de regresión para cada estrato.

#Básicamente estamos ajustando este modelo que puede ver en esta ecuación con las pendientes para x1 cambiando para diferentes valores de x2 y viceversa.

#Aquí, x1 es bases por bolas.

#Y x2 son jonrones.

#¿Hay un enfoque más fácil?
  
#Tenga en cuenta que si tenemos en cuenta la variabilidad aleatoria, las pendientes estimadas por estratos no parecen cambiar tanto.

#Si estas pendientes son de hecho las mismas, esto implica que esta función beta 1 de x2 y la otra función beta 2 de x1 son en realidad constantes.

#Lo cual, a su vez, implica que la expectativa de la condición de carreras en jonrones y bases por bolas se pueden escribir en este modelo más simple.

#Este modelo implica que si el número de jonrones es fijo, observamos una relación lineal entre carreras y bases por bolas.

#Y que la pendiente de esa relación no depende del número de jonrones.

#Solo la pendiente cambia a medida que aumenta el jonrón.

#Lo mismo es cierto si intercambiamos jonrones y bases por bolas.

#En este análisis, que se conoce como regresión multivariada, decimos que las bases por bolas con pendiente beta 1 se ajustan para el efecto de jonrones.

#Si este modelo es correcto, entonces se ha tenido en cuenta la confusión.

#Pero, ¿cómo estimamos beta 1 y beta 2 de los datos?
  
#Para esto, aprenderemos sobre los modelos lineales y las estimaciones de mínimos cuadrados.