#Tibbles

#En este video, vamos a describir algunas de las principales diferencias entre tibbles y un data frame.

#Primero, el método de impresión para tibble es mucho más legible que el de un data frame.

#Para ver esto, escriba los equipos en su consola después de cargar Baseball Lahman Database.

library(tidyverse)
library(Lahman)
data("Teams")

Teams

#Y verá una lista muy, muy larga de columnas y filas.

#Es apenas legible.

#Equipos es un data frame con muchas filas y columnas.

#Es por eso que ves eso.

#Sin embargo, la salida solo muestra todo y es difícil de leer.

#Es tan malo que ni siquiera lo imprimimos aquí.

#Le dejaremos imprimirlo en su propia pantalla.

#Ahora, si convierte este marco de datos a un marco de datos tibble, la salida será mucho más legible.

as_tibble(Teams)


#Aquí hay un ejemplo.

#Esa es la primera diferencia principal entre tibbles y data frame.

#El segundo es que si subconjunta las columnas de un marco de datos, puede recuperar un objeto que no es un marco de datos.

#Aquí hay un ejemplo.
class(Teams[,20])

#Si subconjunto la columna 20, obtenemos un número entero.

#Eso no es un data frame.

#Con tibbles, este no es el caso.

#Aquí hay un ejemplo.

class(as_tibble(Teams)[,20])

#Si subconjunto una tabla, obtenemos una tabla.

#Esto es útil en el tidyverse ya que las funciones requieren marcos de datos como entrada.

#Ahora, siempre que quiera acceder al vector original que define una columna en una tabla, para esto, en realidad tiene que usar el signo de acceso del dólar.

#Aquí hay un ejemplo.

class(as_tibble(Teams)$HR)

#Una característica relacionada con esto es que tibbles le dará una advertencia si intenta acceder a una columna que no existe.

#Ese no es el caso para los data frames.

#Por ejemplo, si accidentalmente escribimos hr en minúsculas en lugar de mayúsculas, con un data frame, todo lo que obtenemos es un no.

Teams$hr

#Sin advertencia.

#Esto puede hacer que sea bastante difícil depurar el código.

#Por el contrario, si es un tibble, e intenta acceder a la columna hr en minúsculas, que no existe, en realidad recibe una advertencia.

as_tibble(Teams)$hr

#Una tercera diferencia es que, si bien las columnas de un marco de datos deben ser un vector de cadenas numéricas o booleanas, los tibbles pueden tener objetos más complejos, como listas o funciones.

#También tenga en cuenta que podemos crear tibbles con la función de tibble.

#Entonces, mira esta línea de código.

tibble(id = c(1,2,3), func = c(mean, median, sd))

#Estamos creando una columna que en realidad tiene funciones.

#Puedes ver la salida aquí.

#Finalmente, la última diferencia que describimos es que los tibbles se pueden agrupar.

#El grupo de funciones devuelve un tipo especial de tibble, un tibble agrupado.

#Esta clase almacena información que le permite saber qué filas están dentro de grupos.

#Las funciones tidyverse, en particular las funciones de resumen, son conscientes de la información del grupo.

#En el ejemplo que mostramos, vimos que la función ln, que no es parte del tidyverse, no sabe cómo lidiar con grupos tibbles.

#El objeto se convierte básicamente en un marco de datos normal, y luego la función se ejecuta ignorando los grupos.

#Es por eso que solo obtenemos un par de estimaciones, como vemos aquí.


#Para que estas funciones no triviales se integren mejor con un tidyverse, aprenderemos una nueva función, la función do().