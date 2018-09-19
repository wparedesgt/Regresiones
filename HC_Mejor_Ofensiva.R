#Construyendo mejor ofensiva

library(tidyverse)
library(Lahman)
library(broom)
data("Teams")

#Al tratar de responder qué tan bien las bases por bolas predicen las carreras, la exploración de datos nos permite utilizar este modelo.

#Aquí, los datos son aproximadamente normales.

#Y las distribuciones condicionales también fueron normales.

#Por lo tanto, estamos justificados para plantear un modelo lineal como este.

#Con yi, las carreras por juego.

#x1, bases por bola por juego.

#Y x2, jonrones por juego.

#Para usar lm aquí, debemos informarle que tenemos dos variables predictivas.

#Entonces usamos el símbolo más de la siguiente manera.


#Aquí hay un código que se ajusta a ese modelo de regresión múltiple.

fit <- Teams %>% 
  filter(yearID %in% 1961:2001) %>%
  mutate(BB = BB/G, HR = HR/G , R = R/G) %>% 
  lm(R ~ BB + HR, data = .)


#Ahora, podemos usar la función tidy() para ver el buen resumen.

tidy(fit, conf.int = TRUE)


#Cuando ajustamos el modelo con una sola variable sin el ajuste, las pendientes estimadas fueron de 0.735 y 1.844 para las bases por bola y los jonrones, respectivamente.

#Pero tenga en cuenta que cuando nos ajustamos al modelo multivariable, ambas pendientes descienden con las bases sobre las bases por bola disminuyendo mucho más.

#Ahora, si queremos construir una métrica para elegir jugadores, también debemos considerar sencillos, dobles y triples.

#¿Podemos construir un modelo que predice las carreras basadas en todos estos resultados?
  
#Ahora, tomaremos un poco de fe y asumiremos que estas cinco variables son conjuntamente normales.

#Esto significa que si elegimos uno de ellos y mantenemos el otro para fijo, la relación con el resultado en este caso, las ejecuciones por juego son lineales.

#Y las pendientes para esta relación no dependen de los otros cuatro valores que se mantuvieron constantes.

#Si esto es cierto, si este modelo es cierto, entonces un modelo lineal para nuestros datos es el siguiente.

#Con x1, x2, x3, x4, x5 representando bases por bolas por juego, singles por juego, dobles por juego, triples por juego y jonrones por juego, respectivamente.

#Usando lm, podemos encontrar rápidamente los errores de mínimos cuadrados para los parámetros usando esta pieza de código relativamente simple.

fit <- Teams %>%
  filter(yearID %in% 1961:2001) %>%
  mutate(BB = BB/G, 
         singles = (H-X2B-X3B-HR)/G,
         doubles = X2B/G,
         triples = X3B/G,
         HR = HR/G , 
         R = R/G) %>% 
  lm(R ~ BB + singles + doubles + triples + HR, data = .)

#Nuevamente podemos utilizar la función tidy() para ver los coeficientes, los errores estándar y los intervalos de confianza.

coefs <- tidy(fit, conf.int = TRUE)

coefs

#Para ver qué tan bien nuestra predicción en tiempo real se ejecuta, podemos predecir el número de carreras para cada equipo en 2002 usando la función de predicción para hacer la gráfica.

#Tenga en cuenta que no usamos el año 2002 para crear esta métrica.

#Utilizamos datos de años anteriores a 2002.

#Y aquí está la trama.

Teams %>%
  filter(yearID %in% 1961:2001) %>%
  mutate(BB = BB/G, 
         singles = (H-X2B-X3B-HR)/G,
         doubles = X2B/G,
         triples = X3B/G,
         HR = HR/G , 
         R = R/G) %>%
  mutate(R_hat  = predict(fit, newdata = .)) %>% 
  ggplot(aes(R, R_hat)) +
  geom_point()


#Nuestro modelo hace un trabajo bastante bueno, como lo demuestra el hecho de que los puntos de la gráfica observada versus predicha caen cerca de la línea de identidad.

#Entonces, en lugar de utilizar el promedio de bateo o solo el número de jonrones como medida para seleccionar jugadores, podemos usar nuestro modelo ajustado para formar una métrica más informativa que se relaciona más directamente con la producción en tiempo real.

#Específicamente, para definir una métrica para el jugador A, imaginamos un equipo compuesto por jugadores como el jugador A y usamos nuestro modelo de regresión para predecir cuántas carreras produciría este equipo.

#La fórmula sería así.

#Básicamente estamos metiendo los coeficientes estimados en la fórmula de regresión.

#Sin embargo, para definir la métrica específica de un jugador, tenemos un poco más de trabajo por hacer.

