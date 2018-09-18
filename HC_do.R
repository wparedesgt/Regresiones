library(tidyverse)
library(Lahman)
data("Teams")

dat <- Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR = round(HR/G,1), 
         BB = BB/G,
         R = R/G) %>% 
  select(HR, BB, R) %>% 
  filter(HR >= 0.4 & HR <= 1.2)

#Describiremos la muy útil función do ().

#Las funciones tidyverse saben cómo interpretar grupos tibbles.

A#demás, para facilitar los comandos de enhebrado a través de la tubería, la función tidyverse devuelve sistemáticamente los marcos de datos.

#Como esto asegura que la salida de 1 se acepta como la entrada de otra.

#Pero la mayoría de nuestras funciones no reconocen tibbles grupales ni devuelven marcos de datos.

#La función lm () es un ejemplo.

#La función do () sirve como puente entre nuestras funciones, como lm () en tidyverse.

#La función do () comprende grupos tibbles y siempre devuelve un marco de datos.

#Intentemos usar la función do () para ajustar una línea de regresión a cada estrato de home run.

#Lo haríamos así.

dat %>% 
  group_by(HR) %>% 
  do(fit = lm(R~BB, data = .))

#Tenga en cuenta que de hecho encajamos una línea de regresión para cada estrato.

#Pero la función do () crearía un marco de datos con la primera columna como valor de estratos.

#Y una columna llamada fit.

#Elegimos ese nombre.

#Podría ser cualquier nombre.

#Y esa columna contendrá el resultado de la llamada lm ().

#Por lo tanto, la tabla de retorno tiene una columna con objetos lm () en las celdas, que no es muy útil.

#También tenga en cuenta que si no nombramos una columna, entonces do () devolverá la salida real de lm (), no un marco de datos.

#Y esto dará como resultado un error ya que do () está esperando un marco de datos como salida.

#Si escribe esto, obtendrá el siguiente error.

dat %>% 
  group_by(HR) %>% 
  do(lm(R~BB, data = .))

#Error: Results 1, 2, 3, 4, 5, ... must be data frames, not lm

#Para que se construya una trama de datos útil, la salida de la función, dentro de do (), también debe ser un marco de datos.

#Podríamos crear una función que solo devuelva lo que desea en forma de un marco de datos.

#Podríamos escribir, por ejemplo, esta función.

get_slope <- function(data) {
  fit <- lm(R ~ BB, data = data)
  data.frame(slope = fit$coefficient[2], 
             se = summary(fit)$coefficient[2,2])
  
}

#Y luego usamos para hacer () sin nombrar el resultado, ya que ya estamos obteniendo un marco de datos.

#Podemos escribir esta pieza de código muy simple y ahora obtenemos el resultado esperado. Obtenemos la pendiente para cada estrato y el error estándar para esa pendiente.

dat %>% 
  group_by(HR) %>% 
  do(get_slope(.))


#Si nombramos el resultado, obtenemos una columna que contiene el marco de datos.

#Entonces, si escribimos este fragmento de código, ahora una vez más, obtenemos uno de estos complejos tibbles con una columna que tiene un marco de datos en cada celda.

dat %>% 
  group_by(HR) %>% 
  do(slope = get_slope(.))


#Lo cual es nuevo, no muy útil.

#Todo bien.

#Ahora vamos a cubrir una última característica de do ().

#Si la trama de datos que se devuelve tiene más de una fila, éstas se concatenarán de forma adecuada.

#Aquí hay un ejemplo en el que se devuelven ambos parámetros estimados.

get_lse <- function(data) {
  fit <- lm(R ~ BB, data = data)
  data.frame(term = names(fit$coefficients), 
             slope = fit$coefficients, 
             se = summary(fit)$coefficient[,2])
}

#La pendiente y la intersección.

#Escribimos este pedazo de código.

dat %>% 
  group_by(HR) %>% 
  do(get_lse(.))


#Y ahora usamos la función do () como la usamos antes, y obtenemos un tibble muy útil, que nos da las estimaciones de la pendiente y la intersección, así como los errores estándar.

#Ahora, si crees que esto es demasiado complicado, no estás solo.

#Para simplificar las cosas, vamos a presentar el paquete broom, que fue diseñado para facilitar el uso de funciones de ajuste de modelo, como lm () con el tidyverse.


#Ejercicio

#Desea tomar el tibble dat, que hemos estado usando en este video, y ejecutar el modelo lineal R ~ BB para cada estrato de HR. Luego, desea agregar tres columnas nuevas a su tibble agrupado: el coeficiente, el error estándar y el valor p para el término BB en el modelo.

#Ya ha escrito la función get_slope, que se muestra a continuación.


get_slope <- function(data) {
  fit <- lm(R ~ BB, data = data)
  sum.fit <- summary(fit)
  
  data.frame(slope = sum.fit$coefficients[2, "Estimate"], 
             se = sum.fit$coefficients[2, "Std. Error"],
             pvalue = sum.fit$coefficients[2, "Pr(>|t|)"])
}


#dat %>% 
#  group_by(HR) %>% 
#  do(get_slope)

dat %>% 
  group_by(HR) %>% 
  do(get_slope(.))

#dat %>% 
#  group_by(HR) %>% 
#  do(slope = get_slope(.))

dat %>% 
  do(get_slope(.))
