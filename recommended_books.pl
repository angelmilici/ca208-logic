/* Facts-define books */

book(illiad,homer,study,500).
book(c,richie,study, 150).
book(ntbible,sams,reference,480).
book(ntfordummies,bob, reference,200).
book(montypython,cleese,comedy,300).
book(pythonalgorithms,david,study, 225).
book(lilacbus,binchey,fiction,200).
book(hamlet,shakespere,drama,450).

/* RULES */

/* There is a built-in predicate findall that has 3 arguements, a generating template, a matching predicate and a list of generate predicates.
   Whenever the matching predicate is true it adds a predicate in the list using the generating predicate.
   In the following line it will generate a list of all the books in a list called Lib.
*/

build_library(Lib) :- findall(book(Title, Author, Genre, Size), book(Title, Author, Genre, Size), Lib).

is_holiday(book(_, _, G, S)) :- G \== study, G \== reference, S < 400.

holiday(B, [B|_]) :- is_holiday(B).
holiday(B, [_|T]) :- holiday(B, T).

/*
revision_book(book(_, _, Genre)) :- Genre == study, Genre == reference, Size > 300.

revision(_, []).
revision(B, [B|Lib]) :- revision_book(B), revision(B, Lib).
revision(B, [_|XS]) :- revision(B, XS).

literary_book(book(_, _, Genre, _)) :- Genre == drama.

literary(_, []).
literary(B, [B|Lib]) :- literary_book(B), literary(B, Lib).
literary(B, [_|XS]) :- literary(B, XS).

leisure_book(book(_, _, Genre, _)) :- Genre == comedy, Genre == fiction.

leisure(_,[]).
leisure(B,[B|Lib]) :- leisure_book(B), leisure(B,Lib).
leisure(B,[_|XS]) :- leisure(B,XS).
*/