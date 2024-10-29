% We use brackets to specify a list in prolog
% [1, 2, 3]

% We can have any combination of values in a list
% [1, 2, "hello", var]

% We can multi dimensional lists
% [1, 2, [3, 4], "hello"]

% Define some facts on lists

% Is satisfied iff a list with only one element is passed
% check([1]). -> true
% check([1, 2, 3]). -> false
check([Element]).

% Checks if list is empty
check([]).

% Checks if list has two elements
check([F, N]).


% append
% Usage: append(List1, List2, Result).
% This is a pre-defined rule in prolog.
% Result = List1 + List2


% How to index a list
% Example:
example([First|Rest]).
% example([33, 4, 5]). -> First = 33, Rest = [4, 5]
example([_|Rest]).
% example([33, 4, 5]). -> Rest = [4, 5]
example([_Second|Rest]).
% example([33, 4, 5]). -> Second = 4, Rest = [5]

% Some rules for lists
first_equal_last([Element]).
first_equal_last([First|Rest]) :- append(_, [First], Rest).

% Adding ! makes the call return after getting a single result
containsZero([H|_]) :- H = 0, !.
containsZero([_|T]) :- containsZero(T).

contains([H|_], I) :- H = I, !.
contains([_|T], I) :- contains(T, I).

is_negative([H|_]) :- H < 0, !.
is_negative([_,T]) :- is_negative(T).
