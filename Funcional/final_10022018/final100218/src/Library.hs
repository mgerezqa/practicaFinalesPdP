{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant map" #-}
module Library where
import PdePreludat

f :: Ord a1 => a1 -> (a2 -> a1) -> (a3, [a2]) -> Bool
f h p = any (<h) . map p . snd 


-- PREGUNTAS 
-- 1.   Dar el tipo de la función f.


-- 2.   Mejorar la función f en términos de expresividad.

-- 3.   Dar dos ejemplos de invocación, uno que termine y otro que no, que sirvan para explicar la
-- estrategia de evaluación de Haskell.

-- Ejemplos de invocación


-- RESPUESTAS
-- 1
-- f :: Ord a1 => a1 -> (a2 -> a1) -> (a3, [a2]) -> Bool

-- 2
algunoDeLaListaCumpleCriterio :: Ord a1 => a1 -> (a2 -> a1) -> (a3, [a2]) -> Bool
algunoDeLaListaCumpleCriterio criterio funcion = any (<criterio) . map funcion . listaDeLaTupla

listaDeLaTupla :: (a, b) -> b
listaDeLaTupla = snd 

-- 3

-- Termina
--  f 3 (1+) ("No importa que",[1,2,3,5])

--  f 3 (\x -> x + 2) ("No importa que",[1,2,3,5])

-- La funcion aplica al segundo parametro de la tupla, la lista, la suma de 1 con c/u de los elementos de la lista, luego pregunta si alguno es menor que 3. 

-- No termina
-- f 3 (1+) ("No importa que",[1..])

-- Como el segundo parametro de la tupla es una lista infinita, el programa no va a terminar nunca de generar esa lista, por lo tanto, no se va a poder 
-- evaluar el criterio de  finalización. 

-- Este ejemplo no terminará. La tupla contiene una lista infinita [1, 2, 3, ...]. La función f intentará verificar si algún elemento de la lista es menor que 10, pero como la lista es infinita, nunca se terminará de evaluar.

-- En Haskell, se utiliza una estrategia de evaluación perezosa, lo que significa que solo se evalúan las partes necesarias de la expresión para obtener un resultado. En el segundo ejemplo, la evaluación se quedará atrapada en la lista infinita, y la función nunca terminará de ejecutarse.