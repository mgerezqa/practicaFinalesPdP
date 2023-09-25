gusta(charly, milanesa).
gusta(charly, bondiola).
gusta(clari, milanesa).
gusta(clari, pizza).
gusta(erwin, pizza).
gusta(franco, sushi).
comida(milanesa).
comida(higado).
comida(bondiola).
comida(pizza).
comida(brocoli).
comida(sushi).
comida(bacalao).
% Si tenemos una lista de comidas y queremos relacionar el universo de platos que le gusta a alguno, dos desarrolladores
% plantearon dos soluciones similares:

% Solución A)

comidasRicasA(ComidasRicas):-
    findall(Comida, (comida(Comida), gusta(_, Comida)), ComidasRicas).

% Solución B)
comidasRicasB(ComidasRicas):-
    findall(Comida, comida(Comida), Comidas), sonRicas(Comidas, ComidasRicas).

sonRicas([], []).

sonRicas([Comida|Comidas], [Comida|ComidasRicas]):-
    gusta(_, Comida),
    sonRicas(Comidas, ComidasRicas).

sonRicas([_|Comidas], ComidasRicas):-
    sonRicas(Comidas, ComidasRicas).


% **************    PREGUNTAS   **************************
% 1) ¿Son inversibles ambos predicados principales? Justificar.
% 2) ¿Qué diferencia presentan en las consultas existenciales?
% 3) Relacionar dicha diferencia de funcionalidad con un concepto específico del paradigma que la genera.
% 4) Generar un ejemplo dentro del ejercicio que permita contar el principio de universo cerrado. 
%    Sea específico, tiene que usar el código existente (del enunciado base y/o soluciones A y B).



% **************    RESPUESTAS   **************************
% 1) Los predicados propuestos (comidasRicas A y B) están mal desarrollados, pues el objetivo de las soluciones es relacionar a las personas con sus platos favoritos y ninguno de ellos lo hace ,
% pues a ambos le falta un parametro Persona para vincular a la persona con los platos que le gustan.

% 2) La diferencia principal en las consultas existenciales radica en cómo se generan las listas de comidas ricas. En comidasRicasA/1, se obtienen todas las comidas ricas directamente a través de la construcción de una lista con findall/3,
%  filtrando las comidas que son del gusto de al menos una persona. En comidasRicasB/1, primero se obtienen todas las comidas y luego se filtran las ricas mediante el proceso recursivo de sonRicas/2.

% 3) La diferencia de funcionalidad está relacionada con el concepto de "universo cerrado". En Prolog, un "universo cerrado" significa que solo aquello que se ha establecido 
% como verdadero o se puede inferir a partir de hechos conocidos es considerado verdadero. En el caso de comidasRicasA/1, se construye una lista de comidas ricas explícitamente 
% a partir de hechos establecidos (gustos de las personas) y, por lo tanto, respeta el principio de universo cerrado. En comidasRicasB/1, se obtienen todas las comidas y se filtran posteriormente,
%  lo que puede incluir comidas ricas que no se han mencionado en los hechos. Esto podría no respetar el principio de universo cerrado si existieran comidas ricas que no fueran del gusto de ninguna persona.

% Para ilustrar el principio del "universo cerrado", supongamos que hay una comida llamada "caviar" que 
% no ha sido mencionada en los hechos pero que es considerada rica por algunas personas. Usando la solución A, comidasRicasA/1, si hacemos la consulta:

% comida(caviar).
% comidasRicasA(ComidasRicas).
% La lista ComidasRicas seguirá conteniendo solo las comidas que han sido mencionadas en los hechos (por ejemplo, "milanesa" y "bondiola"), y "caviar" no estará presente en la lista.
% Esto demuestra que la solución A respeta el principio del universo cerrado.

% En cambio, si usamos la solución B, comidasRicasB/1, y realizamos la misma consulta, "caviar" se incluirá en la lista ComidasRicas, ya que se obtienen todas las comidas y luego se filtran las ricas.
%  Esto no respeta el principio del universo cerrado, ya que "caviar" no fue mencionado en los hechos.