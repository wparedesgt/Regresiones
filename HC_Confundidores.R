#La correlación no es causación: confundidores

#Los confusores son quizás la razón más común que lleva a que las asociaciones se malinterpreten.

#Si X e Y están correlacionados, llamamos a Z un factor de confusión si los cambios en Z causan cambios tanto en X como en Y. Anteriormente, al estudiar datos de béisbol, vimos que los jonrones eran un factor de confusión que resultó en una mayor correlación de la esperada al estudiar la relación Entre bases por bolas y carreras.

#En algunos casos, podemos usar modelos lineales para explicar los factores de confusión, como lo hicimos en el ejemplo de béisbol.

#Pero no siempre es posible.

#Interpretación incorrecta debido a los factores de confusión son omnipresentes en la prensa laica.

#A veces son difíciles de detectar.

#Examinamos los datos de ingreso de las carreras de UC Berkeley de 1973 que mostraron que se estaban ingresando más hombres que mujeres.

#44% hombres fueron admitidos en comparación con 30% mujeres.

#Aquí están los datos.

#El porcentaje de hombres y mujeres que fueron aceptados se puede calcular a partir de estos datos utilizando este simple código.

#Una prueba estadística, la prueba de ji cuadrado que aprendimos en un curso anterior, rechaza claramente la hipótesis de que el género y las admisiones son independientes.

#El valor de p es muy pequeño.

#Pero una inspección más cercana muestra un resultado paradójico.

#Aquí están los porcentajes de admisiones por mayor.

#Cuatro de los seis mayores favorecen a las mujeres.

#Pero lo que es más importante, todas las diferencias son mucho más pequeñas que la diferencia del 14% que vemos al examinar los totales.

#La paradoja es que el análisis de los totales sugiere una dependencia entre las admisiones y el género.

#Pero cuando los datos se agrupan por mayor, esta dependencia parece desaparecer.

#¿Que esta pasando?
  
# Esto realmente puede suceder si un desconcertante sin contar está impulsando la mayor parte de la variabilidad.

#Entonces definamos tres variables.

#X es 1 para los hombres y 0 para las mujeres, Y es 1 para los admitidos y 0 en caso contrario, y Z cuantifica qué tan selectivo es el mayor.

#Una afirmación de sesgo de género se basaría en el hecho de que esta probabilidad es mayor cuando X es 1 que cuando X es 0.

#Pero Z es un importante factor de confusión.

#Claramente, Z está asociado con Y, porque cuanto más selectivo es un mayor, menor es la probabilidad de que alguien ingrese a ese mayor.

#Pero, ¿la mayor selectividad, que llamamos Z, se asocia con el género?
  
#Una forma de ver esto es trazar el porcentaje total admitido en un grado mayor versus el porcentaje de mujeres que conforman los solicitantes.

#Podemos ver eso en esta trama.

#Parece que hay una asociación.

#La trama sugiere que las mujeres eran mucho más propensas a aplicar a las dos grandes carreras.

#El género y la mayor selectividad se confunden.

#Compare, por ejemplo, mayor B y mayor E. Mayor E es mucho más difícil de ingresar que la mayor B. Y más del 60% de los solicitantes a la mayor E eran mujeres, mientras que menos del 30% de los principales de B eran mujeres.

#La siguiente gráfica muestra el porcentaje de solicitantes que fueron aceptados por género.

#El color aquí representa mayor.

#También desglosa las tasas de aceptación por mayor.

#El tamaño de la barra de color representa el porcentaje de cada uno de los principales estudiantes que fueron admitidos.

#Este desglose nos permite ver que la mayoría de los hombres aceptados provienen de dos grandes, A y B. También nos permite ver que pocas mujeres se aplican a estos dos grandes títulos.

#Lo que la trama no nos muestra es cuál es el porcentaje admitido por mayor.

#En esta gráfica, podemos ver que si condicionamos o estratificamos por mayor, y luego observamos las diferencias, controlamos el factor de confusión y el efecto desaparece.

#Ahora vemos que mayor por mayor, no hay mucha diferencia.

#El tamaño del punto representa el número de solicitantes y explica la paradoja.

#Vemos grandes puntos rojos y pequeños puntos azules para las mayores más fáciles, A y B.

#Si primero estratificamos por mayor, calculamos la diferencia y luego el promedio, encontramos que la diferencia porcentual es en realidad bastante pequeña.

#Este es en realidad un ejemplo de algo que se llama la paradoja de Simpson, que describiremos en el siguiente video.