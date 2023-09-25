juega(marcos, futbol).
juega(ximena, futbol).
juega(carola, futbol).
juega(carola, tenis).

juega(pipo,padle).
campeon(pipo,rugby).
campeon(marcos, futbol).
campeon(carola, futbol).
campeon(carola, tenis).

% Nos piden saber si una persona es un crack. Eso ocurre cuando sale campeón de todos los deportes que
% juega. Se proponen estas soluciones:

% a.
crack_a(Persona):- 
    forall(juega(Persona, Deporte), campeon(Persona, Deporte)).
% b. 
crack_b(Persona):-
    findall(Campeon, campeon(Persona, Campeon), Campeonatos),
    findall(Juega, juega(Persona, Juega), Jugados),
    length(Campeonatos, VecesCampeon), 
    length(Jugados, VecesCampeon).
% c. 
crack_c(Persona):- 
    not((juega(Persona, Deporte), not(campeon(Persona, Deporte)))).

% ****************    PREGUNTAS   *********************

% Analice las soluciones en términos de
% 1. Inversibilidad: Incluir al justificar un ejemplo de consulta existencial y su respuesta, y dos de consultas
% individuales: una cuya respuesta sea verdadera y una cuya respuesta sea falsa.

% 2. Funcionalidad: ¿Existe algún escenario (no necesariamente con la misma base de conocimientos)
% ante el cual podría llegarse a respuestas distintas con alguna de las soluciones? Justificar.

% 3. Al margen de los aspectos anteriores ¿cuál es la mejor solución? Justificar conceptualmente.

% ****************    RESPUESTAS   *********************

% 1)  
% Sol a: No es inversible, si hacemos la consulta crack(Persona), no sabremos quienes campeonaron, pues la variable Persona llega sin ligar el predicado forall.

% Sol b: ENo es inversible, si hacemos la consulta crack(Persona), no sabremos quienes campeonaron, pues la variable Persona llega sin ligar el predicado findall.

% Sol c: No es inversible, si hacemos la consulta crack(Persona), no sabremos quienes campeonaron, pues la variable Persona llega sin ligar el predicado not.

% 2) Si para el escenario b, por ejemplo si incorporasemos un hecho como juega(pipo,padle) y campeon(pipo,rugby), al realizar la consulta (con las correcciones de inversibilidad )

% sol_crack_b(pipo) obtendriamos verdadero, pues la logica de implementacion no es correcta, ya que en el predicado se asume que los deportes que juega son los mismos que campeona.


% 3) Corrigiendo los problemas de inversibilidad que presenta, la mejor solución es la a) ya que desarrolla una solución mas expresiva y legible que el resto,
% con el uso del predicado forall , estamos diciendo "Una persona es crack si para todos los deportes que juega esa persona salió campeon de ese deporte",
% por el contrario la solución b) parece la menos declarativa ya que implementa logica de control, para filtrar y luego contabilizar la cantidad de hechos, 
% un programa se considera declarativo cuando se describe lo que debe hacerse en lugar de como hacerlo. 
%  La opción c) si corrigieramos los problemas de inversibilidad, sería una version alternativa a la solucion a) pero mucho menos expresiva, ya que para 
% realizar la consulta se elabora un predicado generando un conjunto a partir  de los hechos que no deben ser ciertos, lo cual aumenta su compresión.

% *********** CORRECCIONES ************************

% a.
sol_crack_a(Persona):-
    juega(Persona,_), 
    forall(juega(Persona, Deporte), campeon(Persona, Deporte)).
% b. 
sol_crack_b(Persona):-
    juega(Persona,_),
    findall(Campeon, campeon(Persona, Campeon), Campeonatos),
    findall(Juega, juega(Persona, Juega), Jugados),
    length(Campeonatos, VecesCampeon), 
    length(Jugados, VecesCampeon).
% c. 
sol_crack_c(Persona):- 
    juega(Persona,_),
    not((juega(Persona, Deporte), not(campeon(Persona, Deporte)))).