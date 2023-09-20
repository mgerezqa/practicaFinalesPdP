{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use section" #-}
module Library where
import PdePreludat


data Producto = Prod {
    nombre :: String,
    precio :: Number
}

queEmpieceConA :: Criterio
queEmpieceConA = (== 'a') . head . nombre



barato :: Criterio
barato = (<50) . precio


restriccionesDeCompra :: [Criterio]
restriccionesDeCompra = [queEmpieceConA, barato]
pureCica = Prod "pure de tomates" 12


-- 1. Definir los tipos de la función restriccionesDeCompra
type Criterio = Producto -> Bool

-- 2. Modificar la función queEmpieceConA para que verifique que el nombre
-- del producto comience con una letra que se pase como parametro. Indicar
-- que cambiaria en la reprentación de restriccionesDeCompra y que concepto está 
-- relacionado

queEmpieceConA' :: Char -> Criterio
queEmpieceConA' letra = (== letra) . head . nombre

-- Cambios en restriccionesDeCompra', el cambio que habría que hacer es pasar como 
-- parametro la letra que estamos enviando como criterio de busqueda, en terminos de tipos
-- de la función no es necesario redefinirla pues, estamos haciendo uso del concepto de currificación.

restriccionesDeCompra' :: [Criterio]
restriccionesDeCompra' = [queEmpieceConA' 'a', barato]

-- El concepto relacionado aquí es la parametrización de funciones. Al permitir que la letra sea un parámetro de la función queComienceCon, hemos generalizado la función para que pueda verificar si el nombre comienza con cualquier letra en lugar de una letra fija ('a' en este caso).
--  Esto hace que el código sea más flexible y reutilizable, ya que puedes crear criterios específicos para diferentes letras.

-- 3. Codificar una función que permita establecer, dada una lista de productos y una lista de restricciones
-- ,cuales productos verifican todas las restricciones. Que conceptos se destacan en tu solucion y porque


cumpleTodasLasRestricciones :: Producto -> [Criterio] -> Bool
cumpleTodasLasRestricciones unProducto =  all (aplicarCriterio unProducto)

aplicarCriterio :: Producto -> Criterio -> Bool
aplicarCriterio producto criterio = criterio producto

todosLosQueCumplen :: [Criterio] -> [Producto] -> [Producto]
todosLosQueCumplen listaDeCriterios = filter (flip cumpleTodasLasRestricciones listaDeCriterios)  

--  solución utiliza conceptos de funciones de orden superior, composición de funciones y abstracción para
--  encontrar los productos que cumplen con todas las restricciones de manera eficiente y legible.
--  La función cumpleTodasLasRestricciones juega un papel
--  importante en esta solución al verificar si un producto cumple con múltiples criterios de restricción.