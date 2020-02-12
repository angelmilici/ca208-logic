/*FACTS*/

route(dublin, cork, 200, 'fct').
route(cork, dublin, 200, 'fct').
route(cork, corkAirport, 20, 'fc').
route(corkAirport, cork, 25, 'fc').
route(dublin, dublinAirport, 10, 'fc').
route(dublinAirport, dublin, 20, 'fc').
route(dublinAirport, corkAirport, 225, 'p').
route(corkAirport, dublinAirport, 225, 'p').

/*RULES*/

speed(p,500).
speed(t,100).
speed(c,80).
speed(f,5).

places(S,D,V,P,T,M) :- route(S,D,_,_), append([D,S], V, L), reverse(L,P), fastest(S,D,_,T,M).
places(S,D,V,P,T,M) :- route(S,X,_,_), not(member(X,V)), fastest(S,X,_,T1,M), places(X,D,[S|V],P,Z,M), T is T1 + Z.
location(S,D,P,T,M) :- places(S,D,[],P,T,M).

footMode(S,D,Mode,TravelModes) :- 
			route(S,D,_,Modes),
            atom_chars(Modes,A),
            member(f,A),
            member(f,TravelModes),
            Mode = f.

carMode(S,D,Mode,TravelModes) :- 
			route(S,D,_,Modes),
            atom_chars(Modes,A),
            member(c,A),
            member(c,TravelModes),
            Mode = c.

trainMode(S,D,Mode,TravelModes) :-
			route(S,D,_,Modes),
    	    atom_chars(Modes,A),
	      	member(t,A),
    	    member(t,TravelModes),
    	    Mode = t.

planeMode(S,D,Mode,TravelModes) :-
			route(S,D,_,Modes),
            atom_chars(Modes,A),
            member(p,A),
            member(p,TravelModes),
            Mode = p.

fastest(S,D,Mode,T,TravelModes) :-
		    (planeMode(S,D,Mode,TravelModes);
            trainMode(S,D,Mode,TravelModes);
            carMode(S,D,Mode,TravelModes);
            footMode(S,D,Mode,TravelModes)),
            speed(Mode,Speed),
            route(S,D,Distance,_),
            T is Distance / Speed,!.

fastestRoute(S,D,P,Times,Mode) :-
			findall(T,location(S,D,_,T,Mode),A),
			min_member(Times,A),
			location(S,D,P,Times,Mode).

journey(S,D,M):-
			atom_chars(M,A),
    		fastestRoute(S,D,P,T,A),
    		write('Route = '),
    		write(P),
    		write('\n'),
    		write('Time = '),
    		write(T),
    		write(' hours.'),
    		write('\n').