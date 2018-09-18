library(tidyverse)
library(Lahman)
data("Teams")


dat <- Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR = round(HR/G,1), 
         BB = BB/G,
         R = R/G) %>% 
  select(HR, BB, R) %>% 
  filter(HR >= 0.4 & HR <= 1.2)


#La tarea original que solicitamos en un texto anterior fue proporcionar una estimación y un intervalo de confianza para las estimaciones de pendiente de cada estrato.

#Los paquetes de broom harán que esto sea bastante fácil.

#Broom tiene tres funciones principales, todas las cuales extraen información del objeto devuelto por la función LM y la devuelven en data frame amistoso versátil.

#Estas funciones son, tidy() glance() y augment().

#La función tidy devuelve estimaciones e información relacionada como un marco de datos.

#Aquí hay un ejemplo.

library(broom)

fit <- lm(R ~ BB, data= dat)

tidy(fit)


#Podemos agregar otros resúmenes importantes, como los intervalos de confianza, usando argumentos como este.

tidy(fit, conf.int = TRUE)

#Como el resultado es un marco de datos, podemos usarlo inmediatamente con do para unir los comandos que producen la tabla que estamos buscando.

#Entonces este fragmento de código generará lo que queríamos ver.

dat %>% 
  group_by(HR) %>% 
  do(tidy(lm(R ~ BB, data = .), conf.int = TRUE))


#Como se devuelve un marco de datos, podemos filtrar y seleccionar las filas y columnas que queremos.

#Entonces, esta simple pieza de código nos da exactamente la tabla que pedimos.

dat %>% 
  group_by(HR) %>% 
  do(tidy(lm(R ~ BB, data = .), conf.int = TRUE)) %>% 
  filter(term == "BB") %>%
  select(HR, estimate, conf.low, conf.high )

#Hemos filtrado las filas de intercepción y solo mostramos las columnas que nos interesan, la estimación y los intervalos de confianza.

#Además, una tabla como esta hace que la visualización con ggplot sea bastante fácil.

#Entonces este fragmento de código produce esta bonita trama, que proporciona información muy útil.

dat %>% 
  group_by(HR) %>% 
  do(tidy(lm(R ~ BB, data = .), conf.int = TRUE)) %>% 
  filter(term == "BB") %>%
  select(HR, estimate, conf.low, conf.high ) %>% 
  ggplot(aes(HR, y = estimate, ymin = conf.low, ymax =  conf.high)) +
  geom_errorbar() +
  geom_point()




#Ahora volvemos a discutir nuestra tarea original de determinar si las pendientes cambian.

#La trama que acabamos de hacer usando do y broom muestra que los intervalos de confianza se superponen, lo que proporciona una buena confirmación visual de que nuestra suposición de que las pendientes no cambian con los estratos de home run es relativamente segura.

#Anteriormente mencionamos otras dos funciones del paquete de broom, glance y augment se relacionan con los resultados específicos del modelo y la observación, respectivamente.

#Aquí podemos ver el resumen de ajuste del modelo que devuelve glance.

glance(fit)


#Puede obtener más información sobre estos resúmenes en cualquier libro de texto de regresión.

#Ejercicios

#Desea saber si la relación entre jonrones y carreras por juego varía según la liga de béisbol. Usted crea el siguiente conjunto de datos:


dat <- Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR = HR/G,
         R = R/G) %>%
  select(lgID, HR, BB, R) 

#Que codigo responde la pregunta

dat %>% 
  group_by(lgID) %>% 
  do(tidy(lm(R ~ HR, data = .), conf.int = T)) %>% 
  filter(term == "HR") 


#dat %>% 
#  group_by(lgID) %>% 
#  do(glance(lm(R ~ HR, data = .)))

#dat %>% 
#  do(tidy(lm(R ~ HR, data = .), conf.int = T)) %>% 
#  filter(term == "HR")


#dat %>% 
#  group_by(lgID) %>% 
#  do(mod = lm(R ~ HR, data = .))