#Nuestro desafío aquí es que hemos derivado las métricas para los equipos basadas en estadísticas de resumen a nivel de equipo.

#Por ejemplo, el valor de home run que se ingresa en la ecuación es jonrones por juego para todo el equipo.

#Si calcula los jonrones por juego para un jugador, será mucho menor.

#Como el total es acumulado por nueve bateadores, no solo uno.

#Además, si un jugador solo juega parte del juego y obtiene menos oportunidades que el promedio, aún se considera un juego.

#Entonces esto significa que sus tarifas serán más bajas de lo que deberían ser.

#Para los jugadores, una tasa que toma en cuenta las oportunidades es una tasa de aparición al plato.

#Para hacer que la tasa del equipo por partido sea comparable a la de los jugadores por apariencia de plato, calculamos el número promedio de apariciones en el plato del equipo por juego usando esta simple pieza de código.
data("Batting")

pa_per_game <- Batting  %>% filter(yearID == 2002) %>% 
  group_by(teamID) %>% 
  summarize(pa_per_game  = sum(AB+BB)/max(G)) %>% 
  .$pa_per_game %>%
  mean()


#Ahora, estamos listos para usar nuestra métrica.

#Vamos a calcular las tasas de apariencia por placa para los jugadores disponibles en 2002.

#Pero vamos a usar datos de 1999 2001.

#Porque recuerda, estamos escogiendo jugadores en 2002.

#No sabemos lo que ha sucedido todavía.

#Para evitar pequeños artefactos de muestra, vamos a filtrar jugadores con pocas interferencias de placa.

#Aquí está el cálculo de lo que queremos hacer en una larga línea de código usando tidyverse.

players <- Batting %>% filter(yearID %in% 1999:2001) %>% 
  group_by(playerID) %>%
  mutate(PA = BB + AB) %>% 
  summarize(G = sum(PA)/pa_per_game, 
            BB = sum(BB)/G, 
            singles = sum(H-X2B-X3B-HR)/G, 
            doubles = sum(X2B)/G, 
            triples = sum(X3B)/G, 
            HR = sum(HR)/G,
            AVG = sum(H)/sum(AB), 
            PA = sum(PA)) %>% 
  filter(PA >= 300) %>% 
  select(-G) %>% 
  mutate(R_hat = predict(fit, newdata = .))


#Así que nos ajustamos a nuestro modelo.

#Y tenemos métricas específicas del jugador.

#La computadora proyectada específica para el jugador aquí se puede interpretar como una serie de carreras que predeciríamos que un equipo marcaría si este equipo estuviera compuesto solo por ese jugador, si ese jugador bateaba cada vez.

#La distribución muestra que hay variabilidad y entre los jugadores, como podemos ver aquí.

players %>% ggplot(aes(R_hat)) +
  geom_histogram(binwidth = 0.5, color = "black")


#Para construir realmente los equipos, necesitaremos conocer los salarios de los jugadores, ya que tenemos un presupuesto limitado.

#Recuerde, pretendemos ser los A de Oakland en 2002 con solo un presupuesto de $ 40 millones.

#También necesitamos saber la posición de los jugadores.

#Porque vamos a necesitar un shortstop, un segunda base, un tercera base, etcétera.

#Para esto, vamos a tener que hacer un poco de disputa de datos para combinar información que está contenida en diferentes tablas de la biblioteca.

#OK, entonces aquí vamos.

#Comenzamos agregando los salarios de 2002 para cada jugador que usa este código.

data("Salaries")

players <- Salaries %>%
  filter(yearID == 2002) %>%
  select(playerID, salary) %>%
  right_join(players, by = "playerID")


#A continuación, agregaremos la posición defensiva.

#Esto es un poco complicado, porque los jugadores juegan más de una posición cada año.

#Así que aquí, vamos a elegir la posición más jugada por cada jugador que usa la función top_n.

#Y para asegurarnos de elegir solo una posición en el caso de los empates, tomaremos la primera fila si hay un empate.

#También eliminamos la posición OF.

#Porque esto significa jardinero, que es una generalización de tres posiciones, campo izquierdo, jardín central, jardín derecho.

#También eliminamos lanzadores, ya que no batean en la liga que juegan los Atléticos.

#Aquí está el código que hace eso.

data("Fielding")

players <- Fielding %>% filter(yearID == 2002) %>%
  filter(!POS %in% c("OF", "P")) %>% 
  group_by(playerID) %>%
  top_n(1,G) %>%
  filter(row_number(G) == 1) %>%
  ungroup() %>%
  select(playerID, POS) %>% 
  right_join(players, by = "playerID") %>% 
  filter(!is.na(POS) & !is.na(salary))
  


