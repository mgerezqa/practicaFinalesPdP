% Se conocen los platos que ofrece cada restaurante, y sabiendo que se considera bodegón a un restaurante si todos sus
% platos tienen precio menor a $300 y además ofrece mila.

% plato(restaurante, plato, precio)
plato(laAngioplastia,mila,180).
plato(laAngioplastia,bife,230).
plato(laAngioplastia,molleja,220).
plato(lasVioletas,bife,450).
plato(elCuartito,muzza,290).

bodegon(Restaurante):-
    not((plato(Restaurante,_,Precio),Precio >= 300)).

bodegon(Restaurante):-
    tieneMila(Restaurante).

tieneMila(Restaurante):-
    findall(Plato, plato(Restaurante,Plato,_), Platos),
    member(mila,Platos).


    % 1. Responda verdadero o falso y justifique en todos los casos:
    % a. Hay que usar forall para solucionar el error de lógica del predicado bodegon/1.
    % b. El predicado bodegon/1 es inversible.
    % 2. Critique la solución en términos de declaratividad y expresividad.
    % 3. Proponga una solución que resuelva los problemas encontrados en los puntos anteriores.

    % Respuestas
% 1a y 1b) Falso, no es necesario usar el predicado forall, se puede implementar la solucion con el predicado not. 
% La solución propuesta no va a funcionar de acuerdo a las especificaciones mencionadas, pues existen problemas de inversibilidad en el predicado
% bodegon y tieneMila, ya que tanto el predicado not como findall, requieren que las variables libres lleguen ligados al predicado para usarse, ademas
% de que la logica no es correcta, pues no se realiza bien la conjunción para lograr obtener los restaurantes , que ademas de tener los precios de los platos por debajo
% de los $300 tengan milanesa en su menu.

% 2) La solucion no es del todo declarativa pues la logica de bodegon se nuclea principalmente en el predicado, podrian haberse separado las responsabilidades, mediante el uso de predicado auxiliares
% logrando mejorar la declaratividad del programa, recordando que el mismo debe ser capaz de decirnos que hace ( mediante el uso de patrones y relaciones) y abstraernos de como lo hace.

% 3) Solucion propuesta
bodegon_v2(Restaurante):-
    todosSusPlatosTienenUnPrecioMenorA(Restaurante,300),
    tieneMila(Restaurante).


todosSusPlatosTienenUnPrecioMenorA(Restaurante,PrecioMaximo):-
    plato(Restaurante,_,_),
    not((plato(Restaurante, _, Precio), Precio >= PrecioMaximo)).

tieneMila_sol(Restaurante):-
    plato(Restaurante,mila,_).