#En un video anterior, encontramos que la pendiente de la línea de regresión para predecir carreras desde bases por bolas fue 0.735.

#Entonces, ¿esto significa que si vamos a los jugadores de mayor salario bajo con muchas bases por bolas, aumenta el número de carreras por juego para nuestro equipo?
  
#Nuestro equipo obtendrá 1.47 carreras más por juego.

#Nuevamente se nos recuerda que la asociación no es causalidad.

#Los datos proporcionan una fuerte evidencia de que un equipo con 2 bases por bolas más por partido que el equipo promedio obtiene 1.47 más carreras por juego, pero esto no significa que las bases por bolas sean la causa.

#Si calculamos la pendiente de la línea de regresión para sencillos, obtenemos 0.449, un valor más bajo.

#Tenga en cuenta que un solo te lleva a la primera base al igual que una base por bolas.

#Aquellos que saben un poco más sobre el béisbol le dirán que con un solo hit, los corredores que están en la base tienen más posibilidades de anotar que con una base por bolas.

#Entonces, ¿cómo pueden las bases por bolas ser más predictivas de carreras?
  
#La razón por la que esto sucede es debido a la confusión.

#Tenga en cuenta la correlación entre Homeruns, bases por bolas y singles.

library(tidyverse)
library(Lahman)
library(dslabs)
data("Teams")

Teams %>% 
  filter(yearID %in% 1961:2001)  %>% 
  mutate(Singles = (H-HR-X2B-X3B)/G, BB = BB/G, HR= HR/G) %>% 
  summarize(cor(BB, HR), cor(Singles, HR), cor(BB, Singles))
  


#Vemos que la correlación entre bases por bolas y jonrones es bastante alta en comparación con los otros dos pares.

#Resulta que los lanzadores, temerosos de los jonrones, a veces evitarán lanzar golpes a los bateadores de jonrones.

#Como resultado, los bateadores de jonrones tienden a tener más bases por bolas.

#Por lo tanto, un equipo con muchos jonrones también tendrá más bases en bolas que la media, y como resultado, puede parecer que las bases en las bolas causan carreras.

#Pero en realidad son los jonrones los que causaron las carreras.

#En este caso, decimos que las bases de las bolas se confunden con los homeruns.

#¿Pero podría ser que las bases en las bolas todavía sirvan?
  
#Para descubrirlo, de alguna manera tenemos que ajustarnos para el efecto homerun.

#La regresión puede ayudar con esto.