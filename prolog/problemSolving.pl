% problem solving

% length predicate
% length([1,2,3], Result). -> Result = 3

% lets do this on our own
getLength([],0).
getLength([_|T], Result) :- getLength(T, Count), Result is Count + 1.

% Returns the sum of all elements
sumList([], 0).
sumList([H|T], Result) :- sumList(T, Sum), Result is Sum + H.

% Returns true if the elements are in ascending order
is_ascending([]).
is_ascending([_]) :- !.
is_ascending([E1,E2|T]) :- E1 =< E2, is_ascending([E2|T]).

% Returns true if the given element is present in the list
contains(Element, [Element|_]) :- !.
contains(Element, [_,T]) :- contains(Element, T).

% Returns the index of the given element in the list
indexOf([], E, Index) :- Index is -1.
indexOf([E,_], E, Index).
indexOf([H|T], E, Index) :- indexOf(T, E, I), Index is I + 1.

getCount([], E, 0).
getCount([E|T], E, Count) :- getCount(T, E, C), Count is C + 1.
getCount([_,T], E, Count) :- getCount(T, E, Count).
