# Jackson Frey

import sys
import re

# From Interpreter.py file from class
TOKEN_SPECIFICATION = (
    ('INT_VAR',     r'[a-zA-Z_][a-zA-Z_0-9]*\s'),                   # Integer variable (lookahead for assignment and operations)
    ('STR_VAR',     r'[a-zA-Z_][a-zA-Z_0-9]*\s'),                   # String variable (lookahead for assignment and addition)
    ('ASSIGN',      r'(?<=\s)\=(?=\s)'),                            # Assignment operator
    ('PLUS_ASSIGN', r'(?<=\s)\+=(?=\s)'),                           # Addition assignment operator
    ('MINUS_ASSIGN',r'(?<=\s)-=(?=\s)'),                            # Subtraction assignment operator
    ('MULT_ASSIGN', r'(?<=\s)\*=(?=\s)'),                           # Multiplication assignment operator
    ('INT_VAR_VAL', r'(?<=[\+\-\*]=)\s[a-zA-Z_][a-zA-Z_0-9]*'),     # Integer variable (lookahead for operations)
    ('STR_VAR_VAL', r'(?<=\+=)\s[a-zA-Z_][a-zA-Z_0-9]*'),           # String variable (lookahead for addition)
    ('ASS_VAL', r'(?<=\=)\s[a-zA-Z_][a-zA-Z_0-9]*'),                # variable (lookahead for assignment)
    ('NUMBER',      r'(?<=\s)-?\d+(?=\s)'),                         # Integer literal
    ('STRING',      r'"[^"]*"'),                                    # String literal, handling quotes
    ('SEMICOLON',   r'(?<=\s);'),                                   # Statement terminator
    ('WS',          r'\s+'),                                        # Whitespace
    ('NEWLN',       r'\n')
)

def gatherTokens(file):
    tokens = []
    for line in file:
        for token in line.split():
            tokens.append(token)
    return tokens

if __name__ == "__main__":
    filename = sys.argv[1]
    file = open(filename, "r")

    tokens = gatherTokens(file)
    print(tokens)
