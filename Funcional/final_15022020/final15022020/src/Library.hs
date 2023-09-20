{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use section" #-}
module Library where
import PdePreludat
data Persona = Persona { nombre :: String, edad :: Number, bebidas :: [Bebida]}
type Bebida = Persona -> Persona


agregarBebida :: Bebida -> Persona -> Persona
agregarBebida bebida (Persona n e bs)  = Persona n e (bebida:bs)

-- ENUNCIADO ORIGINAL 
-- cafe :: Bebida
-- cafe (Persona n e bs) = Persona n (e + 1) (cafe:bs)

-- cindor :: Bebida
-- cindor (Persona n e bs) = Persona ("Energizado" ++ n) e (cindor:bs)

-- gatorade :: Bebida
-- gatorade (Persona n e bs) = Persona n e (gatorade:bs) 

-- tomar ::  Bebida -> Persona -> Persona
-- tomar  unaBebida persona  = unaBebida persona
cafe :: Bebida
cafe (Persona n e bs) = Persona n (e + 1) bs

cindor :: Bebida
cindor (Persona n e bs) = Persona ("Energizado" ++ n) e bs
 
gatorade :: Bebida
gatorade persona = persona

tomar :: Bebida -> Persona -> Persona
tomar unaBebida = unaBebida  . agregarBebida unaBebida

puedeTomar :: Persona -> Bebida -> Bool
puedeTomar persona unaBebida = ((< 60) . edad . tomar unaBebida) persona


juan :: Persona
juan = Persona "Juan" 23 []

-- Preguntas
-- 1. Que pasara si se hacen las siguientes consultas Justificar conceptualmente
-- a) > puedeTomar cafe juan
-- b) > edad juan

-- Respuesta 
-- a) > puedeTomar cafe juan
-- Se espera que ocurra un error de tipo, pues las funcion puedeTomar espera como primer
-- parametro un tipo de dato Persona y luego un dato Bebida 
-- b) > edad juan
--  Obtendremos 23, pues edad es una función creada de forma implicita la cual  espera como primer parametro
-- el tipo de dato Persona y responde con un valor de tipo numerico que representa la edad 

-- 2. Hay logica repetida entre las bebidas? En caso positivo, proponer una solución para evitarlo e indicar qué 
-- conceptos se aprovechan. En caso negativo Justificar porque no.

-- Si hay logica repetida ya que en todas las funciones que describen  las bebidas del modelo, las mismas 
-- se  agregan como primer elemento de  la lista de bebidas de la persona, se plantea una solucion alternativa
-- para extraer ese comportamiento y luego modificar la funcion tomar bebida, que ademas de hacer que la persona beba 
-- la bebida en cuestion, la agregue a su lista, mediante el uso de composicion de funciones y la currificacion , ya

-- Composición de funciones: La composición de funciones es una técnica común en la programación funcional donde 
-- puedes combinar dos o más funciones para crear una nueva función. 
-- En este caso, unaBebida . agregarBebida unaBebida significa que estás componiendo dos funciones: unaBebida y agregarBebida unaBebida.
--  Esto significa que primero se aplicará agregarBebida unaBebida a la entrada de tomar, 
-- y luego el resultado se pasará como entrada a unaBebida.
--  En otras palabras, esta composición permite que la persona primero 
-- agregue la bebida deseada a su lista de bebidas y luego tome esa bebida.

-- Aplicación parcial y currificación: La aplicación parcial es un concepto en el que aplicas una función 
-- a menos argumentos de los que espera inicialmente y obtienes una función que espera los argumentos restantes. 
-- La currificación es una técnica relacionada 
-- donde una función que toma múltiples argumentos se transforma en una serie de funciones que toman un solo argumento.
--  En este caso, agregarBebida unaBebida está aplicando parcialmente la función agregarBebida a unaBebida, 
-- lo que resulta en una función que espera solo la Persona a la que se le aplicará la bebida.

-- La unica repetición de codigo que se puede observar es que la bebida, se inserta en la cabeza de la lista de bebidas
-- de la persona. 


-- 3.Dada la siguiente funcion
-- Indicar el tipo
f :: Persona -> [Bebida] -> Persona
f persona = head . map (flip tomar persona) . filter (puedeTomar persona) 

-- La idea de esta funcion es dada una persona y una lista de bebidas posibles, determinar
-- si la persona es capaz de tomarla (de acuerdo a su edad) y luego hacer que la persona beba 
-- esa bebida , de la lista resultante obtener la primer persona