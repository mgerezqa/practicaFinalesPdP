module Library where
import PdePreludat
import GHC.Num (Num)

f :: (a -> Bool) -> (a -> Number) -> [a] -> Number
f h j = sum . map j . filter h

-- 1. Inferir el tipo de la función f.

-- 2. Utilizar f para:

-- 2a
data Empleado = Empleado{
    nombre :: String,
    sueldo :: Number,
    esJunior :: Bool
}
totalSueldosDeJuniors :: [Empleado] -> Number
totalSueldosDeJuniors = f esJunior sueldo 

-- 2b

ejemploDeAplicación = f (<3) (+1) [1,2,4,5]


    -- a. Crear una función equivalente a totalSueldosDeJuniors (asumir que contamos con “esJunior”).
    -- b. Hacer una consulta usando f, para algún otro ejemplo que no tenga nada que ver con empleados.

-- 3. Indicar en cada una de las siguientes afirmaciones si es Verdadera o Falsa, justificando en todos los casos su
-- respuesta:

    -- a. La función f no es de orden superior, pero usa funciones de orden superior.
    -- b. Se utiliza aplicación parcial en la definición de f.

-- Y más allá de que tengan objetivos diferentes:

    -- c. La definición de f es más expresiva que la función totalSueldosDeJuniors.
    -- d. La definición de f es más declarativa que la función totalSueldosDeJuniors.


-- 3a
-- La afirmación es Falsa. La función f es, de hecho, una función de orden superior, ya que toma como argumentos otras funciones (h, j) y
--  las combina para producir una nueva función. Una función de orden superior es aquella que opera con funciones como argumentos o devuelve funciones como resultado. 
-- En este caso, f toma funciones como argumentos (h y j) y las utiliza en su definición.

--3b
-- b. La afirmación es Verdadera. En la definición de f, se utiliza aplicación parcial. La aplicación parcial ocurre cuando una función se aplica a menos argumentos de los que toma originalmente. 
-- En este caso, f toma tres argumentos (h, j, y una lista), pero la aplicación de estas funciones a la lista se realiza parcialmente mediante el uso del operador . (composición de funciones). 
-- El operador . combina dos funciones y produce una nueva función que es el resultado de aplicar una función a la salida de la otra. En el caso de f, map j . filter h es una aplicación 
-- parcial de las funciones map y filter a la lista, y luego se calcula la suma de los elementos resultantes. Esto es un ejemplo de aplicación parcial que hace que la afirmación sea verdadera.


-- c. La afirmación es Verdadera. La definición de f en Haskell es más expresiva que la función totalSueldosDeJuniors en JavaScript.
--  Esto se debe a que Haskell es un lenguaje de programación funcional que permite expresar operaciones sobre listas de una manera más compacta y legible.

-- En Haskell, la definición de f utiliza la composición de funciones (map, filter, sum) de manera concisa, lo que hace que sea más expresiva y clara.
--  Además, al utilizar funciones de orden superior, se puede lograr una abstracción más poderosa para operaciones en listas.

-- d. La afirmación es Verdadera. La definición de f en Haskell es más declarativa que la función totalSueldosDeJuniors en JavaScript.
--  La programación declarativa se centra en qué debe hacerse, mientras que la programación imperativa (como la de JavaScript) se centra en cómo se debe hacer.
-- En Haskell, la definición de f se basa en la composición de funciones y no se preocupa por los detalles de cómo se filtran, mapean y suman los elementos. Esto hace que el código sea más abstracto y expresivo en términos de la lógica de negocio.