% hw3.pl
% Jackson Frey

% ------------------------------------------------
% #1 (Undergraduate/Graduate) (5/5 pts)
% Determine the Maximum of two int numbers
% maxnums(A, B, MAX).

maxnums(A, B, A) :- A >= B.
maxnums(A, B, B) :- A < B.

% maxnums(-12, 12, MAX). -> MAX = 12
% maxnums(11232, 92674, MAX). -> MAX = 92674
% maxnums(1, 1, MAX). -> MAX = 1 
% ------------------------------------------------
% #2 (Undergraduate/Graduate) (5/5 pts)
% Determine the summation of a list of integer numbers
% sum(LST, SUM).

sum([], SUM) :- SUM is 0.
sum([H|T], SUM) :- sum(T,S), SUM is H + S.

% sum([1, 2, 3, 4], SUM). -> SUM = 10
% sum([10, -10], SUM). -> SUM = 0
% sum([], SUM). -> SUM = 0
% ------------------------------------------------
% #3 (Undergraduate/Graduate) (5/5 pts)
% Determine the Maximum of list of integer numbers
% ** You MUST use/call your maxnums predicate that you defined in #1
%    as part of your solution.
% ** You can always assume that the given LST is not empty. 
% max(LST, MAX).

max([E], MAX) :- MAX is E.
max([H|T], MAX) :- max(T, R), maxnums(H, R, MAX).

% max([-5, -5, -5], MAX). -> MAX = -5
% max([1], MAX). -> MAX = 1
% max([413, 0, 977], MAX). -> MAX = 977
% ------------------------------------------------
% #4 (Undergraduate/Graduate) (5/5 pts)
% Determine if a list of integer numbers can be split into two lists 
% that sum to the same value.
% ** You MUST use/call your sum predicate that you defined in #2
%    as part of your solution.
% ** You can always assume that the given LST is not empty. 
% partitionable(LST).

partitionable([_]).
partitionable(LST) :- 
    append(A, B, LST),
    sum(A, S1), sum(B, S2),
    S1 = S2.
 
% partitionable([1, 2, 3, 4, 10]). -> true. because [10, 10]
% partitionable([2, 1, 1]). -> true. because [2, 2]
% partitionable([0]). -> true.
% partitionable([1, 4, 8]). -> false.
% partitionable([3, 2]). -> false.
% ------------------------------------------------
% #5 (Undergraduate/Graduate) (5/5 pts)
% Determine whether the given integer number does exist in the given 
% list of integer numbers
% elementExist(E, LST).

elementExist(E, [E]) :- !.
elementExist(E, [E|_]) :- !.
elementExist(E, [_|T]) :- elementExist(E, T).

% elementExist(1, [1, 2, 3]). -> true.
% elementExist(1, []). -> false.
% elementExist(-10, [-34, -56, 2]). -> false.
% ------------------------------------------------
% #6 (Undergraduate/Graduate) (5/5 pts)
% Determine the reverse list of integer numbers
% reverse(LST, REVLST).

reverse([], []).
reverse([H|T], REVLST) :- reverse(T, R), append(R,[H],REVLST).

% reverse([], REVLST). -> REVLST = []
% reverse([1, 1, 1], REVLST). -> REVLST = [1, 1, 1]
% reverse([4, 0, -4, 6], REVLST). -> REVLST = [6, -4, 0, 4]
% reverse([47391], REVLST). -> REVLST = [47391]
% ------------------------------------------------
% #7 (Undergraduate/Graduate) (5/5 pts)
% Determine the list of integer numbers that are only one digit numbers
% collectOneDigits(LST, NEWLST). 

collectOneDigits([], []).
collectOneDigits([H|T], [H|Tail]) :- H < 10, collectOneDigits(T, Tail).
collectOneDigits([H|T], NEWLST) :- H >= 10, collectOneDigits(T, NEWLST).

% collectOneDigits([10, 90, -20], NEWLST). -> NEWLST = []
% collectOneDigits([], NEWLST). -> NEWLST = []
% collectOneDigits([10, 90, -20, 5, -6], NEWLST). -> NEWLST = [5, -6]
% ------------------------------------------------
% #8 (Undergraduate/Graduate) (5/5 pts)
% Consult the 'zipcodes.pl' file, and study it.
% It contains facts about the US zipcodes.
% location(Zipcode, Plcae, State, Location, Latitude, Longitude).
% Example: for getting all the Zipcodes and Sates you can do 
%         location(Z, _, S, _, _, _). 
% Determine all places based on given state and zipcode.
% getStateInfo(PLACE, STATE< ZIPCODE).

:- consult('zipcodes.pl').

getStateInfo(PLACE, STATE, ZIPCODE) :- location(ZIPCODE, PLACE, STATE, _, _, _).

