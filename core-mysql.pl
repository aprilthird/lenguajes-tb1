:- dynamic sympton/1, disease/1, diseaseName/2, question/2, diagnosis/2.

reset_system :- retract(sympton(_)), fail.
reset_system :- retract(disease(_)), fail.
reset_system :- retract(question(_, _)), fail.
reset_system :- retract(diseaseName(_, _)), fail.
reset_system :- retract(diagnosis(_, _)), fail.
reset_system.

open_connection :-
    odbc_connect('swiprolog', _,
                 [user(root),
                  password(root),
                  alias(swiprolog),
                  open(once)
                 ]).

close_connection :-
    odbc_disconnect('swiprolog').


get_symptons(Symptons) :-
        findall(Sympton,
                odbc_query('swiprolog',
                           'select (name) from sympton',
                           row(Sympton)),
                Symptons).

get_questions(Questions) :-
        findall(Question,
                odbc_query('swiprolog',
                           'select (question) from sympton',
                           row(Question)),
                Questions).

get_diseases(Diseases) :-
        findall(Disease,
                odbc_query('swiprolog',
                           'select (name) from disease',
                           row(Disease)),
                Diseases).

get_disease_names(Names) :-
        findall(Name,
                odbc_query('swiprolog',
                           'select (real_name) from disease',
                           row(Name)),
                Names).

get_sympton_by_disease(Symptons, Disease) :-
    findall(Sympton,
                odbc_query('swiprolog',
                           'select (sympton.name) from sympton inner join sympton_disease on sympton.id = sympton_disease.sympton_id inner join disease on disease.id = sympton_disease.disease_id where disease.name = "~w"'-[Disease],
                           row(Sympton)),
                Symptons).


build_fact_sympton([]) :- !.
build_fact_sympton([S | S1]) :-
    assert(sympton(S)),
    build_fact_sympton(S1).
build_fact_symptons :-
    get_symptons(S),
    build_fact_sympton(S).

build_fact_question([], []) :- !.
build_fact_question([S | S1], [Q | Q1]) :-
    assert(question(S, Q)),
    build_fact_question(S1, Q1).
build_fact_questions :-
    get_symptons(S),
    get_questions(Q),
    build_fact_question(S, Q).

build_fact_disease([]) :- !.
build_fact_disease([D | D1]) :-
    assert(disease(D)),
    build_fact_disease(D1).
build_fact_diseases :-
    get_diseases(D),
    build_fact_disease(D).

build_fact_disease_name([], []) :- !.
build_fact_disease_name([D | D1], [N | N1]) :-
    assert(diseaseName(D, N)),
    build_fact_disease_name(D1, N1).
build_fact_disease_names :-
    get_diseases(D),
    get_disease_names(N),
    build_fact_disease_name(D, N).

build_fact_diagnosis_unit([]) :- !.
build_fact_diagnosis_unit([D | D1]) :-
    get_sympton_by_disease(S, D),
    assert(diagnosis(S, D)),
    build_fact_diagnosis_unit(D1).
build_fact_diagnosis :-
    get_diseases(D),
    build_fact_diagnosis_unit(D).

build_all :-
    open_connection,
    reset_system,
    build_fact_symptons,
    build_fact_questions,
    build_fact_diseases,
    build_fact_disease_names,
    build_fact_diagnosis,
    close_connection.

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
