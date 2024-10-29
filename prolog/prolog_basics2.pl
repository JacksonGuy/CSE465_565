female(janet). % Janet is a female
female(jennifer).
female(hannah).
female(abigail).

male(todd).
male(matt).
male(mitch).
male(mike).
male(phil).

father(mike, abigail). % It means mike is the father of abigail
father(mike, hannah).

mother(jennifer, abigail).
mother(jennifer, hannah).

father(todd, matt).
father(todd, mitch).

mother(janet, matt).
mother(janet, mitch).

father(phil, jennifer).
father(phil, todd).

% rules
% we combine facts to define rules
parent(X, Y) :- father(X, Y).
parent(X, Y) :- mother(X, Y).
grandfather(X, Z) :- parent(X, Y), parent(Y, Z).

% some queries
% grandfather(G, _).
% grandfather(_, GC).

siblings(X, Y) :- parent(P, X), parent(P, Y), not(X=Y).
cousin(X, Y) :- parent(A, X), parent(B, Y), siblings(A, B).
uncle(X, Y) :- parent(A, Y), siblings(X, A), male(X).


% Arithmetic operators
% +,-,*,/
% div (integer division)
% mod (modular arithmetic)

add(A, B, R) :- R is A + B.
add(A, B, R) :- nonvar(A), nonvar(B), var(R), R is A + B.
add(A, B, R) :- var(A), nonvar(B), nonvar(R), A is R - B.
add(A, B, R) :- nonvar(A), var(B), nonvar(R), B is R - A.

% math with facts
speed(ford, 100).
speed(chevy, 105).

time(ford, 20).
time(chevy, 21).

distance(car, D) :- speed(Car, S), time(Car, T), D is S * T.

% Logical operators
% =, <, >
% >=    =<      (fuck this language)
% /=            (not equal) (you can also just do not(X = Y) )

person(john, 28).
person(mary, 22).
person(sam, 34).
person(amy, 28).

% Return all people who are 28 or older
age28(P) :- person(P, Age), Age >= 28.

% Returns people with the same age
sameAge(Name1, Name2) :- Person(Name1, Age1), Person(Name2, Age2), Age1 = Age2, not(Name1 = Name2).

% Returns age difference
ageDiff(N1, N2, D) :- Person(N1, A1), Person(N2, A2), not(N1 = N2), D is abs(A1 - A2).
