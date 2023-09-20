{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use null" #-}
module Library where
import PdePreludat


-- Para cada medicamento:


amoxicilina :: Medicamento
amoxicilina = cura "infección"
bicarbonato :: Medicamento
bicarbonato = cura "picazón"
sugestion _ = []

-- cura :: Sintoma -> Enfermedad -> Sanacion
cura :: Sintoma -> Medicamento
cura sintoma = filter (/= sintoma)

-- Para cada enfermedad / conjunto de sintomas:
malMovimiento :: Enfermedad
malMovimiento = ["dolor agudo", "hinchazón"]
varicela ::  Enfermedad
varicela = repeat "picazón"

-- repeat x = x : repeat x

mejorMedicamentoPara :: Enfermedad -> [Medicamento] -> Medicamento
mejorMedicamentoPara sintomas = head . filter(idealPara sintomas)
-- mejorMedicamentoPara sintomas medicamentos = head $ filter (\medicamento -> idealPara sintomas medicamento) medicamentos

idealPara ::Enfermedad -> Medicamento  -> Bool
idealPara sintomas medicamento = medicamento sintomas == []


-- Se pide:

-- 1.Definir el tipo de Medicamento en base al modelo dado, y explicitar el tipo de la función mejorMedicamentoPara.

type Sintoma = String
type Enfermedad = [Sintoma]
type Sanacion = [Sintoma]
type Medicamento = Enfermedad -> Sanacion

-- 1. Definir el tipo de Medicamento en base al modelo dado y explicitar el tipo de la función mejorMedicamentoPara.

-- Rta
-- type Sintoma = String
-- type Enfermedad = [Sintoma]
-- type Sanacion = [Sintoma]
-- type Medicamento = Enfermedad -> Sanacion

-- mejorMedicamentoPara :: Enfermedad -> [Medicamentos] -> Medicamento

-- 2. Explicar que  beneficio aporta el uso de orden superior en la definición de mejorMedicamentoPara

-- Rta: Los beneficios de la implementación son los siguientes: la función retorna el primer medicamento ideal para combatir un conjunto de sintomas,
-- es decir, define en si misma el criterio para combatir un medicamento, lo cual representa una ventaja si a futuro se quisiese modificar el concepto 
-- de como lidiar con un sintoma, porque  esta responsabilidad está delegada en la función idealPara. Al incorporar el uso de orden superior 
-- hacemos que nuestra  solución sea mas escalable y que no esté fuertemente acoplada, lo cual es una ventaja.
-- Expresividad : 

-- La función mejorMedicamentoPara se define en términos de funciones de orden superior como filter y head. Esto permite abstraer 
-- la lógica de selección del medicamento adecuado para los síntomas proporcionados en funciones separadas. La abstracción hace que el código sea más legible y fácil de entender.

--3a) Definir y explicitar el tipo del ibuprofeno para que pueda usarse como medicamento, que cure tanto el "dolor agudo" como la "hinchazon" si es de mas de 500 mg
-- y de lo contrario cure el "dolor moderado". 

-- 3b)Armar una lista de medicamentos que incluya amoxicilina e ibuprofeno de 400 mg. En caso de que se esté aprovechando algun concepto importante para llevarlo a cabo mencionarlo

type Ibuprofeno = Number -> Enfermedad -> Sanacion
ibuprofeno :: Ibuprofeno
ibuprofeno cantidad 
                    | cantidad > 500 =  cura "hinchazon" . cura "dolor agudo"  
                    | otherwise = cura "dolor moderado"


listaDeMedicamentos :: [Enfermedad -> Sanacion]
listaDeMedicamentos = [ibuprofeno 400,amoxicilina]

-- El concepto involucrado en la solución es el de currificación 
-- La currificación es una técnica en la programación funcional en la que una función que toma múltiples argumentos se convierte en una serie de funciones que toman un solo argumento cada una.
-- En el caso del "ibuprofeno," hemos definido una función ibuprofeno que toma dos argumentos: cantidad y sintomas. Sin embargo, también hemos utilizado la currificación al definir 
-- una función parcial ibuprofeno 400, que toma solo un argumento (sintomas) y aplica automáticamente la cantidad de 400 mg.

-- Este enfoque permite crear fácilmente diferentes versiones de la función ibuprofeno para diferentes cantidades sin tener que definir una función separada para cada una.
--  La currificación es una técnica poderosa en la programación funcional que aumenta la flexibilidad y la reutilización de código.


--4 Que sucedera al evaluar las siguientes consultas? justificar conceptualmente. En caso de errores o comportamientos inesperados, indicar cuales son y donde ocurren.
-- 4a.

-- mejorMedicamentoPara malMovimiento repeat bicarbonato

consultaA :: Medicamento
consultaA = mejorMedicamentoPara malMovimiento (repeat bicarbonato)

--  la consulta debería funcionar en términos conceptuales debido a la evaluación perezosa. Haskell buscará el mejor medicamento en la lista infinita de medicamentos generada por repeat bicarbonato, 
-- pero no será necesario evaluar toda la lista debido a la evaluación perezosa. Una vez que se encuentre un medicamento adecuado, la búsqueda se detendrá.

-- 4b.
-- mejorMedicamentoPara varicela [sugestion,bicarbonato,amoxicilina]
consultaB :: Medicamento
consultaB = mejorMedicamentoPara varicela [sugestion,bicarbonato,amoxicilina]

-- varicela = repeat "picazón"


-- La segunda consulta mejorMedicamentoPara varicela [sugestion, bicarbonato, amoxicilina] busca el mejor medicamento para tratar la enfermedad "varicela" en una lista de medicamentos que incluye [sugestion, bicarbonato, amoxicilina]. Aquí hay una evaluación conceptual de esta consulta:

-- varicela es una lista infinita que contiene el síntoma "picazón" repetido infinitamente.

-- [sugestion, bicarbonato, amoxicilina] es una lista de tres elementos: sugestion, bicarbonato, y amoxicilina.

-- La función mejorMedicamentoPara toma varicela como primer argumento y [sugestion, bicarbonato, amoxicilina] como segundo argumento.

-- La función mejorMedicamentoPara buscará el mejor medicamento en la lista de [sugestion, bicarbonato, amoxicilina] para tratar la enfermedad "varicela".

-- Dado que varicela es una lista infinita, Haskell utilizará evaluación perezosa para no generar toda la lista de medicamentos. En lugar de eso, buscará el mejor medicamento de manera perezosa, es decir, solo evaluará los elementos necesarios de la lista de medicamentos hasta encontrar el medicamento adecuado.

-- Conceptualmente, la evaluación se desarrollará de la siguiente manera:

-- Haskell comenzará a buscar en la lista de [sugestion, bicarbonato, amoxicilina] y aplicará cada medicamento a la lista infinita varicela utilizando la función idealPara.

-- Tan pronto como encuentre un medicamento que sea ideal para tratar "varicela" (es decir, que devuelva una lista vacía cuando se aplique a "picazón"), seleccionará ese medicamento como el mejor y detendrá la búsqueda. No es necesario evaluar toda la lista de medicamentos, ya que hemos encontrado uno que satisface las condiciones.