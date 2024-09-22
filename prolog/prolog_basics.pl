% This is a comment 

% statements is prolog end with a period 

% we exit from SWI-prolog using "halt." statement 

% prolog = "Programming in logic" 

% How does it work? 
% 1. we define facts and rules about objects 
% 2. we use queries to retrieve data 

% example: 
person(jake).   % jake is a person
person(bill).

% these have the data type "atom" 

% there are no rules for defining facts
likes(bill, chocolate).  % bill likes chocolate
likes(jake, music).

% we compile prolog programs using the "consult("file.pl")." statement

% example of a query: person(People).
% People is a variable (must be capital)
