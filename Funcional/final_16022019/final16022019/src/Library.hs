{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Use section" #-}
{-# HLINT ignore "Use newtype instead of data" #-}
module Library where
import PdePreludat

-- Se desea modelar en el paradigma funcional un sistema de reglas de un firewall. 
-- Existen paquetes que llegan al firewall, que tiene una serie de reglas, y el firewall no deja pasar
--  los paquetes que incumplan alguna regla. 
-- Un paquete tiene : una dirección de origen, una dirección de destino, y un contenido. 
-- Y puede haber varias reglas: 

--  como por ejemplo una que sólo deja pasar paquetes de direcciones internas (si los primeros 7 caracteres del origen son “192.168”),

--  una que no deja pasar paquetes con cierto destino exacto indicado por el administrador al configurar la regla,

--  o una que no deja pasar paquetes que contengan en su contenido alguna palabra de una lista negra indicada en dicha regla
--  (se puede asumir que existe una función incluyePalabra :: String -> String -> Bool
--  que verifica si el primer String contiene al segundo, para simplificar este problema).


-- Se pide:
-- 1. Definir tipos de datos y funciones (explicitando el tipo de todas ellas) para cubrir las necesidades explicadas.
-- 2. Mostrar cómo se representa un firewall de ejemplo que tenga las tres reglas mencionadas anteriormente.
-- 3. Desarrollar una función que permita saber qué paquetes de una lista de paquetes pasan por el firewall.
-- 4. Indicar dónde y para qué se utilizaron los siguientes conceptos: composición, aplicación parcial y orden superior.


-- firewall = [regla1,regla2,regla3]



type Contenido = String
type Direccion = String
type Regla = Paquete -> Bool

data Paquete = Paquete {
    direccionOrigen :: Direccion,
    direccionDestino :: Direccion,
    contenido :: [Contenido]
} deriving(Show,Eq)


data Firewall = Firewall{
    reglas :: [Regla]
}deriving(Show,Eq)

firewall :: Firewall
firewall = Firewall [soloDireccionesInternas]

-- PUNTO 2
firewall2 :: Firewall
firewall2 = Firewall [soloDireccionesInternas, prohibirDestino "300.300.300.1",filtrarContenido ["bocaca"]]

-- PUNTO 3
filtrarPaquetesPorReglas :: [Paquete] -> [Regla] -> [Paquete]
filtrarPaquetesPorReglas paquetes reglasFirewall = filter (\paquete -> all (\regla -> regla paquete) reglasFirewall) paquetes

soloDireccionesInternas :: Paquete -> Bool
soloDireccionesInternas  =  ("192.168"==).take 7.direccionOrigen

prohibirDestino  :: Direccion -> Paquete -> Bool
prohibirDestino destino paquete = direccionDestino paquete /= destino

filtrarContenido :: [Contenido] -> Paquete -> Bool
filtrarContenido listaNegra paquete = not . any (flip incluyePalabra listaNegra) $ contenido paquete 
-- filtrarContenido listaNegra paquete = not $ any (\word -> incluyePalabra word (contenido paquete)) listaNegra


incluyePalabra :: Eq a => a -> [a] -> Bool
incluyePalabra word1 word2 = elem word1 word2


paquete1 :: Paquete
paquete1 = Paquete "192.168.1.1" "192.168.1.2" ["bocaca","larenga"]
paquete2 :: Paquete
paquete2 = Paquete "200.200.200.1" "200.200.200.20" ["river","gallardios"]
paquete3 :: Paquete
paquete3 = Paquete "100.100.100.1" "100.100.100.20" ["lacri","unidosPorLaPlata"]

conjuntoDePaquetes :: [Paquete]
conjuntoDePaquetes = [paquete1,paquete2,paquete3]

conjuntoDeReglas :: [Paquete -> Bool]
conjuntoDeReglas = [prohibirDestino "192.168.1.2",filtrarContenido["lacri"]]

-- Ejemplo de aplicacion
-- filtrarPaquetesPorReglas conjuntoDePaquetes conjuntoDeReglas

-- Output 
-- [Paquete {direccionOrigen = "192.168.20.1", direccionDestino = "192.168.20.20", contenido = ["lacri","unidosPorLaPlata"]}]