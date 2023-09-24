
% relaciona granjero con animales que pueden ser:
% chancho(kilos) o caballo(energia,ración)
granjero(beto, chancho(24)).
granjero(beto, caballo(150,20)).
granjero(beto, chancho(120)).
granjero(julieta, caballo(120,10)).


% alimentar(Granjero, Animal):-
%     granjero(Granjero, caballo(Energia, Ración)),
%     Energia = Energia * (1 + Racion/100).

% alimentar(Granjero, Animal):-
%     granjero(Granjero, chancho(Kilos)),
%     Kilos =< 50,
%     Kilos = Kilos + 3.

% alimentar(Granjero, Animal):-
%     granjero(Granjero,chancho(Kilos)),
    % Kilos = Kilos + 2.





% Responder:
% 1.La solución tiene algunos problemas conceptuales. Indicar los que considere mas importantes
% (al menos 3) y justificar porque son los errores.

% 2.Implemente una solución alternativa que arregle los problemas detectados, teniendo en cueta que
% debe respetar la consigna original.

% 3.Es inversible la nueva solución? Ejemplicar mostrando como responde a consultas diversas.



% Respuestas


% 1. Errores:

% 1.El predicado alimentar no tiene la cantidad correcta de parametros, pues deberia tener un
% tercer paramentro que almacene lo que sucede despues de alimentar al animal.
% 2.No se realizan adecuadamente los calculos aritmeticos, pues para realizarlo deberia usarse 
% el predicado is.
% 3. No está bien aplicado el polimorfismo , pues el predicado alimentar recibe el parametro Animal, 
% y no lo utiliza en el predicado, lo que deberia haberse hecho es "descomponer" el functor y trabajar
% con sus propiedades dentro de la clausula.
% 4. El calculo de la energia ganada no está bien realizado,  pues en el paradigma logico no existe 
% el efecto de lado como tal, ya que el motor de prolog intentará resolver la consulta, mediante la inferencia , la relacion
% y los patrones de concordancia que estén descriptos en nuestros predicados.  Por lo tanto para poder apreciar
% la energia que ganó un animal tendría que haberse realizado en otra variable libre.

    

% 2. Solucion propuesta

alimentar(Granjero,Animal,AnimalAlimentado):-
    granjero(Granjero,Animal),
    darAlimento(Animal,AnimalAlimentado).

darAlimento(chancho(Kilos),chancho(KilosGanados)):-
    Kilos =< 50,
    KilosGanados is Kilos + 3.

darAlimento(chancho(Kilos),chancho(KilosGanados)):-
    Kilos > 50,
    KilosGanados is Kilos + 2.

darAlimento(caballo(Energia,Racion),caballo(EnergiaGanada)):-
    EnergiaGanada is Energia * (1 + Racion/100 ).

% la nueva solucion es inversible ademas que admite la incorporación de nuevos animales.
% Ejemplo :

% vaca(litrosDeLecheMensuales,Peso,Terneros).
% granjero(beto, vaca(10,200,3)).
