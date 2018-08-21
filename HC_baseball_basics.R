#En realidad, no es necesario que comprendamos todos los detalles sobre el juego de béisbol, que cuenta con más de 100 reglas, para ver cómo la regresión nos ayudará a encontrar jugadores infravalorados.

#Aquí, destilamos el deporte al conocimiento básico que uno necesita saber para atacar con eficacia el desafío de la ciencia de datos.

#Empecemos.

#El objetivo de un juego de béisbol es anotar más carreras, son como puntos, que el otro equipo.

#Cada equipo tiene nueve bateadores que batean en un orden predeterminado.

#Después de que llega el noveno bateador, comenzamos con el primero otra vez.

#Cada vez que vienen a batear, lo llamamos apariencia de placa, PA.

#En cada aparición de plato, el lanzador del otro equipo lanza la pelota e intentas golpearla.

#La apariencia de la placa termina con un resultado binario, ya sea que hagas una salida, que es un fracaso y vuelvas a sentarte, o no, eso es un éxito y puedes correr alrededor de las bases y potencialmente anotar una carrera.

#Cada equipo recibe nueve intentos, referidos como entradas, para anotar carreras.

#Cada entrada termina después de tres outs, después de haber fallado tres veces.

#A partir de estos ejemplos, vemos cómo la suerte está involucrada en el proceso.

#Cuando bateas quieres golpear la pelota con fuerza.

#Si lo golpeas lo suficiente, es un jonrón, el mejor resultado posible al obtener al menos una ejecución automática.

#Pero a veces, por casualidad, golpeas el balón con fuerza y un defensor lo atrapa, lo que lo convierte en un out, un fracaso.

#En contraste, a veces golpeas la pelota suavemente pero aterriza justo en el lugar correcto.

#Recibes un golpe que es un éxito.

#El hecho de que haya posibilidades implica pistas de por qué los modelos de probabilidad se verán involucrados en todo esto.

#Ahora hay varias formas de tener éxito.

#Comprender esta distinción será importante para nuestro análisis.

#Cuando golpeas la pelota quieres pasar tantas bases como sea posible.

#Hay cuatro bases con el cuarto llamado home plate.

#El plato principal es donde comienzas, donde intentas golpear.

#Entonces las bases forman un ciclo.

#Si llegas a home, anotas una carrera.

#Nos estamos simplificando un poco.

#Pero hay cinco formas en que puede tener éxito.

#En otras palabras, no hacer una salida.

#El primero se llama base por bolas.

#Aquí es cuando el lanzador no lanza bien y tienes que ir a la primera base.

#Un sencillo es cuando golpeas la pelota y llegas a la primera base.

#Un doble es cuando golpeas la pelota y pasas de la primera base a la segunda.

#Triple es cuando haces eso pero llegas a la tercera.

#Y un jonrón es cuando golpeas la pelota e ir todo el camino a home y anotar una carrera.

#Si llegas a una base, todavía tienes la posibilidad de llegar a home y anotar una carrera si el siguiente bateador batea con éxito.

#Mientras estás en la base, también puedes intentar robar una base.

#Si corres lo suficientemente rápido, puedes intentar pasar del primero al segundo o del segundo al tercero sin que el otro equipo te etiquete.

#Todo bien.

#Históricamente, el promedio de bateo ha sido considerado la estadística ofensiva más importante.

#Para definir este promedio, definimos un hit y un bate.

#Singles, dobles, triples y jonrones son éxitos.

#Pero recuerda, hay una quinta forma de tener éxito, la base por bolas.

#Eso no es un golpe.

#Un turno al bate es la cantidad de veces que recibe  das un hit o un out, las bases por bolas están excluidas.

#El promedio de bateo es simplemente éxitos divididos por turnos al bate.

#Y se considera la medida principal de una tasa de éxito.

#Hoy, en el juego de hoy, estas tasas de éxito varían de jugador a jugador de aproximadamente 20% a 38%.

#Nos referimos al promedio de bateo en miles.

#Entonces, por ejemplo, si su tasa de éxito es del 25%, decimos que está bateando 250.

#Una de las primeras ideas importantes de Bill James es que el promedio de bateo ignora las bases por bolas, pero las bases por bolas es un éxito.

#Por lo tanto, un jugador que obtiene muchas más bases por bolas que el jugador promedio podría no ser reconocido si no se destaca en el promedio de bateo.

#Pero, ¿este jugador no está ayudando a producir carreras?
  
#No se otorga ningún premio al jugador con más bases en las bolas.

#Por el contrario, el número total de bases robadas se considera importante y se otorga una recompensa al jugador con más.

#Pero los jugadores con altos totales de bases robadas también salen, ya que no siempre tienen éxito.

#Entonces, ¿un jugador con una gran base total robada ayuda a producir carreras?
  
#¿Podemos usar el tamaño de los datos para determinar si es mejor pagar bases en bolas o bases robadas?
  
#Uno de los desafíos en este análisis es que no es obvio cómo determinar si un jugador produce carreras porque tanto depende de sus compañeros de equipo.

#Sí llevamos un registro del número de carreras anotadas por nuestro jugador.

#Pero ten en cuenta que un jugador que hace hits y  muchos jonrones, anotarás muchas carreras.

#Pero estas carreras no necesariamente suceden si contratamos a este jugador pero no a su compañero de equipo de home run.

#Sin embargo, podemos examinar las estadísticas de nivel de equipo.

#¿Cómo se comparan los equipos con muchas bases robadas con los equipos con pocos?
  
#¿Qué hay de las bases por bolas?
  
#Tenemos datos.

#Examinemos algunos.