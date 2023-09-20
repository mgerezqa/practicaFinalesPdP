% Queremos ayudar a definir el resultado de una serie de rondas del juego piedra,
% papel o tijera entre varias personas que juegan al mismo tiempo.
% Sabemos que se gana una ronda cuando se elige una opcion que le gana a lo que eligieron
% los demas jugadores. Tenemos la siguiente implementación en Prolog


eligio(1,juan,piedra).
eligio(2,juan,piedra).
eligio(3,juan,tijera).

eligio(1,ana,papel).
eligio(2,ana,piedra).
eligio(3,ana,tijera).

eligio(1,tito,tijera).
eligio(2,tito,papel).
eligio(3,tito,piedra).

leGana(piedra,tijera).
leGana(tijera,papel).
leGana(papel,piedra).

% ganaRonda(Ronda,Jugador):-
%     eligio(Ronda,Jugador,Gana),
%     eligio(Ronda,_,Pierde),
%     leGana(Gana,Pierde).




% Preguntas:
% 1. La solución propuesta para el predicado ganoRonda/2 no cumple con la consigna.
% Explicar el motivo comparando lo que se buscaba con lo que hace realmente, y demostrar esa diferencia
% de funcionalidad con un ejemplo a partir de la informacion de base de conocimientos dada

% Rta
% La solucion planteada no cumple con el requerimiento solicitado, pues 
% la consulta ganaRonda(Ronda,Jugador) devuelve el conjunto de jugadores que ganan en duelos individuales por cada ronda.
% Por lo cual habrá varios ganadores por cada ronda, que no es lo solicitado por el problema.




% 2.Proponer una nueva solucion para ganoRonda que cumple con lo pedido

% Version Forall
% ganoRonda(Ronda, Jugador):-
%         eligio(Ronda, Jugador, Eleccion),
%         forall((eligio(Ronda, OtroJugador, OtraEleccion), Jugador \= OtroJugador), leGana(Eleccion, OtraEleccion)).

% Version Not
ganoRonda(Ronda, Jugador):-
    eligio(Ronda, Jugador, Eleccion),
    not((eligio(Ronda, OtroJugador, OtraEleccion), Jugador \= OtroJugador, leGana(OtraEleccion, Eleccion))).
     
% 3. En base a la nueva solucion, como se podria hacer para saber quienes ganaron alguna ronda? Y 
% en que rondas no gano nadie? Explicar que caracteristicas del paradigma ayudan a resolver estos problemas

% Quienes ganaron alguna ronda
% ganoRonda(_,Jugador).

% En que rondas no gano nadie.

noGanoNadie(Ronda):-
    eligio(Ronda, _, _), 
    not(ganoRonda(Ronda, _)).


    % Inferencia Lógica: El paradigma lógico se basa en la inferencia lógica, lo que significa que Prolog puede realizar razonamientos lógicos para deducir conclusiones a partir de reglas y hechos definidos.
    %  En este caso, se utilizaron reglas lógicas para determinar quién ganó una ronda y se buscaron patrones lógicos en las elecciones de los jugadores.

    % Patrones de Concordancia: Prolog permite la coincidencia de patrones (pattern matching), 
    % lo que facilita la comparación de datos y la aplicación de reglas lógicas. 
    % En el problema de determinar quién ganó una ronda, se utilizó la coincidencia de patrones 
    % para verificar si las elecciones de los jugadores se ajustaban a las reglas del juego.
    
    % Expresividad Declarativa: Prolog permite expresar problemas de manera declarativa, 
    % lo que significa que se describen las relaciones y reglas lógicas sin necesidad de especificar
    %  cómo se deben calcular los resultados. Esto facilita la expresión de reglas lógicas para
    %  el juego "piedra, papel o tijera" y para la búsqueda de quién ganó alguna ronda o en qué rondas no ganó nadie.
    
    % Negación: El uso de la negación en Prolog (operador \+) es una característica esencial que permitió expresar condiciones de falta de cumplimiento. 
    % Esto se utilizó para buscar rondas en las que no hubo un ganador, lo que es un aspecto fundamental del problema.