module Library where
import PdePreludat

-- Parte C
-- Tenemos la siguiente función:
-- f x _ [] = x
-- f x y (z:zs)
--  | y z > 0 = z + f x y zs
--  | otherwise = f x y zs


-- ******************* PREGUNTAS   *************************
-- 1. Declarar el tipo de la función f.
-- 2. Definir nuevamente la función f de modo que sea más declarativa.
-- 3. Indicar qué conceptos se aplicaron en la nueva solución mostrando dónde aparecen. ¿Qué es lo que -- hace que la misma sea más declarativa?
-- 4. ¿Qué pasaría si a f se le aplica como último parámetro una lista infinita?


-- ******************* RESPUESTAS   *************************
-- f ::  Number -> (Number -> Number) -> [Number] -> Number 
-- f :: (a -> Number -> Bool) -> a -> [Number] -> Number

f :: Number -> (Number -> Number) -> [Number] -> Number
f x _ [] = x
f x y (z:zs)
 | y z > 0 = z + f x y zs
 | otherwise = f x y zs


-- f' :: Number -> (Number -> Number) -> [Number] -> Number
f' :: Number -> (Number -> Number) -> [Number] -> Number
f' valor _ [] = valor
-- f' x y lista  = x + sum (filter (\z -> y z > 0) lista)
f' valor fnumerica lista = valor +  sum ( filter (>0) . map fnumerica $ lista)
-- 4 
-- Si a  f se le aplica una lista infinita, el programa entraria en un loop, y no finalizará.

-- Si a la función f se le aplica como último parámetro una lista infinita, la evaluación nunca terminará. Dado que la función utiliza una comprensión de listas para filtrar
--  elementos de la lista que cumplan con la condición y z > 0,
--  y una lista infinita siempre tendrá más elementos para evaluar, la evaluación de la comprensión de listas nunca se completará. Esto resultará en un bucle infinito y la función nunca retornará un valor.
