% La fábrica de muebles Armando requiere de su manejo de stock de los productos que realiza en sus distintos
% locales. Manejan los siguientes productos:
% ● Sillones: que tiene un tipo (común, cama, reclinable) y cantidad de módulos
% ● Mesas: forma (rectangular, cuadrada, circular) y material (madera, vidrio)
% ● Sillas: material (metal, madera)
% Se tiene la siguiente base de conocimiento:

%stock(sucursal, producto, cantidad)
stock(boedo, sillon(comun, 3), 4).
stock(boedo, silla(madera), 12).
stock(flores, sillon(cama, 2), 1).

stock(flores, silla(metal), 4).
stock(belgrano, sillon(reclinable, 2), 3).
stock(belgrano, silla(madera), 8).

% /*********** PREGUNTAS ***********/

% Realizar la codificación y las justificaciones para cada punto:
% 1. Sabiendo que tenemos los siguientes clientes:
%   ○ Mati, que busca una mesa circular de vidrio y 4 sillas de metal.
%   ○ Leo, que busca un sillón cama de 2 módulos y otro reclinable de 1.
% Agregar la información a la base de conocimientos, sabiendo que se debe poder responder la consulta
% “¿Qué busca Leo?” (por ejemplo). ¿Hace falta usar listas para representar la información? Si es
% posible, hacerlo sin usar listas y explicar los conceptos que lo permiten, y en caso contrario hacerlo
% con listas y explicar por qué son necesarias.


% 2. Saber si una sucursal trabaja un determinado material. Trabaja el mismo si alguno de sus artículos son
% de ese material, y se sabe que todos los sillones que trabajan son de madera. ¿Qué concepto resalta
% en la resolución de este punto y dónde puede verse?

% 3. Saber si hay una sucursal ideal para un cliente, del cual se conoce su nombre y la información que se
% agregó en los puntos anteriores. Una sucursal es ideal si tiene en stock todo lo que el cliente busca.
% ¿Qué concepto aparece que no estaba siendo usado antes?

% /*********** RESPUESTAS ***********/

cliente(Cliente):-busca(Cliente,_,_).


% busca(Cliente,Articulo,Cantidad)
busca(mati,mesa(circular,vidrio),1).
busca(mati,silla(metal),4).

busca(leo,sillon(cama,2),1).
busca(leo,sillon(reclinable,1),1).

busca(martin,silla(madera), 6).

queBusca(Cliente,Articulo,Cantidad):- busca(Cliente,Articulo,Cantidad).

% 1. No es necesario el uso de listas para representar lo que buscan los clientes. Se puede lograr mediante la declaración de hechos y reglas.


% 2 
trabajaCon(Sucursal,Material):-
    materialDelArticulo(Articulo,Material),
    stock(Sucursal,Articulo,_).

materialDelArticulo(sillon(_,_),madera).

materialDelArticulo(silla(Material),Material).

materialDelArticulo(mesa(_,Material),Material).

% El concepto que resalta es el uso de polimorfismo en el predicado materialDelArticulo, ya que el mismo acepta en su primer argumento,
% un articulo cualquiera expresado como un functor y mediante el pattern matching de su estructura extrae el material del Articulo.


% 3. Saber si hay una sucursal ideal para un cliente, del cual se conoce su nombre y la información que se
% agregó en los puntos anteriores. Una sucursal es ideal si tiene en stock todo lo que el cliente busca.
% ¿Qué concepto aparece que no estaba siendo usado antes?

sucursalIdeal(Cliente, Sucursal) :-
    cliente(Cliente),
    stock(Sucursal,_, _),  % Asegura que la sucursal tiene al menos un artículo

    forall(busca(Cliente, Articulo, CantidadBuscada), tieneLaCantidadNecesaria(Sucursal, Articulo, CantidadBuscada)).

tieneLaCantidadNecesaria(Sucursal, Articulo, CantidadNecesaria) :-
        stock(Sucursal, Articulo, CantidadDisponible),
        CantidadDisponible >= CantidadNecesaria.
