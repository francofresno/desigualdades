persona(liliana, mujer(24, universitario, 2), argentina).
persona(kate, mujer(23, universitario, 0), eeuu).
persona(juan, varon(38, secundario), argentina).
persona(franco, varon(24, secundario), argentina).
persona(charles, varon(42, universitario), eeuu).
persona(laura, trans, argentina).
persona(pedro, trans, argentina).
persona(santiago, trans, argentina).
persona(trosko, trans, rusia).

esCisgenero(Persona) :-
    persona(Persona, _, _),
    not(esTrans(Persona)).

esTrans(Persona) :-
    persona(Persona, trans, _).

esVaron(Persona, NivelEducativo, Edad, Pais) :-
    persona(Persona, varon(NivelEducativo, Edad), Pais).
esMujer(Persona, NivelEducativo, Edad, Hijes, Pais) :-
    persona(Persona, varon(NivelEducativo, Edad, Hijes), Pais).

esperanzaDeVida(Persona, Anios) :-
    esCisgenero(Persona),
    esVaron(Persona, _, _, _),
    Anios = 72.
esperanzaDeVida(Persona, Anios) :-
    esCisgenero(Persona),
    esMujer(Persona, _, _, _, _),
    Anios = 80.    
esperanzaDeVida(Persona, Anios) :-
    esTrans(Persona),
    Anios = 35.

consigueTrabajo(Persona) :-
    esVaron(Persona, NivelEducativo, Edad, _),
    esSuperior(NivelEducativo, primario),
    Edad < 45.
consigueTrabajo(Persona) :-
    esMujer(Persona, NivelEducativo, Edad, 0, _),
    esSuperior(NivelEducativo, secundario),
    Edad < 35.

esSuperior(universitario, secundario).
esSuperior(universitario, primario).
esSuperior(secundario, primario).

salarioEsperado(Persona, 0) :-
    not(consigueTrabajo(Persona)).

viveEnUnPaisDesarrollado(Persona) :-
    persona(Persona, _, Pais),
    esperanzaDeVida(Persona, Edad),
    Edad > 70,
    forall( persona(OtraPersona, _, Pais), esperanzaDeVida(OtraPersona, OtraEdad), OtraEdad>70).

canastaBasica(argentina, 500).
canastaBasica(eeuu, 1000).

tienePerspectivaDeGenero(Pais) :-
    canastaBasica(Pais, Monto),
    forall( esMujer(Mujer, _, _, _, Pais), salarioEsperado(Mujer, Salario), Salario>Monto).
