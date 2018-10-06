#La correlación no es causación: correlación espuria

#La correlación no es la causación es quizás la lección más importante que uno aprende en una clase de estadística.

#En este curso, hemos descrito herramientas útiles para cuantificar asociaciones entre variables, pero debemos tener cuidado de no interpretar en exceso estas asociaciones.

#Hay muchas razones por las cuales una variable x puede correlacionarse con una variable y, sin que sea una causa para la otra.

#Aquí examinamos formas comunes que pueden conducir a una mala interpretación de las asociaciones.

#El primer ejemplo de cómo podemos malinterpretar las asociaciones son correlaciones espurias.

#El siguiente ejemplo cómico subraya que la correlación no es causación.

#El ejemplo muestra una fuerte correlación entre las tasas de divorcio y el consumo de margarina.

#La correlación es de 0.93.

#¿Esto significa que la margarina causa divorcios, o los divorcios hacen que las personas coman más margarina?
  
#Por supuesto, la respuesta a estas dos preguntas es no.

#Este es solo un ejemplo de lo que llamamos correlaciones espurias.

#Puede ver muchos, muchos más ejemplos observados en este sitio web completamente dedicado a correlaciones espurias.

#De hecho, ese es el título del sitio web.

#Los casos presentados en el sitio de correlación espuria son ejemplos de lo que generalmente se denomina dragado de datos, o phishing de datos, o espionaje de datos.

#Básicamente es una forma de lo que en los Estados Unidos, llaman recolección de cerezas.

#Un ejemplo de dragado de datos sería si analiza muchos resultados producidos por un proceso aleatorio y selecciona el que muestra una relación que respalda la teoría que desea defender.

#Se puede usar una simulación de Monte Carlo para mostrar cómo el dragado de datos puede dar como resultado la búsqueda de altas correlaciones entre variables que no están correlacionadas teóricamente.

#Guardaremos los resultados de una simulación en una tabla como esta.

#La primera columna indica grupo y simulamos un millón de grupos, cada uno con 25 observaciones.

#Para cada grupo, generamos 25 observaciones que se almacenan en la segunda y tercera columna.

#Estos son datos aleatorios, independientes y normalmente distribuidos.

#Así que sabemos, porque construimos la simulación, que xey no están correlacionadas.

#A continuación, calculamos la correlación entre x e y para cada grupo y buscamos el máximo.

#Aquí están las principales correlaciones.

#Si solo trazamos los datos de este grupo en particular, muestra un argumento convincente de que xey están, de hecho, correlacionados.

#Pero recuerda que el número de correlaciones es una variable aleatoria.

#Aquí está la distribución que acabamos de generar con nuestra simulación de Monte Carlo.

#Es solo un hecho matemático que si observamos correlaciones aleatorias que se espera que sean 0, pero que tengan un error estándar de aproximadamente 0.2, la más grande estará cerca de 1 si seleccionamos entre un millón.

#Tenga en cuenta que si realizamos la regresión en este grupo e interpretamos el valor p, afirmaríamos incorrectamente que se trataba de una relación estadísticamente significativa.

#Aquí está el código.

#Mira qué pequeño es el valor de p.

#Esta forma particular de dragado de datos se conoce como p-hacking.

#El pirateo es un tema de mucha discusión porque es un problema en publicaciones científicas.

#Debido a que los editores tienden a recompensar los resultados estadísticamente significativos sobre los resultados negativos, hay un incentivo para reportar resultados significativos.

#En epidemiología en las ciencias sociales, por ejemplo, los investigadores pueden buscar asociaciones entre un resultado promedio y varias exposiciones, e informar solo la exposición que resultó en un valor p pequeño.

#Además, podrían intentar adaptar varios modelos diferentes para ajustarlos para confundir y elegir el modelo que produzca el valor p más pequeño.

#En las disciplinas experimentales, un experimento puede repetirse más de una vez, y solo se informa el que resulta en un valor p pequeño.

#Esto no necesariamente sucede debido a un comportamiento poco ético, sino más bien a la ignorancia estadística o al pensamiento ilusorio.

#En los cursos avanzados de estadística, aprenderá métodos para ajustar lo que se llama el problema de comparación múltiple.