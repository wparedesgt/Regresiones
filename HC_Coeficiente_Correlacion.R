#Coeficiente de Correlacion


#El coeficiente de correlación se define para una lista de pares x1, y1 a xn, yn con la siguiente fórmula.

#(X1,Y1) ....(Xn, Yn)


#Aquí, mu x y mu y son los promedios de x y y, respectivamente.

#Y sigma x y sigma y son las desviaciones estándar.

#La letra griega rho se usa comúnmente en el libro de estadísticas para denotar esta correlación.

#La razón es que rho es la letra griega para r, la primera letra de la palabra regresión.

#Pronto, aprenderemos sobre la conexión entre la correlación y la regresión.

#Para comprender por qué esta ecuación, de hecho, resume cómo dos variables se mueven juntas, considere la i-ésima entrada de x es xi menos mu x dividida por sigma x SDs lejos del promedio.

#De manera similar, el yi que está emparejado con el xi es yi menos mu y dividido por sigma y SDs lejos del promedio y.

#Si xey no están relacionados, entonces el producto de estas dos cantidades será positivo.

#Eso sucede cuando ambos son positivos o cuando ambos son negativos tan a menudo ya que serán negativos

#Eso sucede cuando uno es positivo y el otro es negativo, o al revés.

#Uno es negativo y el otro es positivo.

#Esto promediará a aproximadamente 0.

#La correlación es este promedio.

#Y, por lo tanto, las variables no relacionadas tendrán una correlación de aproximadamente 0.

#Si, en cambio, las cantidades varían juntas, entonces estamos promediando principalmente productos positivos.

#Porque van a ser tiempos positivos, positivos o negativos, negativos.

#Y obtenemos una correlación positiva.

#Si varían en direcciones opuestas, obtenemos una correlación negativa.

#Otra cosa que debes saber es que podemos demostrar matemáticamente que la correlación siempre está entre 1 y 1 negativo.

#Para ver esto, considere que podemos tener una correlación mayor que cuando comparamos una lista consigo misma.

#Esa sería una correlación perfecta.

#En este caso, la correlación está dada por esta ecuación, que podemos mostrar es igual a 1.

#Un argumento similar con xy su opuesto exacto, x negativo, demuestra que la correlación debe ser mayor o igual que 1 negativo.

#Entonces está entre -1 y 1.

#La correlación entre la altura del padre y los hijos es de aproximadamente 0.5.

#Puede calcular eso usando este código.

library(dslabs)
library(HistData)

data("GaltonFamilies")

galton_heights <- GaltonFamilies %>%
  filter(childNum == 1 & gender == "male") %>% 
  select(father, childHeight) %>%
  rename(son = childHeight)


galton_heights %>% summarize(cor(father, son))

#Vimos cómo se ve la información cuando la correlación es 0.5.

#Para ver qué datos se parecen para otros valores de rho, aquí hay seis ejemplos de pares con correlaciones que oscilan entre 0,9 y 0,99 negativos.

#Cuando la correlación es negativa, vemos que van en dirección opuesta.

#A medida que x aumenta, y disminuye.

#Cuando la correlación se acerca más a 1 o negativa a 1, vemos que el coágulo de puntos se vuelve más y más delgado.

#Cuando la correlación es 0, solo vemos un gran círculo de puntos.