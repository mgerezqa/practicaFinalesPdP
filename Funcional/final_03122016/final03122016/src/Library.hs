module Library where
import PdePreludat
import GHC.Num (Num)

-- Se tiene la siguiente función:
-- f x y = (>10).head.filter (x y)

-- ******************   PREGUNTAS   *****************************************
-- 1.   Inferir el tipo de la función f
-- 2.   Mostrar un ejemplo de uso de la función f usando una lista infinita e indicar si dicha evaluación puede
-- terminar justificando la respuesta conceptualmente.
-- 3.   V/F: Si f se definiera recursivamente en vez de usando filter, la solución sería más declarativa. ¿Por qué?

-- ******************   RESPUESTAS   *****************************************

f :: ( a -> Number -> Bool) -> a -> [Number] -> Bool
f x y = (>10).head.filter (x y)

-- La función f toma tres argumentos:

-- Un argumento de tipo función llamado x que toma un valor de tipo a y un número (Number) y devuelve un booleano (Bool).
-- Un valor de tipo a.
-- Una lista de números ([Number]).
-- Devuelve un booleano (Bool) como resultado.

-- Definimos una función que verifica si un número es mayor que n.
esMayorQueN :: Number -> Number -> Bool
esMayorQueN n x = x >  n

-- Usamos la función f con la función esMayorQueN, un valor 5, y una lista infinita de números naturales.
resultadoQueNoTermina = f esMayorQueN 5 [1..]
-- La evaluación no terminará. Dado que estamos usando una lista infinita, la función `filter` nunca terminará de buscar un elemento que cumple la condición (> 5), 
-- ya que siempre habrá más números en la lista. Por lo tanto, la evaluación será infinita y nunca producirá un resultado.


resultadoQueSiTermina = f esMayorQueN 5 [1,2,3,5,11]
-- La función retornará como resultado true, pues se busca el primer numero mayor a 5 y que ademas sea >10.


