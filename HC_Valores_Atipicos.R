#La correlación no es causalidad: valores atípicos

#Otra forma en que podemos ver altas correlaciones cuando no hay causalidad es cuando tenemos valores atípicos.

#Supongamos que tomamos medidas de dos resultados independientes, x y, y estandar izamos las medidas.

#Sin embargo, imagine que cometimos un error y olvidamos estandarizar la entrada 23.

#Podemos simular dichos datos utilizando el siguiente código.

library(tidyverse)

set.seed(1)
x <- rnorm(100, 100,1)
y <- rnorm(100, 84, 1)

x[-23] <- scale(x[-23])
y[-23] <- scale(y[-23])

tibble(x,y) %>% ggplot(aes(x,y)) + geom_point(alpha = 0.5)

#Los datos se ven así.

#No en vano, la correlación es muy alta.

cor(x,y)

#Ese punto, ese valor atípico, es hacer que la correlación sea tan alta como 0.99.

#Pero una vez más, esto es impulsado por ese valor atípico.

#Si eliminamos este valor atípico, la correlación se reduce en gran medida a casi 0, que es lo que debería ser.

cor(x[-23], y[-23])


#Esto es lo que obtenemos si eliminamos la entrada 23.

#Entonces, una forma de lidiar con los valores atípicos es tratar de detectarlos y eliminarlos.

#Pero hay una forma alternativa a la correlación de la muestra para estimar la correlación de la población que es robusta a los valores atípicos.

#Se llama correlación de spearman.

#La idea es simple.

#Calcule la correlación en los rangos de los valores, en lugar de los valores en sí mismos.

#Aquí hay una gráfica de los rangos trazados unos contra otros para ese conjunto de datos que incluye el valor atípico.

#Tenga en cuenta que el único punto que es muy grande es solo en la ubicación número 100.

#Ya no está realmente ahí fuera y tirando de la correlación hacia 1.

#Entonces, si calculamos la correlación de los rangos, obtenemos algo mucho más cercano a 0, como vemos aquí.

cor(rank(x), rank(y))

#La correlación de Spearman también se puede calcular con la función de correlación, pero usando el argumento del método para indicar [? cor?] que correlacionar para computar.

cor(x,y,method = "spearman")

#También hay métodos para el ajuste robusto de modelos lineales, sobre los que puede aprender, por ejemplo, en este libro.