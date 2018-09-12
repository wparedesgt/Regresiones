#Predicted Variables are Random Variables

#Una vez que nos ajustamos a nuestro modelo, podemos obtener predicciones de y al conectar las estimaciones en el modelo de regresión.

#Por ejemplo, si la altura del padre es x, entonces nuestra predicción para y que denotaremos con un [? sombrero?] en la parte superior de la y para la altura del hijo será el siguiente.

#Simplemente estamos conectando beta las betas estimadas en la ecuación.

#Si graficamos y hat versus x, veremos la línea de regresión.

#Tenga en cuenta que la predicción y hat también es una variable aleatoria, y la teoría matemática nos dice cuáles son los errores estándar.

#Si asumimos que los errores son normales o que tienen un tamaño de muestra lo suficientemente grande como para usar el Teorema del Límite Central, también podemos construir intervalos de confianza para nuestras predicciones.

#De hecho, la capa ggplot geom subrayado suave, cuando establecemos el método es igual a lm anteriormente hemos mostrado esto para varias plots traza intervalos de confianza alrededor del sombrero predicho.

#Veamos un ejemplo con este código.


library(tidyverse)
library(dslabs)
library(HistData)

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)


galton_heights %>% ggplot(aes(son, father)) +
  geom_point() + 
  geom_smooth(method = 'lm')


#Puedes ver la línea de regresión.

#Esas son las predicciones, y ves una banda a su alrededor.

#Esos son los intervalos de confianza.

#La función R predecir toma un objeto lm como entrada y devuelve estas predicciones.

#Podemos verlo aquí en este código que produce esta gráfica,

galton_heights %>% 
  mutate(y_hat = predict(lm(son~father, data = .))) %>%
  ggplot(aes(father, y_hat)) + 
  geom_line()


#y si se solicita, los errores estándar y otra información a partir de la cual podemos construir intervalos de confianza se pueden obtener a partir de la función de predicción.

#Puedes verlo ejecutando este código.

fit <- galton_heights %>% lm(son~father, data = .)
Y_hat <- predict(fit, se.fit = TRUE)  
names(Y_hat)


#Ejercicios

galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth()

galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth(method = "lm")

model <- lm(son ~ father, data = galton_heights)
predictions <- predict(model, interval = c("confidence"), level = 0.95)
data <- as.tibble(predictions) %>% bind_cols(father = galton_heights$father)

ggplot(data, aes(x = father, y = fit)) +
  geom_line(color = "blue", size = 1) + 
  geom_ribbon(aes(ymin=lwr, ymax=upr), alpha=0.2) + 
  geom_point(data = galton_heights, aes(x = father, y = son))


model <- lm(son ~ father, data = galton_heights)
predictions <- predict(model)
data <- as.tibble(predictions) %>% bind_cols(father = galton_heights$father)

ggplot(data, aes(x = father, y = fit)) +
  geom_line(color = "blue", size = 1) + 
  geom_point(data = galton_heights, aes(x = father, y = son))
