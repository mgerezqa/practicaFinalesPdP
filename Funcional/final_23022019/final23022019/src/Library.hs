{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use notElem" #-}
{-# HLINT ignore "Use infix" #-}
module Library where
import PdePreludat
import Text.ParserCombinators.ReadP (between)

-- A partir del siguiente código:
data Futbolista = UnFutbolista {posiciones :: [Number], goles :: Number} deriving (Show, Eq)
tito = UnFutbolista [9,10] 47
meterGoles cant (UnFutbolista posiciones goles) = UnFutbolista posiciones (goles+cant)
jugarDe posicion (UnFutbolista ps goles) = UnFutbolista (agregarPosicion posicion ps) goles
agregarPosicion p ps 
    | not (elem p ps) && entre 1 11 p = p : ps
    | otherwise = ps

entre :: Number -> Number -> Number -> Bool
entre n1 n2 otro  = otro  >= n1  && otro <= n2 

-- 1. En cada una de las consolas siguientes, ¿qué sucede en la última consulta? ¿Hay respuesta? ¿Cuál es?
-- Justifique conceptualmente en todos los casos.

-- Consola A)
            -- > tito
            -- UnFutbolista [9,10] 47
            -- > meterGoles 2 tito
            -- UnFutbolista [9,10] 49
            -- > goles tito
            -- ???????
-- Consola B)
            -- > jugarDe 2 (UnFutbolista [3..] 1)
            -- ????????
-- Consola C)
            -- > meterGoles 3
            -- ????????

-- 2. Usando composición, escriba una consulta que permita conocer si, luego de haber jugado de 4 y haber jugado
-- de nuevo de 10, es cierto que tito jugó en más de 2 posiciones.

-- 3. Dadas las funciones f, g y h de las cuales sólo conocemos su tipo:

-- f :: (a -> b) -> c -> (b, c) 

-- g :: a -> a -> Bool 

-- h :: [a] -> [b]

-- Indicar cuáles de las siguientes expresiones tipan (indicando cuál es el tipo de dicha expresión) y cuáles no
-- (indicando el motivo por el cuál no tipan):

-- a. f h . g 3
-- b. g 3 . h
-- c. f even . g 1 2


-- RESPUESTAS
-- 1
-- Consola A)
            -- > tito
            -- UnFutbolista [9,10] 47
            -- > meterGoles 2 tito
            -- UnFutbolista [9,10] 49
            -- > goles tito
            -- 47

-- justificación: En el paradigma funcional no existe el concepto de mutabilidad de variables, o efecto de lado, 
-- la funcion meterGoles no produce ningun tipo de efecto sobre tito
-- la funcion goles es una funcion que espera en su primer argumento un tipo de dato Futbolista, al cual le aplica la funcion goles para acceder a la cantidad de goles que tiene la estructura definida (tito)

-- Consola B)
            -- > jugarDe 2 (UnFutbolista [3..] 1)

    -- Justificación: la consulta no finaliza, pues estamos definiendo una lista infinita en la estructura del data futbolista, como la funcion jugarDe 2 
    -- le agrega una nueva posicion al futbolista y lo retorna al futbolista completo, con la posicion nueva en la cabeza de la lista.
    -- al declarar una lista infinita en la estructura Haskell no podrá terminar de construir nunca al futbolista y quedará atascado en un loop infinito

-- Consola C)
            -- > meterGoles 3
            -- retornará algo así como <una Funcion>, que será una nueva función resultante  de aplicar parcialmente la función meterGoles 3 y que espera un Futbolista como parametro de entrada.


-- 2
--  Usando composición, escriba una consulta que permita conocer si, luego de haber jugado de 4 y haber jugado
-- de nuevo de 10, es cierto que tito jugó en más de 2 posiciones.

titoJugoEnMasDe2Posiciones :: Bool
titoJugoEnMasDe2Posiciones =  ((>2). length).(posiciones . jugarDe 4 .jugarDe 10) $ tito

-- Output
-- *Library> titoJugoEnMasDe2Posiciones 
-- True

-- La consulta es verdadera porque tito ya habia jugado como 9 y 10 , y se le agregó la posicion de 4.


-- 3
-- f :: (a -> b) -> c -> (b, c) 
-- g :: a -> a -> Bool 
-- h :: [a] -> [b]
-- Indicar cuáles de las siguientes expresiones tipan (indicando cuál es el tipo de dicha expresión) y cuáles no
-- (indicando el motivo por el cuál no tipan):

-- a. f h . g 3 --> no tipa,  h espera una lista de [a] mientras que  g retorna un tipo Booleano
-- b. g 3 . h -> no tipa, g espera un elemento a, mientras que h retorna una lista de elementos
-- c. f even . g 1 2 -> no tipa, even espera un dato numerico mientras que g retorna un booleano

