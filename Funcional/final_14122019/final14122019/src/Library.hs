{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Redundant bracket" #-}
module Library where
import PdePreludat

funcion :: (Ord a) => a -> b -> [(b -> a)] -> [a]

funcion x y lista = (filter (> x) . map (\ f -> f y)) lista

-- PREGUNTAS

-- 1. Explicar lo que hace y proponer mejoras en términos de expresividad.

-- 2. ¿Sería posible evaluar la función con una lista infinita de modo que dicha evaluación termine?
-- Justificar conceptualmente y plantear un ejemplo para fundamentar la respuesta.

-- 3. Indicar cuáles de las siguientes expresiones son válidas. Para las que son válidas indicar además el
-- tipo de retorno y para las que no son válidas justificar el motivo.
-- a. funcion 3 "hola" []
-- b. funcion 3 7
-- c. funcion "chau" "hola" [length]

-- RESPUESTAS
-- 1
-- La función toma una lista de funciones (lista) y dos valores (x e y).
--  Primero, aplica cada función en lista al valor y, y luego filtra los resultados, reteniendo solo aquellos que son mayores que x.


-- map (\f -> f y) lista: Esto aplica una función anónima lambda a cada elemento de lista, 
-- donde la función toma un argumento f y le aplica f y. En otras palabras, aplica cada función de la  lista al valor y.
-- filter (> x): Luego, la función filter filtra la lista resultante de la etapa anterior.
--  Retiene solo los elementos que son mayores que x.


-- 2
-- Falso, por la naturaleza de la función, la misma evaluará completamente la lista completa, aplicando una función a Y (definida en cada elemento de la lista) 
-- y luego filtrando los resultados, por ende. No es posible evaluar una lista infinita.

consultaQueNoTermina = funcion 2 5 [(2+),(3+)] ++ repeat 1

-- 3.a  -> Valida -> retorna una lista vacia porque se aplica una lista vacia 
-- 

-- Ahora evaluemos cada expresión:

-- a. funcion 3 "hola" []

-- 3 es de tipo Num a, donde a es una instancia de Num.
-- "hola" es de tipo String.
-- [] es una lista vacía.
-- La expresión es válida ya que coincide con la firma de la función funcion.
-- El tipo de retorno será [a], es decir, una lista de elementos del mismo tipo que 3. En este caso, el tipo de retorno será [Int].


-- b. funcion 3 7

-- 3 es de tipo Num a, donde a es una instancia de Num.
-- 7 es de tipo Num a, donde a es una instancia de Num.
-- La expresión es válida ya que coincide con la firma de la función funcion.
-- El tipo de retorno será [a], es decir, una lista de elementos del mismo tipo que 3. En este caso, el tipo de retorno será [Int].

-- c. funcion "chau" "hola" [length]

-- "chau" es de tipo String.
-- "hola" es de tipo String.
-- [length] es una lista que contiene una función length, que toma un String y devuelve un Int.
-- La expresión no es válida porque el tipo de y en la función funcion debe coincidir con el tipo de los elementos en la lista de funciones [b -> a]. 
-- En este caso, y debería ser de tipo String para que la lista de funciones sea compatible con funcion.
--  Sin embargo, y es de tipo String, mientras que b en funcion es un tipo polimórfico, por lo que no hay una coincidencia de tipos adecuada.

-- En resumen:

-- Las expresiones a y b son válidas, con un tipo de retorno [Int].
-- La expresión c no es válida debido a una discrepancia en los tipos de los argumentos y las funciones en la lista proporcionada.