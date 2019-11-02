

% meta-interprete

prove(true) :- !.
prove((B, Bs)) :- !,
    prove(B),
    prove(Bs).
prove(H) :-
    clause(H, B),
    prove(B).
prove(H) :-
    askable(H),
    question(H, Q),
    writeln(Q),
    read(Answer),
    Answer == si.

question(fatigue, '¿Sientes fatiga constantemente?').
question(muscle_tension, '¿Sientes tensión muscular?').
question(hyperhidrosis, '¿Sudas más de la cuenta?').
question(confusion, '¿Pierdes la noción de la razón muy a menudo?').
question(insomnia, '¿Te cuesta mucho conciliar el sueño?').
question(abdominal_pain, '¿Sientes un dolor en el abdomen?').
question(stress, '¿Te sientes estresado?').
question(fear_stolen, '¿Cuando sales a la calle, tienes un constante miedo de ser asaltado?').
question(fear_harm, '¿Tienes un miedo constante de lastimar a otras personas?').
question(fear_mistakes, '¿Tienes pánico a equivocarte?').
question(excessive_organization, '¿Te pones nervioso si un grupo de objetos no está debidamente ordenado?').
question(showers, '¿Te bañas más de una vez al día?').
question(hand_washing, '¿Te lavas las manos muy frecuentemente?').
question(eating_fixed_food, '¿No sueles cambiar tu rutina alimenticia?').
question(separation_reality, '¿Tienes la sensación de que vives una realidad distinta a los demás?').
question(loss_memory, '¿Te ha pasado que has perdido la memoria temporalmente?').
question(absence_consciousness, '¿Sueles quedarte con la mente en blanca?').
question(feeling_hatred, '¿Sientes odio por alguna persona en particular').
question(sleep_disruption, '¿Duermes o te alimentas a deshoras?').
question(inactivity_body, '¿Tienes una vida sedentaria?').
question(inner_horror, '¿Sueles sentir pánico o miedo interno?').
question(frustration_sense, '¿Te persigue una constante sensación de frustración o pérdida de esperanza?').
question(loss_enjoyment_life, '¿Sientes que has perdido las ganas de vivir?').

sympton(fatigue).
sympton(muscle_tension).
sympton(hyperhidrosis).
sympton(confusion).
sympton(insomnia).
sympton(abdominal_pain).
sympton(stress).
sympton(fear_stolen).
sympton(fear_harm).
sympton(fear_mistakes).
sympton(excessive_organization).
sympton(showers).
sympton(hand_washing).
sympton(eating_fixed_food).
sympton(separation_reality).
sympton(loss_memory).
sympton(absence_consciousness).
sympton(feeling_hatred).
sympton(sleep_disruption).
sympton(inactivity_body).
sympton(inner_horror).
sympton(frustration_sense).
sympton(loss_enjoyment_life).

disease(anxiety).
disease(ocd).
disease(hysteria).
disease(depression).

diseaseName(anxiety, 'Ansiedad paroxística').
diseaseName(ocd, 'Desorden obsesivo compulsivo').
diseaseName(hysteria, 'Histeria').
diseaseName(depression, 'Depresión').

diagnosis([fatigue, muscle_tension, hyperhidrosis, confusion, insomnia, abdominal_pain, stress], anxiety).
diagnosis([fear_stolen, fear_harm, fear_mistakes, excessive_organization, showers, hand_washing, eating_fixed_food], ocd).
diagnosis([separation_reality, loss_memory, absence_consciousness, feeling_hatred], hysteria).
diagnosis([sleep_disruption, inactivity_body, inner_horror, frustration_sense, loss_enjoyment_life], depression).

:- dynamic yes/1, no/1.

/* deshace todas las reglas autogeneradas  */
resetAnswers :- retract(yes(_)), fail.
resetAnswers :- retract(no(_)), fail.
resetAnswers.

check([]) :- !.
check([S|S1]) :-
    (yes(S) -> true; (no(S) -> fail; ask(S))),
    check(S1).

%ask([]) :- !.
ask(S) :-
    writeln(S),
    sympton(S),
    question(S, Question),
    writeln(Question),
    write('Respuesta '),
    read(Respuesta),
    (Respuesta == si ->
    assert(yes(S)); assert(no(S)), fail).
    %ask(S1).

init :-
    resetAnswers,
    diagnosis(Symptons, Disease),
    %writeln(Symptons),
    check(Symptons),
    write("Enfermedad psicológica: "),
    diseaseName(Disease, Name),
    writeln(Name).



