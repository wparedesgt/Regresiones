#Volvamos al béisbol.

#En un ejemplo anterior, estimamos las líneas de regresión para predecir carrerass por bases por bolas y diferentes estratos de jonrones.

#Primero construimos un marco de datos similar a esto.

library(dslabs)
library(tidyverse)
library(Lahman)

data("Teams")

dat <- Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR = round(HR/G,1), 
         BB = BB/G,
         R = R/G) %>% 
  select(HR, BB, R) %>% 
  filter(HR >= 0.4 & HR <= 1.2)


#Luego, para calcular la línea de regresión en cada estrato, ya que no conocíamos la función lm en ese momento, usamos la fórmula directamente de esta manera.

dat %>% 
  group_by(HR) %>% 
  summarize(slope = cor(BB, R)*sd(R)/sd(BB))

#Argumentamos que las pendientes son similares y que las diferencias tal vez se debieron a la variación aleatoria.

#Para proporcionar una defensa más rigurosa de las pendientes, que es lo que condujo a nuestro modelo de regresión multivariante, podríamos calcular intervalos de confianza para cada pendiente.

#No hemos aprendido la fórmula para esto, pero la función lm proporciona suficiente información para construirlos.

#Primero, tenga en cuenta que si tratamos de usar la función lm para obtener la pendiente estimada de esta manera, no obtenemos lo que queremos.

dat %>% 
  group_by(HR) %>% 
  lm(R ~ BB, data = .) %>%
  .$coef



#La función lm ignoró group_by.

#Esto es esperado, porque lm no es parte del tidyverse y no sabe cómo manejar el resultado de group_by que es un grupo tibble.

#Vamos a describir los tibbles en algunos detalles ahora.

#Cuando summarize recibe el resultado de group_by, de alguna manera sabe qué filas de la tabla van con qué grupos.

#Pero, ¿dónde se almacena esta información en el data frame?
  
#Vamos a escribir un código para ver el resultado de una llamada group_by.

dat %>% group_by(HR) %>% head()


#Tenga en cuenta que no hay columnas con la información necesaria para definir los grupos.

#Pero si miras detenidamente la salida, notas la línea "A tibble, 6 by 3".

#Podemos aprender la clase del objeto de retorno usando esta línea de código, y vemos que la clase es un "tbl".

dat %>% group_by(HR) %>% class()


#Esto se pronuncia "tibble".

#También es un tbl_df.

#Esto es equivalente a tibble.

#El tibble es un tipo especial de marco de datos.

#Los hemos visto antes, porque las funciones tidyverse como group_by y también summarize siempre devuelven este tipo de marco de datos.

#La función group_by devuelve un tipo especial de tibble, el tibble agrupado.

#Más adelante diremos más sobre los tibbles agrupados.

#Tenga en cuenta que los verbos de manipulación, seleccionar, filtrar, mutar y organizar, no necesariamente devuelven tibbles.

#Conservan la clase de la entrada.

#Si reciben un marco de datos normal, devuelven un marco de datos regular.

#Si reciben un tibble, devuelven un tibble.

#Pero los tibbles son el data frame predeterminado para el tidyverse.

#Tibbles son muy similares a los data Frames.

#Puede pensar en ellos como versiones modernas de marcos de datos.

#A continuación, vamos a describir brevemente tres diferencias importantes.