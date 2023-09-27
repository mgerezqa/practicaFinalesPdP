% Tenemos el siguiente código Prolog para armar un programa que ayude a organizar la cursada:

% relaciona una materia con el año en el que se cursa
materia(troncal(ads), 2).
materia(electiva(tadp, 5), 3).
materia(electiva(rrhh, 3), 3).
materia(obligatoria(pdep), 2).

%relaciona dos nombres de materias tal que la segunda es correlativa de la primera
correlativa(tadp, pdep).
correlativa(NombreElectiva, NombreTroncal):-
    materia(troncal(NombreTroncal), Anio),
    Anio is Anio + 1,
    materia(electiva(NombreElectiva, _), Anio).

/********************   PREGUNTAS   ***********************************/

% 1. La solución propuesta para el predicado correlativa/2 tiene un problema.
%  Indicar cuál es justificando  conceptualmente por qué no es correcto.

% 2. Se agrega el siguiente predicado a nuestro programa:
habilitan(NombresMateriasAprobadas, NombreMateria):-
    forall(correlativa(NombreMateria, NombreAprobada), member(NombreAprobada,NombresMateriasAprobadas)).

% Asumiendo que los problemas del predicado correlativa/2 son arreglados, indicar V/F para cada afirmación
% y justificar.
    % a. habilitan/2 no es inversible respecto a su primer parámetro. 
    % Lo correcto sería armar una lista con  todas las materias para que pueda usarse de forma existencial.

    % b. habilitan/2 es inversible respecto a su segundo parámetro, porque correlativa/2 es inversible.
    % c. habilitan/2 no es inversible respecto a su segundo parámetro, y convendría tratar polimórficamente a las materias para generar dicha variable.

/********************   RESPUESTAS   ***********************************/

% 1 

correlativa_v2(tadp, pdep).
correlativa_v2(NombreElectiva, NombreTroncal):-
    materia(troncal(NombreTroncal), AnioAnterior),
    Anio is AnioAnterior + 1,
    materia(electiva(NombreElectiva, _), Anio).

/*El problema que tiene la solucion original es que no es correcta la logica para relacionar la variable anio, ya que la relacion correcta seria entre el anio de la materia troncal + 1 para la materia electiva 
, es decir tiene que relacionar dos variables diferentes.*/
habilitan_v2(NombresMateriasAprobadas, NombreMateria):-
    materiasAprobadas(NombresMateriasAprobadas), %%generadores de materiasAprobadas, es una lista
    materia(electiva(NombreMateria, _), _), %%generadores de nombres de materias que habilitan 
    forall(correlativa(NombreMateria, NombreAprobada), member(NombreAprobada,NombresMateriasAprobadas)).

materiasAprobadas([pdep,ads]).
% 2a)  Verdadero. Habilitan no es inversible para su primer parametro. Lo correcta seria armar un predicado auxiliar como materias aprobadas, y que en su primer argumento reciba una lista de materias aprobadas.
% 2b) Falso, habiltan/2 no es inversible para ninguno de sus parametros. Para que sea inversible habria que incluir el predicado generador de las posibles materias que pueden ser cursadas luego de tener aprobadas sus correlativas.
% 2c) No estoy de acuerdo, me parece bien tener separado en dos conjuntos diferentes las materias aprobadas del conjunto universal de materias.

:- begin_tests(punto2).

    test(solucion_habilitan,nondet):-
        habilitan_v2([pdep,ads],tadp),
        habilitan_v2([pdep,ads],rrhh),
        not(habilitan_v2([pdep],rrhh)).
    
:- end_tests(punto2).