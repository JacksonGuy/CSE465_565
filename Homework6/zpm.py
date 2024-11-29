# Jackson Frey

import sys
import re

# From Interpreter.py file on canvas
TOKEN_SPECIFICATION = (
    ('VAR',         r'[a-zA-Z_][a-zA-Z_0-9]*\s'),
    ('ASSIGN',      r'(?<=\s)\=(?=\s)'),                            # Assignment operator
    ('PLUS_ASSIGN', r'(?<=\s)\+=(?=\s)'),                           # Addition assignment operator
    ('MINUS_ASSIGN',r'(?<=\s)-=(?=\s)'),                            # Subtraction assignment operator
    ('MULT_ASSIGN', r'(?<=\s)\*=(?=\s)'),                           # Multiplication assignment operator
    ('DIV_ASSIGN',  r'(?<=\s)\\=(?=\s)'),                           # Division assignment operator
    ('INT_VAR_VAL', r'(?<=[\+\-\*]=)\s[a-zA-Z_][a-zA-Z_0-9]*'),     # Integer variable (lookahead for operations)
    ('STR_VAR_VAL', r'(?<=\+=)\s[a-zA-Z_][a-zA-Z_0-9]*'),           # String variable (lookahead for addition)
    ('ASS_VAL',     r'(?<=\=)\s[a-zA-Z_][a-zA-Z_0-9]*'),            # variable (lookahead for assignment)
    ('NUMBER',      r'(?<=\s)-?\d+(?=\s)'),                         # Integer literal
    ('STRING',      r'"[^"]*"'),                                    # String literal, handling quotes
    ('SEMICOLON',   r'(?<=\s);'),                                   # Statement terminator
    ('WS',          r'\s+'),                                        # Whitespace
    ('NEWLN',       r'\n')
)

line_number = 0
variables = {}

def lexicalAnalysis(line):
    tokens = []

    for tokenType, tokenRegex in TOKEN_SPECIFICATION:
        regex = re.compile(tokenRegex)
        match = regex.findall(line)
        
        if match and tokenType != 'WS' and tokenType != 'NEWLN':
            for mat in match:
                tok = (tokenType, mat.strip())
                tokens.append(tok)
    return tokens

def parseTokens(tokens):
    it = iter(tokens)

    for token in it:
        if (token[0] == "VAR"):
            # Special case for print statement
            if (token[1] == "PRINT"):
                var_name = next(it)[1]
                semicolon = next(it)[1]
                if (var_name in variables):
                    if (type(variables[var_name]) == int):
                        print(f"{var_name}: {variables[var_name]}")
                    else:
                        print(f"{var_name}: \"{variables[var_name]}\"")
                else:
                    print(f"Undefined variable '{var_name}' on line {line_number}")
                    sys.exit()
                continue

            var_name = token[1]
            
            # If we're assigning variable to variable,
            # we need to skip the next token
            temp = next(it)
            if (temp[0] == "VAR"):
                temp = next(it)
            
            op_token = temp[1]
            value_token = next(it)
            semicolon = next(it)[1]
            value = None

            if (value_token[0] == "NUMBER"):
                value = int(value_token[1])
            elif (value_token[0] == "STRING"):
                value = value_token[1][1:-1]
            else:
                # We are assigning a variable to a variable
                value = variables[value_token[1]]
                if (value == None):
                    print(f"Undefined variable '{value_token[1]}' on line {line_number}.")
                    sys.exit()

            try:
                if (op_token == "="):
                    variables[var_name] = value
                elif (op_token == "+="):
                    variables[var_name] += value
                elif (op_token == "-="):
                    variables[var_name] -= value
                elif (op_token == "*="):
                    variables[var_name] *= value
                elif (op_token == "\\="):
                    variables[var_name] = int(variables[var_name] / value)
            except Exception as e:
                print(f"Error on line {line_number}")
                sys.exit()

if __name__ == "__main__":
    filename = sys.argv[1]
    file = open(filename, "r")

    for line in file:
        line_number += 1
        tokens = lexicalAnalysis(line)
        #print(tokens)
        parseTokens(tokens)
    print("\n\n")

