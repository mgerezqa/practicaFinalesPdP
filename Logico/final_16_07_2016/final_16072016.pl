% Parte B

% ******************* PREGUNTAS   ******************************

% Para una solución en lógico, querríamos armar una base de conocimientos en donde se registre la
% información de cada empleado mediante un predicado llamado obrero.
% 1. ¿Cómo podrían modelarse los empleados para una solución en Prolog? Escribir tres cláusulas de
% ejemplo para el predicado obrero, una por cada tipo de obrero.

% 2. Implementar el cálculo de sueldo para un obrero de construcción.

% 3. ¿El predicado definido en el punto anterior es inversible? Justificar por qué sí o por qué no y cómo
% impactaría esto a su uso en un predicado totalAPagarPorMes/1 que obtenga la sumatoria de lo que
% debe pagarse a todos los obreros registrados en la base de conocimientos.

% ******************* RESPUESTAS   ******************************

% 1.
% obrero(nombre,construccion,salario(montoXquincena))

obrero(juan,construccion,salario(500)).

% obrero(nombre,planta,salario(categoria(tipo,basico),horas_extras)).

obrero(pepe,planta,salario(categoria(aprendiz,500),0)).
obrero(pepu,planta,salario(categoria(experto,1500),10)).
obrero(golo,planta,salario(categoria(estandar,1000),10)).

% obrero(nombre,contratista,trabajoRealizado([detalle],[montoXTrabajo])).
obrero(charly,contratista,salario([revoqueFino,cableado,sanitario],[1000,2000,300])).



% 2
calcularSalario(construccion,salario(MontoXQuincena), Total):-
    Total is MontoXQuincena * 2.

/*El predicado no es inversible, pues tampoco necesito que lo sea , es un predicado auxiliar que será usado en el calculo para obtener los salarios x cada empleado, si fuese
inversible estaria agregando codigo de manera inncesaria pues para cumplir con los requerimientos necesito de los predicados que serán "principales" como salarioPorEmpleado y totalAPagar*/

calcularSalario(planta,salario(categoria(aprendiz,Basico),_), Total):-
    Total is Basico * 40.

calcularSalario(planta,salario(categoria(estandar,Basico),Horas_extras), Total):-
    Total is Basico * 40 + Horas_extras * 1.5.

calcularSalario(planta,salario(categoria(experto,Basico),Horas_extras), Total):-
        Total is Basico * 40 + Horas_extras * 1.5.
    
calcularSalario(contratista,salario(_,TrabajosRealizados), Total):-
    sumlist(TrabajosRealizados, Total).

salarioPorEmpleado(Obrero,Total):-
    obrero(Obrero,Tipo,CalculoSalarial),
    calcularSalario(Tipo,CalculoSalarial,Total).

:- begin_tests(punto3_A).

test(salario_por_empleado,nondet):-

    salarioPorEmpleado(juan,1000),
    salarioPorEmpleado(pepe,20000), %porque trabaja 40 semanales y cobra 500 de basico
    salarioPorEmpleado(pepu,60015.0), % porque trabaja 40 semanales y cobra 1500 de basico y hace 10 hs extra = 40*1500+10*1.5
    salarioPorEmpleado(golo,40015.0), % porque trabaja 40 semanales y cobra 1000 de basico y hace 10 hs extra = 40*1000+10*1.5
    salarioPorEmpleado(charly,3300). %porque la suma de sus trabajaos es 3300

:- end_tests(punto3_A).
    

:- begin_tests(punto3_B).

test(total_a_pagar,nondet):-
    totalAPagarPorMes(124330.0).

:- end_tests(punto3_B).
    

% % 3
totalAPagarPorMes(Total):-
    findall(Salario,salarioPorEmpleado(_,Salario),SalariosAcumulados),
    sumlist(SalariosAcumulados,Total).

