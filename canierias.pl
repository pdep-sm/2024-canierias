% 1
% precio/2
precio(codo(_), 5).
precio(canio(_, Longitud), Precio):- 
    Precio is 3 * Longitud.
precio(canilla(triangular,_,_), 20).
precio(canilla(Tipo,_,Ancho), 12):- 
    Tipo \= triangular,
    Ancho =< 5.
precio(canilla(Tipo,_,Ancho), 15):- 
    Tipo \= triangular,
    Ancho > 5.

% 2
% puedoEnchufar/2 con piezas
puedoEnchufar(PiezaIzquierda, PiezaDerecha):-
    color(PiezaIzquierda, ColorIzquierdo),
    color(PiezaDerecha, ColorDerecho),
    coloresEnchufables(ColorIzquierdo, ColorDerecho).
% 3
% puedoEnchufar/2 extendido para poder usar cañerías en lugar de piezas 
% (pongo los agregados antes de las auxiliares del 2 para que no tire warning por tener las cláusulas separadas)
puedoEnchufar(Canieria, PiezaDerecha):-
    last(Canieria, PiezaIzquierda),
    puedoEnchufar(PiezaIzquierda, PiezaDerecha).
puedoEnchufar(PiezaIzquierda, [PiezaDerecha|_]):-
    puedoEnchufar(PiezaIzquierda, PiezaDerecha).

% 2 - auxiliares
color(codo(Color), Color).
color(canio(Color,_), Color).
color(canilla(_,Color,_), Color).

coloresEnchufables(Color, Color).
coloresEnchufables(azul, rojo).
coloresEnchufables(rojo, negro).

%%%%%%%%%%%%%% TESTS %%%%%%%%%%%%%%
:- begin_tests(canierias).
% 1
test(precioCanillaTriangularVerdadero, nondet):-
    precio(canilla(triangular, rojo,  5), 20).
test(precioCanillaTriangularFalso, fail):-
    precio(canilla(triangular, rojo,  5), 15).
test(precioCanio):-
    precio(canio(rojo, 5), 15).
test(precioCanillaAngosta, nondet):-
    precio(canilla(cruz, rojo,  5), 12).
test(precioCanillaAncha, nondet):-
    precio(canilla(cruz, rojo,  6), 15).
% 2
test(puedoEnchufarRojoNegro, nondet):-
    puedoEnchufar(codo(rojo), canio(negro, 3)).
test(puedoEnchufarMismoColor, nondet):-
    puedoEnchufar(codo(rojo), canio(rojo, 3)).
test(noPuedoEnchufarNegroRojo, fail):-
    puedoEnchufar(canio(negro, 3), codo(rojo)).
test(noPuedoEnchufarAzulNegro, fail):-
    puedoEnchufar(codo(azul), canio(negro, 3)).
% 3
test(puedoEnchufarCanieriasRojaNegra, nondet):-
    puedoEnchufar([codo(rojo)], [canio(negro, 3)]).
:- end_tests(canierias).

    