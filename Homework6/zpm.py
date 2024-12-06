# Jackson Frey

import sys
import re
from typing import List

# From Interpreter.py file on canvas
TOKEN_SPECIFICATION = (
    ('STRING',      r'"[^"]*"'),                                    # String literal, handling quotes
    ('VAR',         r'[a-zA-Z_][a-zA-Z_0-9]*'),
    ('PLUS_ASSIGN', r'\+='),                                        # Addition assignment operator
    ('MINUS_ASSIGN',r'-='),                                         # Subtraction assignment operator
    ('MULT_ASSIGN', r'\*='),                                        # Multiplication assignment operator
    ('DIV_ASSIGN',  r'\\='),                                        # Division assignment operator
    ('INT_VAR_VAL', r'(?<=[\+\-\*]=)\s[a-zA-Z_][a-zA-Z_0-9]*'),     # Integer variable (lookahead for operations)
    ('STR_VAR_VAL', r'(?<=\+=)\s[a-zA-Z_][a-zA-Z_0-9]*'),           # String variable (lookahead for addition)
    ('ASS_VAL',     r'(?<=\=)\s[a-zA-Z_][a-zA-Z_0-9]*'),            # variable (lookahead for assignment)
    ('ASSIGN',      r'\='),                                         # Assignment operator
    ('NUMBER',      r'-?\d+'),                                      # Integer literal
    ('SEMICOLON',   r';'),                                          # Statement terminator
    ('WS',          r'\s+'),                                        # Whitespace
    ('NEWLN',       r'\n')
)

line_number = 0
variables = {}

def splitWords(line: str) -> List[str]:
    words = []
    buffer = ""
    gatherQuote = False
    escapeChar = False
    for char in line:
        # If we are inside a quote, add every character
        if (gatherQuote):
            if (char == "\\"):
                escapeChar = True
                continue
            
            # We reached the end of the quote
            if (char == '"' and escapeChar == False):
                gatherQuote = False

            # Otherwise, add character to buffer
            buffer += char
            escapeChar = False
            continue

        if (char == ' '):
            buffer = buffer.strip()
            if (buffer[0] == '"'):
                #buffer = buffer[1:-1]
                pass
            words.append(buffer)
            buffer = ""
        elif (char == '"'):
            gatherQuote = True
    
        buffer += char

    # End of line
    if (buffer[-1] == '\n'):
        buffer = buffer[:-1].strip()
    words.append(buffer.strip())
    return words

def lexicalAnalysis(line: str) -> List[str]:
    tokens = []
    words = splitWords(line)

    for word in words:
        for tokenType, tokenRegex in TOKEN_SPECIFICATION:
            regex = re.compile(tokenRegex)
            match = regex.findall(word)

            if match and tokenType != 'WS' and tokenType != 'NEWLN':
                tok = (tokenType, match[0])
                tokens.append(tok)
                break
   
    # Fix tokens
    if (len(tokens) == 0): 
        return tokens

    index = 0
    
    return tokens

def parseTokens(tokens: List[str]) -> None:
    it = iter(tokens)

    for token in it:
        if (token[0] == "VAR"):
            # Special case for print statement
            if (token[1] == "PRINT"):
                var_name = next(it)[1]
                semicolon = next(it)[1]
                if (var_name in variables):
                    if (type(variables[var_name]) == int):
                        print(f"{var_name} = {variables[var_name]}")
                    else:
                        print(f"{var_name} = \"{variables[var_name]}\"")
                else:
                    print(f"Undefined variable '{var_name}' on line {line_number}")
                    sys.exit()
                continue
            # Special case for loops
            elif (token[1] == "FOR"):
                loop_amount = int(next(it)[1])
                loop_tokens = []
                current = next(it)
                while (current[1] != "ENDFOR"):
                    loop_tokens.append(current)
                    current = next(it)

                for i in range(loop_amount):
                    parseTokens(loop_tokens)
                
                # ENDFOR comes at the end of a line, so no other tokens left
                return

            var_name = token[1]
            
            op_token = next(it)[1]
            value_token = next(it)
            semicolon = next(it)[1]
            value = None

            # Implicitly define variable if it doesn't exist yet
            if (var_name not in variables):
                variables[var_name] = 0

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
            except KeyError as e:
                print(f"Undefined variable {e} on line {line_number}")
                sys.exit()
            except Exception as e:
                print(f"Error on line {line_number}")
                #print(f"{type(e)}: {e}")
                sys.exit()

if __name__ == "__main__":
    filename = sys.argv[1]
    file = open(filename, "r")

    for line in file:
        line_number += 1
        tokens = lexicalAnalysis(line)
        #print(tokens)
        parseTokens(tokens)
