myElem(X,[X|_]).
myElem(X,[_|T]) :-
	myElem(X,T).

myHead(X,[X|_]).

myLast(X,[X]).
myLast(X,[_|T]) :-
	myLast(X,T).

myTail(X,[_|X]).

myAppend([],L,L).
myAppend([H|T],L,[H|Y]) :-
	myAppend(T,L,Y).

myReverse([],[]).
myReverse([H|T], B) :- myReverse(T,R), myAppend(R,[H],B).

myDelete(X,[X|L1],L1).
myDelete(X,[Y|L1],[Y|L2]) :-
	myDelete(X,L1,L2).