#Finalmente, agregamos sus nombres y apellidos para que sepamos de quién estamos hablando.

#Y aquí hay un código que hace eso.
data("Master")

players <- Master %>% 
  select(playerID, nameFirst, nameLast, debut) %>%
  right_join(players, by = "playerID")


#Entonces, ahora tenemos una tabla con nuestra estadística de carrera predicha, alguna otra estadística, el nombre del jugador, su posición y su salario.

players %>% select(nameFirst, nameLast, POS, salary, R_hat) %>% 
  arrange(desc(R_hat)) %>%
  top_n(10)



#Si observamos a los 10 mejores jugadores según nuestra estadística de producción en ejecución, reconocerá algunos nombres si es aficionado al béisbol.

#Tenga en cuenta los salarios muy altos de estos jugadores en el top 10.

#De hecho, vemos que los jugadores con altas métricas tienen altos salarios.

players %>% ggplot(aes(salary, R_hat, color = POS)) +
  geom_point() + 
  scale_x_log10()


#Podemos ver que al hacer una trama vemos algunos jugadores de bajo costo con métricas muy altas.

#Esto sería genial para nuestro equipo.

#Desafortunadamente, estos son jugadores jóvenes que aún no han podido negociar un salario y que no estarán disponibles en 2002.

#Por ejemplo, el ganador más bajo en nuestra lista de los 10 principales es Albert Pujols, que fue novato en 2001.

#Aquí hay una trama con jugadores que debutó antes de 1997.

#Esto elimina a todos los jugadores jóvenes.

players %>% filter(debut < 1998 ) %>% 
  ggplot(aes(salary, R_hat, color = POS)) + 
  geom_point() +
  scale_x_log10()



#Ahora podemos buscar buenas ofertas observando jugadores que producen muchas más tiradas y otras con salarios similares.

#Podemos utilizar esta tabla para decidir qué jugadores elegir y mantener nuestro salario total por debajo de los $ 40 millones con los que Billy Beane tuvo que trabajar.

#Una forma de elegir realmente a los jugadores para el equipo se puede hacer usando lo que los científicos de la computación llaman programación lineal. Aunque no abordamos este tema en detalle en este curso, incluimos el código de todos modos:

library(reshape2)
library(lpSolve)

players <- players %>% filter(debut <= 1997 & debut > 1988)
constraint_matrix <- acast(players, POS ~ playerID, fun.aggregate = length)
npos <- nrow(constraint_matrix)
constraint_matrix <- rbind(constraint_matrix, salary = players$salary)
constraint_dir <- c(rep("==", npos), "<=")
constraint_limit <- c(rep(1, npos), 50*10^6)
lp_solution <- lp("max", players$R_hat,
                  constraint_matrix, constraint_dir, constraint_limit,
                  all.int = TRUE) 

#Este algoritmo elige estos 9 jugadores:

our_team <- players %>%
  filter(lp_solution$solution == 1) %>%
  arrange(desc(R_hat))
our_team %>% select(nameFirst, nameLast, POS, salary, R_hat)

#Observamos que todos estos jugadores tienen tasas de BB y HR por encima de la media, mientras que lo mismo no es cierto para los sencillos.

my_scale <- function(x) (x - median(x))/mad(x)
players %>% mutate(BB = my_scale(BB), 
                   singles = my_scale(singles),
                   doubles = my_scale(doubles),
                   triples = my_scale(triples),
                   HR = my_scale(HR),
                   AVG = my_scale(AVG),
                   R_hat = my_scale(R_hat)) %>%
  filter(playerID %in% our_team$playerID) %>%
  select(nameFirst, nameLast, BB, singles, doubles, triples, HR, AVG, R_hat) %>%
  arrange(desc(R_hat))

#On Base Plus Slugging (OPS)

#Desde la década de 1980, los sabermetricians han utilizado una estadística de resumen diferente del promedio de bateo para evaluar a los jugadores.

#Se dieron cuenta de que las bases por bolas eran importantes, y que los dobles, triples y jonrones deberían ponderarse mucho más que los sencillos, y propusieron la siguiente métrica.

#Llaman a esto porcentajes de porcentaje base más slugging, u OPS.

#Hoy, esta estadística se ha puesto de moda, y lo ves en ESPN y otras redes de deportes.

#Aunque es probable que los sabremédicos no utilicen la regresión, esta métrica es impresionantemente similar a la que se obtiene con la regresión a la estadística de resumen que creamos.

#Aquí está la trama.

#Están muy correlacionados.






