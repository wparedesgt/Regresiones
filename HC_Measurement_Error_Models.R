#Modelos de error de medición

Hasta ahora, todos nuestros ejemplos de regresión lineal se han aplicado a dos o más variables aleatorias.

Suponemos que los pares son bivariados normales y usamos esto para motivar un modelo lineal.

Este enfoque cubre la mayoría de los ejemplos de la vida real donde se usa la regresión lineal.

La otra aplicación principal proviene de modelos de error de medición.

En estas aplicaciones, es común tener covariables no aleatorias, como el tiempo.

Y la aleatoriedad se introduce a partir del error de medición, en lugar del muestreo o la variabilidad natural.

Para comprender estos modelos, vamos a utilizar un ejemplo de motivación relacionado con la física.

Imagina que eres Galileo en el siglo XVI tratando de describir la velocidad de un objeto que cae.

Un asistente sube la Torre de Pisa y deja caer una pelota.

Mientras que muchos otros asistentes registran la posición en diferentes momentos.

El conjunto de datos del objeto que cae contiene un ejemplo de cómo se verían esos datos.

El asistente entrega los datos a Galileo y esto es lo que ve.

Él usa ggplot para hacer una trama.

Aquí vemos la distancia en metros que ha caído en el eje y y el tiempo en el eje x.

Galileo no conoce la ecuación exacta, pero a partir de la exploración de datos, al observar la trama, deduce que la posición debe seguir una parábola, que podemos escribir así.

Los datos no caen exactamente en una parábola, pero Galileo sabe que esto se debe a un error de medición.

Sus ayudantes se equivocan al medir la distancia que ha caído la pelota.

Para dar cuenta de esto, escribimos este modelo.

Aquí, y representa la distancia que la bola se deja caer en metros.

Xi representa el tiempo en segundos.

Y epsilon representa un error de medición.

Se supone que el error de medición es aleatorio, independiente entre sí y que tiene la misma distribución de cada ojo.

También suponemos que no hay sesgo, lo que significa que el valor esperado de épsilon es 0.

Tenga en cuenta que este es un modelo lineal porque es una combinación lineal de cantidades conocidas.

X y x al cuadrado son parámetros conocidos y desconocidos, los betas.

A diferencia de nuestro ejemplo anterior, las x son cantidades fijas.

Esto es solo tiempo.

No estamos condicionando.

Ahora para plantear una nueva teoría física y comenzar a hacer predicciones sobre otros objetos que caen, Galileo necesita números reales, en lugar de los parámetros desconocidos.

Las estimaciones de LSE squares parecen un enfoque razonable.

Entonces, ¿cómo encontramos las estimaciones de cuadrados LSE?
  
  Tenga en cuenta que los cálculos de LSE no requieren que los errores sean aproximadamente normales.

La función lm () encontrará las betas que minimizan la suma residual de cuadrados, que es lo que queremos.

Entonces usamos este código para obtener nuestros parámetros estimados.

Para verificar si la parábola estimada se ajusta a los datos, el aumento de la función de escoba () nos permite hacerlo fácilmente.

Usando este código, podemos hacer la siguiente gráfica.

Tenga en cuenta que los valores predichos van directo a través de los puntos.

Ahora, gracias a mi profesor de física de la escuela secundaria, sé que la ecuación para la trayectoria de un objeto que cae es la siguiente.

Con h0 y v0, la altura de inicio y la velocidad de inicio respectivamente.

Los datos que usamos siguen esta ecuación y agregan un error de medición para simular y observar.

Dejar caer la pelota, eso significa que la velocidad de inicio es 0 porque comenzamos simplemente cayéndola desde la Torre de Pisa, que tiene una altura de aproximadamente 56.67 metros.

Estas cantidades conocidas son consistentes con los parámetros que estimamos, que podemos ver usando la función de ordenado.

Aquí están.

La altura de la Torre de Pisa está dentro del intervalo de confianza para beta 0.

La velocidad inicial de 0 está en el intervalo de confianza para beta 1.

Tenga en cuenta que el valor de p es mayor que 0.05, lo que significa que no rechazaríamos la hipótesis de que la velocidad de inicio es 0.

Y finalmente, la constante de aceleración está en los intervalos de confianza para 2 veces negativo beta 2.