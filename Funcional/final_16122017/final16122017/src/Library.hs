module Library where
import PdePreludat

-- Parte A
-- De un alumno se conocen su nombre, su dedicación (medida en horas) y los conceptos que aprendió hasta el momento
-- en la carrera. Por ejemplo, PdeP es una materia en la cual se enseñan conceptos nuevos (como orden superior,
-- polimorfismo, etc.) y compliqueti101 es una materia que suma 100 horas de dedicación por cada reentrega de TP
-- realizada.

-- Se tiene a los alumnos modelados en Haskell de la siguiente forma:

data Alumno = Alumno {
    nombre :: String , 
    dedicacion :: Number ,
    conceptos :: [String] 
      }

jonSnow = Alumno "Jon Snow" 800 ["nothing"]


-- Y las materias modeladas con estas funciones:

pdep conceptosNuevos (Alumno n d cs) = Alumno n d (cs ++ conceptosNuevos)

compliqueti101 reentregas (Alumno n d cs) = Alumno n (d + reentregas * 100) cs


-- ************************    PREGUNTAS   **********************************************

-- 1.
    -- a. Muestre un ejemplo de uso (una única consulta) para enseñar a jonSnow “polimorfismo” e “inversibilidad”
    -- y sumarle 500 horas de dedicación mediante estas materias.

    -- b. Luego de la consulta del punto a, explicar conceptualmente cuál será el resultado de consultar:
    -- > dedicacion jonSnow

-- 2. ¿Puede modelarse una cursada en forma de una lista de materias? Explique CON EJEMPLOS qué concepto principal permite o impide su implementación.

-- 3. Existe una materia recursividad que, dado un alumno, le enseña una lista infinita de conceptos 

    -- “Recursividad 1”, “Recursividad 2”, “Recursividad 3”, etc.
    
    --  Dada la siguiente expresión:
-- > (elem “nothing” . conceptos . recursividad) jonSnow

-- Mostrar ejemplos de implementación de la función recursividad 1 para los cuales:

    -- a. La expresión indicada termina de evaluarse. Explicar qué lo permite.
    -- b. La expresión indicada NO termina de evaluarse. Explicar qué lo impide.


    
-- ************************    RESPUESTAS   **********************************************


-- punto 1a
conceptosPdep = pdep ["polimorfismo","inversibilidad"]  
punto1a = compliqueti101 5 . conceptosPdep

-- punto 1b
    -- > dedicacion jonSnow

-- Rta: la consulta retornará el valor  800, ya que en el paradigma funcional no existe el concepto de asignación destructiva/ mutabilidad de variables, por lo tanto el valor
    -- retornado  será  la dedicación inicial declarada en la estructura original jonSnow que es 800.

-- punto 2

-- Agregado solo para generar otro elemento a la lista 
ads conceptosNuevos (Alumno n d cs) = Alumno n d (cs ++ conceptosNuevos)

cursada2anio = [pdep ["inversibilidad"], ads ["gantt"], compliqueti101 10]

-- Rta: Si se puede modelar una cursada en forma de lista de materias, haciendo la aclaración que la lista estará compuesta por funciones que esperan 
-- recibir su primer parametro para luego recibir el resto de sus parametros al momento de ser usadas,
-- el concepto que interviene es el de currificación pues estoy transformando una función de 3 parametros a una función que recibe 1 parametro y retorna una función del tipo  (Alumno -> Alumno) ,
-- ademas las funciones tienen que poseer el mismo tipo ya que la listas son homogeneas.

-- punto 3

    --  Dada la siguiente expresión:
-- > (elem “nothing” . conceptos . recursividad) jonSnow

-- 3a) recursividad3a = (elem “nothing” . conceptos . recursividad) jonSnow


-- Rta 3a
-- Esta expresion finaliza al realizar la consulta, pues recordando que la estructura jonSnow tiene en su lista de conceptos el string "nothing",
-- al aplicarle la funcion compuesta  se  buscara por la cabeza de la lista la palabra "nothing" en la lista de strings, y como el primer resultado que se evaluara será el buscado
-- y ya que haskell funciona mediante evaluación perezosa, finalizará el barrido de la lista  de conceptos de jonSnow  porque ya encontro un resultado que satisfizo la consulta  entonces la funcion retornará true.


-- Rta 3b
-- 3a) recursividad3b = (elem “loopInfinito” . conceptos . recursividad) jonSnow
-- Este ejemplo no finalizará nunca , pues a medida que se incoroporen conceptos de forma infinita fdel tipo "recursividad1" ... , el motor de haskell intentará buscar la palabra "loopInfinito" que no existe dentro de
-- la estructura y por lo tanto el programa no finalizará