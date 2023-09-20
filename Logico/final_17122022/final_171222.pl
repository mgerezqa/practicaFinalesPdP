
% vino(tipo,anios)
% cerveza(variedad,amargor,graduacion)
toma(juan,coca).
toma(juan,vino(malbec,3)).
toma(daiana,cerveza(golden,18,0)).
toma(gisela,cerveza(ipa,52,7)).
toma(edu,cerveza(stout,28,6)).

tieneProblemas(Persona):-
    findall(C,(toma(Persona,cerveza(C,_,A)),A>0),Cs),
    findall(V,toma(Persona,vino(V,_)),Vs),
    findall(T,toma(Persona,T),Ts),
    length(Cs,CCs),
    length(Vs,CVs),
    length(Ts,CTs),
    CTs is CCs + CVs.

% 1.Justificar V o F:
% a. No se repite lógica dado que la estructura de las bebidas alcholicas son distintas.
% b. La solución planteada para tieneProblemas/1 es declarativa.
% c. La solución planteada podria mejorarse con polimorfismo.

% 2 Explique y justifique cual es el significado de lo que se estaria consultando con el siguiente codigo:
% tieneProblemas(P)

% 3 Implemente una solución superadora de tieneProblemas

% Respuestas 
% 1a).Verdadero.Las bebidas son modeladas mediante functores, individuos compuestos,
% los cuales estan modelado informacion diferente para cada tipo de bebida presente en el sistema:

% functor: Bebida
% vino(tipo,anios)
% cerveza(variedad,amargor,graduacion)
% geseosa

% 1b).La solucion planteada no es declarativa, , un programa se considera declarativo cuando 
% se describe lo que debe hacerse en lugar de cómo hacerlo, el uso de calculos aritmeticos e implementar una logica de control
% mediante la implementación de findall y length no hace declarativa la solución.

% Una solución declarativa en Prolog sería una que se centre en describir las relaciones y propiedades entre los datos,
%  sin la necesidad de contar o realizar cálculos manuales

% 1c) Verdadero ver punto3)

% 2) El predicado tieneProblemas(Persona) 
%  El predicado tieneProblemas no es inversible, por lo tanto no respondera consultas con variables libres, 
% la consulta devolverá como resultado false. 

% tieneProblemas pareciera tener como fin responder si una persona tiene problemas  lo cual es cierto si consume alguna bebida alcholica, para ello
% se propone el uso de findall, predicado de orden superior que recibe como parametro la consulta 
% toma que relaciona la bebida  que bebe una persona y la acumula en una lista, realiza la misma accion para acumular 
% las bebidas de cerveza, vino y gaseosa, en el siguiente paso, se extrae la longitud de cada lista de modo
% tal de obtener la cantidad de las bebidas consumidas y por ultimo se suman esos totales.  
%  El predicado no es inversible, por lo tanto no respondera consultas con variables libres. 

% 3)
% Pero para lograrlo podemos realizar mediante la siguiente manera:

tieneProblemas_v3(Persona):-
    toma(Persona,Bebida),
    tieneAlcohol(Bebida).

tieneAlcohol(vino(_,_)).
tieneAlcohol(cerveza(_,_,GraduacionAlcholica)):-
    GraduacionAlcholica > 0.    

% tieneProblemas_v2(Persona):-
%     toma(Persona,vino(_,_)).

% tieneProblemas_v2(Persona):-
%     toma(Persona,cerveza(_,_,GraduacionAlcholica)),
%     GraduacionAlcholica > 0.