% getStateInfo('Oxford', State, 45056). -> State = 'OH'
% getStateInfo('Oxford', State, _). -> 
% State = 'AL' 
% State = 'AR' 
% State = 'CT' 
% State = 'FL' 
% State = 'GA' 
% State = 'GA' 
% State = 'IA' 
% State = 'IN' 
% State = 'KS' 
% State = 'MA' 
% State = 'MD' 
% State = 'ME' 
% State = 'MI' 
% State = 'MI' 
% State = 'MS' 
% State = 'NC' 
% State = 'NE' 
% State = 'NJ' 
% State = 'NY' 
% State = 'OH' 
% State = 'PA' 
% State = 'WI'
% 
% getStateInfo(_, 'OH', 48122). -> false.
% ------------------------------------------------
% #9 (Undergrad/Grad) (15/5 pts)
% Consult the 'zipcodes.pl' file, and study it.
% It contains facts about the US zipcodes.
% location(Zipcode, Plcae, State, Location, Latitude, Longitude).
% Example: for getting all the Zipcodes and Sates you can do 
%         location(Z, _, S, _, _, _). 
% Gets place names that are common to both STATE1 and STATE2, 
% where STATE1 and STATE2 differ
% ** The order of places is not important
% ** Duplicate values should be removed
% ** You are to do your own search to find a way to return all 
%    places as a single list. You can use any necessary predicate 
%    from Prolog library. Being able to learn something
%    about a new programming language on your own is a skil that takes
%    practice. 
% getCommon(STATE1, STATE2, PLACELST).

% Get the intersection of two lists
inter([], _, []).
inter([H1|T1], L2, [H1|Res]) :-
    member(H1, L2),
    inter(T1, L2, Res).
inter([_|T1], L2, Res) :-
    inter(T1, L2, Res).

getCommon(STATE1, STATE2, PLACELIST) :- 
    findall(PLACE1, location(_,PLACE1,STATE1,_,_,_),STATE1PLACES),
    findall(PLACE2, location(_,PLACE2,STATE2,_,_,_),STATE2PLACES),
    inter(STATE1PLACES, STATE2PLACES, PLACELIST).

% getCommon('OH','MI',PLACELST). -> *Should be 131 unique plcase* 
% ['Manchester','Unionville','Athens','Saint
% Johns','Belmont','Bellaire','Bridgeport','Lansing','Flushing','D
% ecatur','Hamilton','Oxford','Trenton','Monroe','Augusta','Carrol
% lton','Milford','Moscow','New
% Richmond','Williamsburg','Clarksville','Midland','Elkton','Salem
% ','Blissfield','Bedford','Greenville','North Star','Union
% City','Sherwood','Ashley','Birmingham','Milan','Sandusky','Colum
% bus','Lyons','Metamora','Burton','Alpha','Cedarville','Jamestown
% ','Fairview','Harrison','Arcadia','Kenton','Ridgeway','Ada','Alg
% er','Freeport','Harrisville','Napoleon','Highland','Lakeville','
% Millersburg','Nashville','Bellevue','New
% Haven','Jackson','Wellston','Bloomingdale','Empire','Mount
% Pleasant','Richmond','Perry','Eastlake','Homer','Utica','Lakevie
% w','Quincy','Holland','Ellsworth','Petersburg','Marion','Caledon
% ia','Brunswick','Chippewa
% Lake','Litchfield','Portland','Coldwater','Mendon','Rockford','C
% ovington','Troy','Clayton','Vandalia','Fulton','Sparta','Rosevil
% le','Martin','Somerset','Jasper','Wakefield','Ravenna','Wayland'
% ,'Deerfield','Camden','Cloverdale','Plymouth','Shelby','Frankfor
% t','Kingston','Fremont','Adrian','Attica','Flat
% Rock','Fostoria','Republic','Sidney','Paris','Canton','Bath','Cl
% inton','Hudson','Akron','Fowler','Hartford','Niles','Warren','Du
% ndee','Marysville','Ray','Franklin','Mason','Lowell','Newport','
% ------------------------------------------------
% #10 ( -- /Graduate) (0/10 pts)
% ** Only for Graduate Studetns **
% Download the 'parse.pl' from canvas and study it.
% Write Prolog rules to parse simple English sentences 
% (similar to how it was done in parse.pl). The difference here is that 
% the number (i.e., plurality) of the noun phrase and verb phrase must match. 
% That is, “The sun shines” and “The suns shine” is proper, 
% whereas “The suns shines” and “The sun shine” are not. 
% Make sure your code also includes the following vocabulary.
% singular nouns: sun, bus, deer, grass, party
% plural nouns: suns, buses, deer, grasses, parties
% articles: a, an, the
% adverbs: loudly, brightly
% adjectives: yellow, big, brown, green, party
% plural verbs: shine, continue, party, eat
% singular verbs: shines, continues, parties, eats


% sentence([the, party, bus, shines, brightly]). -> true.
% sentence([the, big, party, continues]). -> true.
% sentence([a, big, brown, deer, eats, loudly]). -> true.
% sentence([big, brown, deer, eat, loudly]). -> true.
% sentence([the, sun, shines, brightly]). -> true.
% sentence([the, suns, shine, brightly]). -> true.
% sentence([the, deer, eats, loudly]). -> true.
% sentence([the, deer, eat, loudly]). -> true.
% sentence([the, sun, shine, brightly]). -> false.
%sentence([the, suns, shines, brightly]). -> false.
% ------------------------------------------------

