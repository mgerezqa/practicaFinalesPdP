% acuerdo(pais_que_vende, pais_que_compra, cosa).
acuerdo(argentina, china, trigo).
acuerdo(argentina, rusia, trigo).
acuerdo(argentina, francia, carne).
acuerdo(argentina, brasil, carne).
acuerdo(eeuu, argentina, carne).
acuerdo(china, rusia, arroz).
acuerdo(francia, arabia, carne).
acuerdo(brasil, zimbabwe, carne).

paises(cuba).
paises(Pais):-
    acuerdo(Pais,_,_).
paises(Pais):-
    acuerdo(_,Pais,_).

pais(Pais):- distinct(paises(Pais)).


% 1. Queremos reflejar que no hubo acuerdo entre EEUU y China por el comercio de armas. ¿Cómo reflejaría esto en
% la base de conocimiento? Justifique relacionándolo con algún concepto.


% 2. Resuelva el predicado recibe(Pais1, Pais2), que indica si el segundo país puede recibir algo del primero. 
% Por  ejemplo, Argentina recibe carne de EEUU por el acuerdo que firmaron.
% Pero también podría pasar que Brasil reciba de EEUU indirectamente. Contemplar los casos posibles.


% 3. Indicar qué concepto entra en juego en su solución para determinar que hay una relación entre EEUU y
% Zimbabwe por la carne.


% 4. Se necesita verificar, a partir de los predicados que ya tenemos, si algún país no tiene ningún acuerdo con
% ningún otro. Si es posible, realizar la consulta y justificar conceptualmente. Si no es posible, indicar por qué.

% Respuestas 

% 1. Por el principio de universo cerrado, inferimos que todo aquello que no es declarado como un hecho en la base de conocimiento
% es falso, por lo tanto , al realizar la consulta acuerdo(eeuu,china,armas) obtendremos false, por lo tanto no será necesario incorporar
% nuevos registros a la base de conocimiento.


% 2.

recibe(Pais1, Pais2) :- 
    acuerdo(Pais1, Pais2, _).

recibe(Pais1, Pais2) :- 
    acuerdo(Pais1, Intermediario, _), 
    recibe(Intermediario, Pais2).

    % Este predicado verifica si hay un acuerdo directo entre dos países o si hay una cadena de acuerdos que conecta indirectamente a los dos países a través de intermediarios.

    :-begin_tests(punto1).
test(punto1_recibe,nondet):-
    
    recibe(eeuu,brasil), %porque eeuu le vende a argentina, argentina le vende a brasil entonces, eeuu le vende a brasil:  a -> b , b -> c ::  a -> c
    recibe(argentina,zimbabwe), % porque  argentina le vende a brasil , brasil le vende a zimbabew entonces, arg le vende a zimbabwe:  a -> b , b -> c ::  a -> c
    recibe(argentina,arabia). % porque  argentina le vende a francia , francia le vende a arabia entonces, arg le vende a arabia:  a -> b , b -> c ::  a -> c
    

end_tests(punto1).

% 3
% El concepto en juego aquí es el de "transitividad". En la implementación del predicado recibe/2, estamos utilizando la transitividad de los acuerdos 
% para determinar si un país puede recibir algo de otro país a través de acuerdos indirectos. % En este caso, si EEUU vende carne a Brasil, y Brasil vende carne a Zimbabwe,
%  entonces se establece una relación indirecta entre EEUU y Zimbabwe en términos de carne.


%4


%No es posible realizar la consulta, ya que los paises que forman parte de la base de conocimiento, 
% estan relacionados mediante un predicado que asegura que tienen un acuerdo por lo tanto, para realizar
% la solicitud, tendriamos que incorporar a la solución un predicado llamado pais(Pais) que registre los paises 
% de la solución y luego podria  realizarse la consulta mediante un predicado llamado estaAislado(Pais)  
estaAislado(Pais):-
    pais(Pais),
    not(acuerdo(Pais,_,_)),
    not(acuerdo(_,Pais,_)).