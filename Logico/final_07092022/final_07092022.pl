
% Tenemos un predicado toma/2 que relaciona a una persona con aquella bebida que le gusta tomar.
% La bebida puede ser cerveza, que tiene una variedad, un amargor y un porcentaje de alcohol(0 si es cerveza sin alcohol)
% o vino, que tiene un tipo y una cantidad de anios de añejamiento. El vino siempre tiene alcohol. Y también 
% gaseosas varias.


% cerveza (variedad,amargor,graduacion)
toma(daiana, cerveza(golden,18,0)).
toma(gisela, cerveza(ipa,52,7)).
toma(edu,cerveza(stout,28,6)).
% vino(tipo,anios)
toma(juan,vino(malbec,3)).
toma(gisela,vino(malbec,3)).
% gaseosas
toma(juan,coca).

tieneProblemas(Persona):-
    findall(C,(toma(Persona,cerveza(C,_,A)),A>0),Cs),
    findall(V,toma(Persona,vino(V,_)),Vs),
    findall(T,toma(Persona,T),Ts),
    length(Cs,CCs),
    length(Vs,CVs),
    length(Ts,CTs),
    CTs is CCs + CVs.
    
% 1 Explicar cual es el objetivo del predicado tieneProblemas (solo para que sirve) y cual es 
% la respuesta a la consulta:
% tieneProblemas(juan)

% Rta 1a)
    % El objetivo del predicado tieneProblemas es determinar si una persona tiene problemas en función de su consumo de bebidas. Más específicamente, 
    % el predicado se utiliza para identificar si una persona tiene problemas si toma cerveza con alcohol (graduación alcohólica mayor que 0) o vino.

% Rta 1b)
% La consulta tieneProblemas(juan) devuelve "false" es porque el predicado findall/3 no es inversible en Prolog, 
% lo que significa que no puede recuperar de manera efectiva las cervezas y vinos que Juan consume.
%  Por lo tanto, el predicado tieneProblemas/1 no puede encontrar ninguna bebida alcohólica en el caso de Juan y, como resultado, devuelve "false".

% 2. Responder Verdadero o Falso y justificar:
    % a. El predicado tieneProblemas/1 no es inversible. 
    % b.  La solución planteada para tieneProblemas/1 es declarativa
    % c.  La solución podria mejorarse usando polimorfismo

% Rtas 
% 2.a) VERDADERO. El predicado no es inversible, pues la variable Persona, llega sin ligar al findall.
% 2.b) La solucion no es declarativa, pues el código supone una dificultad considerable para su comprensión, 
% podrian haberse utilizado variables con una mejor descripción.

% La solución planteada para tieneProblemas/1 no es completamente declarativa debido al uso de findall/3, que es un predicado no inversible en Prolog. La declaratividad en Prolog se refiere a la capacidad de expresar un problema de manera puramente lógica, sin depender de características específicas de implementación.

% En este caso, findall/3 se utiliza para recopilar todas las cervezas y vinos que una persona consume, y esta operación no es completamente declarativa porque depende de la implementación de findall/3 para crear una lista de resultados

% 2.c) No es necesario el polimorfismo para esta solución.
% . No hay necesidad de polimorfismo en este contexto, ya que cada tipo de bebida 
% se representa de manera explícita en la base de conocimiento y se consulta de acuerdo con su estructura específica.

% 3. Implementar una solución de tieneProblemas con las mejoras que consideres apropiadas
tieneProblemas_V2(Persona) :-
    toma(Persona, cerveza(_, Amargor, Graduacion)),
    Graduacion > 0.

tieneProblemas_V2(Persona) :-
    toma(Persona, vino(_, Anios)).

