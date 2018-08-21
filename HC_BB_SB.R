#Comencemos a ver algunos datos de béisbol y tratemos de responder sus preguntas utilizando estos datos.

#Primero, ¿los equipos que batean más jonrones anotan más carreras?
  
#Sabemos cuál será la respuesta a esto, pero veamos los datos de todos modos.

#Vamos a examinar los datos de 1961 a 2001.

#Terminamos en 2001 porque, recuerde, estamos en 2002, preparándonos para formar un equipo.

#Empezamos en 1961, porque ese año, la liga cambió de 154 juegos a 162 juegos.

#La visualización de elección cuando se explora la relación entre dos variables, como home runs y runs, es un diagrama de dispersión.

#El siguiente código muestra cómo hacer ese diagrama de dispersión.

#Comenzamos cargando la biblioteca Lahman que tiene todas estas estadísticas de béisbol.

library(tidyverse)
library(Lahman)
library(dslabs)
data("Teams")


#Y luego simplemente hacemos un diagrama de dispersión usando ggplot.

ds_theme_set()

Teams %>% filter(yearID %in% 1961:2001) %>% 
  mutate(HR_per_game = HR/G, R_per_game = R/G) %>% 
  ggplot(aes(HR_per_game, R_per_game)) +
  geom_point(alpha = 0.5)



#Aquí hay una gráfica de carreras por juego versus jonrones por juego.

#La trama muestra que los equipos de asociación muy fuertes con más jonrones tendieron a anotar más carreras.

#Ahora, examinemos la relación entre las bases robadas y las victorias.

Teams %>% filter(yearID %in% 1961:2001) %>% 
  mutate(SB_per_game = SB/G, R_per_game = R/G) %>% 
  ggplot(aes(SB_per_game, R_per_game)) +
  geom_point(alpha = 0.5)


#Aquí están las carreras por juego trazadas contra bases robadas por juego.

#Aquí, la relación no es tan clara.

#Finalmente, examinemos la relación entre las bases por bolas y carreras.

#Aquí hay carreras por juego contra bases por bolas por juego.

Teams %>% filter(yearID %in% 1961:2001) %>% 
  mutate(BB_per_game = BB/G, R_per_game = R/G) %>% 
  ggplot(aes(BB_per_game, R_per_game)) +
  geom_point(alpha = 0.5)


#Aunque la relación no es tan fuerte como lo fue para los jonrones, sí vemos una relación bastante fuerte aquí.

#Sabemos que, por definición, los jonrones provocan carreras, porque cuando se llega a un jonrón, al menos una carrera puntuará.

#Ahora bien, es posible que los jonrones también causen problemas.

#Si entiendes el juego, estarás de acuerdo conmigo en que ese podría ser el caso.

#Entonces, puede parecer que una base por bola está causando carreras, cuando de hecho, son jonrones los que están causando ambas.

#Esto se llama confusión.

#Un concepto importante sobre el que aprenderá.

#La regresión lineal nos ayudará a analizar todo esto y cuantificar las asociaciones.

#Esto nos ayudará a determinar qué jugadores reclutar.

#Específicamente, trataremos de predecir cosas como cuántas carreras más anotará el equipo si aumentamos el número de bases en bolas pero mantenemos fijos los jonrones.

#La regresión también nos ayudará a responder esta pregunta.


#Ejercicios


Teams %>% filter(yearID %in% 1961:2001 ) %>%
  mutate(AB_per_game = AB/G, R_per_game = R/G) %>%
  ggplot(aes(AB_per_game, R_per_game)) + 
  geom_point(alpha = 0.5)

