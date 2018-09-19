#Falacia de Regresion

#Wikipedia define la depresión de segundo año de la siguiente manera.

#Un nerviosismo de segundo o segundo año de jinx o sophomore se refiere a una instancia en la cual un segundo esfuerzo o un segundo no logran estar a la altura del primer esfuerzo.

#Se utiliza comúnmente para referirse a la apatía de los estudiantes de segundo año de la escuela secundaria, la universidad, la actuación de los atletas segunda temporada de los cantantes / bandas del segundo álbum de programas de televisión segunda temporada y secuelas o precuelas de películas.

#Escuchamos acerca de la depresión de segundo año a menudo en Major League Baseball.

#Esto se debe a que en Major League Baseball, el Novato del Año, este es un premio que se le otorga al jugador de primer año que se considera que tuvo el mejor rendimiento y que generalmente no rinde tan bien durante su segundo año.

#Por lo tanto, llaman a esto la depresión de segundo año.

#Sepa, por ejemplo, que en un artículo reciente de Fox Sports que preguntaron, ¿la tremenda clase de novatos de MLB de 2015 sufrirá una depresión de segundo año?
  
#Ahora, ¿los datos confirman la existencia de una depresión de segundo año?
  
#Echemos un vistazo y examinemos los datos de los promedios de bateo para ver si la observación es cierta.

#Los datos están disponibles en [? Lehman?] [? Biblioteca,?] Pero tenemos que trabajar un poco para crear una tabla con las estadísticas de todos los novatos del año.

#Repasemoslos.

#Primero, creamos una tabla con ID de jugador, sus nombres y su posición más jugada, usando este código.

#Ahora crearemos una tabla con solo los ganadores del Premio Novato del Año y agregaremos sus estadísticas de bateo.

#Vamos a filtrar a los lanzadores ya que los lanzadores no reciben premios por batear.

#Y nos enfocaremos en la ofensiva.

#Específicamente, nos enfocaremos en el promedio de bateo, ya que es el resumen del que hablan la mayoría de los expertos cuando hablan sobre la depresión de segundo año.

#Así que escribimos este fragmento de código para hacer esto.

#Ahora solo conservaremos las temporadas de novato y segundo año y eliminaremos a los jugadores que no jugaron una temporada de segundo año.

#Y recuerde, ahora solo estamos mirando a los jugadores que ganaron el premio al Novato del Año.

#Este código logra lo que queremos.

#Finalmente, usaremos la función de dispersión para tener una columna para el novato y otra columna para los promedios de bateo de los estudiantes de segundo año.

#Para eso usamos esta simple línea de código.

#Ahora podemos ver a los mejores jugadores en su primer año.

#Estos son los ganadores del Premio Novato del Año.

#Y estamos mostrando su promedio de bateo de la temporada de novatos y su promedio de bateo de la temporada de segundo año.

#Mire de cerca y verá la depresión de segundo año.

#Definitivamente parece ser real.

#De hecho, la proporción de jugadores que tienen un promedio de bateo menor en sus años de segundo año es del 68%.

#Entonces, ¿es nervioso?
  
#¿Es una maldición?
  
#Para responder a esta pregunta, volvamos nuestra atención a todos los jugadores.

#Vamos a ver la temporada 2013 y la temporada 2014.

#Y vamos a ver a los jugadores que batearon al menos 130 veces.

#Este es un mínimo necesario para ganar el Novato del Año.

#Vamos a realizar una operación similar a la que hicimos antes para construir este conjunto de datos.

#Aquí está el código.

#Ahora veamos los mejores resultados de 2013 y luego veamos su desempeño en 2014.

#Tenga en cuenta que el mismo patrón surge cuando observamos los mejores resultados.

#Los promedios de bateo disminuyen para los mejores.

#Pero estos no son novatos.

#Entonces esto no se puede explicar con una depresión de segundo año.

#También sé lo que les sucede a los peores ejecutantes de 2013.

#Aquí están.

#Sus promedios de bateo aumentan en su segunda temporada en 2014.

#¿Es esto una especie de recesión de segundo año inverso?
  
#No lo es.

#No hay tal cosa como una depresión de segundo año.

#Todo esto se explica con un simple hecho estadístico.

#La correlación del rendimiento en dos años separados es alta pero no perfecta.

#Aquí están los datos del rendimiento de 2013 y el rendimiento de 2014.

#Puedes ver que está correlacionado.

#Pero no está perfectamente correlacionado.

#La correlación es 0.46.

#Los datos se parecen mucho a una distribución normal bivariada, lo que significa que si tuviéramos que predecir el promedio de bateo de 2014, llamémoslo y, para cualquier jugador dado que tuviera un promedio de bateo de 2013 de x, usaríamos la ecuación de regresión, que sería esto.

#Debido a que la correlación no es perfecta, la regresión nos dice que, en promedio, esperamos que los estudiantes de alto rendimiento a partir de 2013 empeoren un poco en 2014.

#Esta regresión a la media.

#No es una maldición.

#Es solo por casualidad.

#Los novatos del año se seleccionan de los mejores valores de x

#Por lo tanto, se espera que su y regrese a la media.