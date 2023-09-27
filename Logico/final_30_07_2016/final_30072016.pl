% Los siguientes fragmentos de código andan para consultas individuales, su lógica es correcta y no poseen errores de
% sintaxis pero todas las soluciones tienen cosas a mejorar.
% Para cada punto:.
% a. Analizar si los predicados son totalmente inversibles y hacerlos inversibles si no lo fueran.
% b. Realizar las mejoras que identifiques, más allá de la inversibilidad, explicando por qué es mejor.

/*AGREGADO PARA EVALUAR*/
personaje(yamcha).
personaje(piccolo).
personaje(krillin).
% personaje(goku).
sigueA(krillin,goku).
sigueA(piccolo,goku).
sigueA(yamcha,goku).

% Enunciado 1a)
todosSiguenA(Rey) :-
    sigueA(_,Rey),
    not((personaje(Personaje), not(sigueA(Personaje, Rey)))).
    %Se quiere averiguar qué personajes son seguidos por todos los personajes.
    %Todos los personajes que existen están definidos con hechos del predicado personaje/1
    %El predicado sigueA/2 relaciona dos personajes, donde el primero sigue al segundo.

% RTA : Se puede mejorar la expresividad y legibilidad del codigo , usando el predicado forall en lugar de not, ademas de que al predicado le falta corregir su problemas de inversibilidad 
todosSiguenA_v2(Rey) :-
    sigueA(_,Rey),
    forall(personaje(Personaje),sigueA(Personaje, Rey)).

:- begin_tests(punto1_a).

    test(seguidoresDeGoku,nondet):-
        todosSiguenA(goku),
        todosSiguenA_v2(goku).

:- end_tests(punto1_a).

/*********************************************************************************************************/
% Enunciado 1b)
%El predicado ingrediente relaciona a un ingrediente con la comida de la que forma parte, por ejemplo
% ingrediente(mayonesa,ensaladaRusa).
comidaVegana(Comida) :-
    ingrediente( _, Comida),
    forall(ingrediente(Ingrediente, Comida),
    (not(contieneCarne(Ingrediente)),
    not(contieneHuevo(Ingrediente)),
    not(contieneLeche(Ingrediente)))).

% RTA 1b)
/*PARA EVITAR WARNING SOL ORIGINAL*/
contieneCarne(Ingrediente):- ingrediente(carne,_), Ingrediente = carne.
contieneHuevo(Ingrediente):- ingrediente(huevo,_), Ingrediente = huevo.
contieneLeche(Ingrediente):- ingrediente(leche,_), Ingrediente = leche.

/*AGREGADO PARA EVALUAR*/
ingrediente(carne,asado).
ingrediente(ensalada,asado).
ingrediente(arroz,arroz_con_lentejas).
ingrediente(lentejas,arroz_con_lentejas).

comidaVegana_v2(Comida) :-
    ingrediente( _, Comida),
    forall(ingrediente(Ingrediente, Comida), esVegano(Ingrediente)).

esVegano(Ingrediente):-
    ingrediente(Ingrediente,_),
    Ingrediente \= carne,
    Ingrediente \= huevo,
    Ingrediente \= leche.


:- begin_tests(punto1_b).

    test(comidaVegana,nondet):-
    comidaVegana_v2(arroz_con_lentejas).

:- end_tests(punto1_b).

% En definitiva, se podria mejorar la solución, realizando una modifcación en el consecuente del forall, y modularizar todo la logica en otro predicado a fin 
% que puede ser llamado  esVegano(Ingrediente), para unificar aquellos ingredientes que son veganos.

/*********************************************************************************************************/
% Enunciado 1C)

hayAlgunTestigo(Delito) :-
    findall(Testigo, testigo(Testigo, Delito), Testigos),
    length(Testigos, Cantidad),
    Cantidad > 0.
        %El predicado testigo/2 relaciona a una persona con un delito si la misma fue testigo.


% RTA
testigo(mar,robo).
testigo(juli,homicidio).
testigo(juli,robo).

hayAlgunTestigo_v2(Delito):-
    testigo(_,Delito).


% Al predicado hayAlgunTestigo, le falta corregir los problemas de inversibilidad, utilizando el predicado generador para los delitos,
% como en definitiva la consulta que resuelve es de tipo existencial , no es necesario el uso de findall, sino que puede resolverse mas facilmente, haciendo uso de la variable anonima
% y logrando una  consulta existencial para su primer parametro, como esta realizado en hayAlgunTestigo_v2(Delito).


:- begin_tests(punto1_c).

    test(hayAlgunTestigo_v2,nondet):-
        hayAlgunTestigo_v2(robo),
        hayAlgunTestigo_v2(homicidio).

:- end_tests(punto1_c).