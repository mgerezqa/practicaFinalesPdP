% Relaciona un alumno con un final al que se anotó.
anotado(ana,paradigmas,25).
anotado(ana,fisicaII,9).
anotado(beto,paradigmas,25).
anotado(camilo,paradigmas,25).
fecha(paradigmas,11).
fecha(paradigmas,18).
fecha(paradigmas,25).
fecha(fisicaII, 9).
fecha(fisicaII,16).
fecha(fisicaII,23).
ultimaFecha(Materia,Fecha):-
    findall(Dia, fecha(Materia, Dia), Fechas),
    max_list(Fechas, Fecha).
% El predicado max_list/2 relaciona a una lista con su elemento máximo.

% /********** PREGUNTAS **************/

% 1. Con la solución dada, ¿qué se obtendrá como respuesta a la consulta ultimaFecha(Materia,Fecha)? Explicar
% cómo se llega a esa conclusión.

% 2. Reescribir el predicado ultimaFecha sin usar listas y comparar ambas soluciones en términos de declaratividad.
% Asegurar que la nueva solución sea inversible.

% 3. Asumiendo que el predicado ultimaFecha fue corregido como se solicitó, responder para las siguientes consultas
% qué significado tiene y qué soluciones genera Prolog.

% a. ?- forall(anotado(_,paradigmas,Fecha), ultimaFecha(paradigmas,Fecha)).

% b. ?-     anotado(Alumno1, Materia, Fecha), 
%           anotado(Alumno2, Materia, Fecha),
%           Alumno1 \= Alumno2.


% /********** RESPUESTAS **************/

% 1. Se obtendra una respuesta no deseada o salida incorrecta, pues el predicado ultima fecha, no liga correctamente la variable Materia con el predicado findall, por lo tanto
% el motor de inferencia no sabra como resolver esta variable, pues nunca se instanció, lo que si podrá realizar es una lista de Dias y en base a eso irá guardando numeros en Fechas,
% cuando se preguunte el maximo, se obtendrá como respuesta 25, y el predicado sera no inversible. Ademas si realizamos las consultas ultimaFecha(paradigmas,Fecha) o ultimaFecha(fisicaII,Fecha).
% Podra responder correctamente

%2 Nueva solucion
ultimaFecha_v2(Materia,UltimaFecha):-
    fecha(Materia,UltimaFecha),
    not((fecha(Materia, OtrasFechas),OtrasFechas > UltimaFecha)).
% en el not me aseguro que no haya otra fecha que sea mayor que la ultimaFecha.

% Esta nueva solución es más declarativa en el sentido de que utiliza reglas lógicas puras
%  sin la necesidad de listas o funciones específicas para encontrar el máximo. 
% Además, es completamente inversible, lo que permite buscar tanto la fecha como la materia de manera flexible.

% Comparando ambas soluciones, la primera solución (con listas y max_list/2) es menos eficiente y no es inversible para la variable Materia,
%  mientras que la segunda solución (sin listas) es más eficiente y ofrece inversibilidad, 
% lo que la hace más versátil en términos de consultas en Prolog.


% 3
% 3a) El predicado responde a la consulta:  para todos aquellos anotados en el final de paradigmas en una determinada fecha,
%  dicha fecha era la ultima posible para rendir

% 3b) El conjunto de conjunto de sentencias, responde a la pregunta, existen alumnos diferentes que se hayan 
% inscripto en un final para la misma materia en la misma fecha

