%   libro(Titulo, Soporte)

%   digital(Formato, PesoEnKB).
%   papel(CantidadDePaginas, Editorial).
libro(estudioEnEscarlata, digital(mobi, 532)).
libro(elSabuesoDeLosBaskerville, papel(354, zeta)).
libro(fundacion, papel(546, planeta)).
libro(segundaFundacion, digital(epub, 880)).
libro(juegoDeTronos, digital(amz, 1046)).
%   compro(Usuario, NombreLibro)
compro(george, estudioEnEscarlata).
compro(george, fundacion).
compro(martina,elSabuesoDeLosBaskerville).
compro(martina, juegoDeTronos).

% Y la siguiente solución al cálculo de la deuda de una compra:

deudaTotal(Usuario, Deuda):-
    findall(P, (compro(Usuario, Titulo), libro(Titulo, digital(_, KB)),
    P is (KB / 1024) * 10), DeudasDigitales),
    findall(P, (compro(Usuario, Titulo), libro(Titulo, papel(Paginas, _)),
    P is Paginas * 0.05), DeudasEnPapel),
    sum_list(DeudasDigitales, TotalDeudasDigitales),
    sum_list(DeudasEnPapel, TotalDeudasEnPapel),
    Deuda is TotalDeudasDigitales + TotalDeudasEnPapel.

% 3)  Solución Mejorada

deudaPorUsuario(Usuario,Titulo,Deuda):-
    compro(Usuario,Titulo),
    libro(Titulo,Soporte),
    deudaPorLibro(Soporte,Deuda).
        
sol_deudaTotal(Usuario,Total):-
    compro(Usuario,_),
    findall(Deuda,deudaPorUsuario(Usuario,_,Deuda),TotalAcumulado),
    sum_list(TotalAcumulado,Total).

deudaPorLibro( digital( _ , PesoEnKB),Deuda):-
    Deuda is  (PesoEnKB / 1024) * 10.

deudaPorLibro( papel(CantidadDePaginas, _),Deuda):-
    Deuda is CantidadDePaginas * 0.05.

% ******************   PREGUNTAS    *******************

% 1. Escribir una consulta individual y una existencial para deudaTotal/2 justificando el resultado de ambas.

% 2. Es posible afirmar que debido a que la solución planteada es capaz de calcular los precios para cualquier tipo de
% soporte, se está aprovechando el polimorfismo. Justifique su respuesta.

% 3. En caso de ser necesario plantee una solución que mejore los puntos anteriores.



% ******************   RESPUESTAS    *******************

deudaTotal(martina, Deuda).

% El resultado será la deuda total de martina, en este caso 27,91, pues los predicados findall, de la deudaTotal, unifican todas las compras de los distintos formatos
% existentes de los libres de martina y acumulan la deuda en una lista que luego es sumada.

deudaTotal(_, Deuda).

% Para este caso, el predicado no se comportara de acuerdo a lo esperado, que es unificar los totales de todos los usuarios que tengan deuda, ya que el predicado deudaTotal
% no es inversible para la variable Usuario


% 2) Falso. La solución  responde al modelo actual de soportes de libros, pero en caso de querer incorporar mas soportes a futuro, por ejemplo , un soporte que sea un libro de alquiler,
% habria que agregar tanto los hechos para incluir este nuevo soporte, como modificar el predicado deudaTotal , ya que el mismo está fuertemente acoplado a 
% la solución actual, el mismo realiza el calculo de la Deuda mediante el conteo y suma de los predicados que están ligados en los findall de la consulta.
% Por lo tanto, en caso de incorporar mas soportes y querer seguir usando el modelo actual, habria que agregar , la sentencia que representa el calculo aritmetico, el findall 
% que realice la agrupación de matcheo, la sumatoria, y por ultimo incorporar la sumatoria a al calculo final de la Deuda.   


% 3) ver solucion propuesta:
% La solución agregada,realiza el calculo de la deuda por libros de forma polimorfica, abstrayendose del soporte de  un determinado libro, 
% esto representa una ventaja, pues permite lograr una solución escalable, es decir podemos seguir agregando formatos de libro y nuestra solución
% no se verá afectada, solamente deberemos agregar la logica necesaria para tratar al nuevo tipo de soporte.