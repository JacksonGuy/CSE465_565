
import java.io.File;
import java.util.*;
import java.io.FileNotFoundException;

public class Zpm {
    enum VariableType {
        STRING,
        NUMBER
    }

    private HashMap<String, Variable> variables; 
    private File file;
    private int lineCount;

    private String[] langKeywords = {
        "FOR",
        "ENDFOR",
        "PRINT",
        "=",
        "+=",
        "-=",
        "*=",
        ";"
    };

    private Variable modifyVar;
    public Zpm(String filename) {
        variables = new HashMap<String, Variable>();    
        file = new File(filename);
        lineCount = 1;
    }

    private void ParseStringList(List<String> tokens) {
        int i = 0;
        while (i < tokens.size()) {
            String token = tokens.get(i);
            String value;

            // System.out.println("Token: " + token);

            if (isLangKeyword(token)) {
                switch (token) {
                    case "FOR":
                        String countStr = tokens.get(i+1);
                        i += 2;
                        
                        int forLoopCount = Integer.parseInt(countStr);
                        List<String> forLoopTokens = new ArrayList<String>();
                        int forCounter = 1;

                        // Collect for loop tokens
                        while (forCounter > 0) {
                            String newToken = tokens.get(i);
                            while (!newToken.equals("ENDFOR")) {
                                forLoopTokens.add(newToken);
                                if (newToken.equals("FOR")) {
                                    forCounter++;
                                }
                                i++;
                                if (i < tokens.size()) {
                                    newToken = tokens.get(i);
                                }
                                else {
                                    // FOR doesn't conclude with ENDFOR
                                    System.out.println("RUNTIME ERROR: Line " + lineCount);
                                    System.exit(0);
                                }
                            }
                            forLoopTokens.add(newToken);
                            forCounter--;
                        }

                        // System.out.println(forLoopTokens);

                        // Execute for loop
                        for (int loop = 0; loop < forLoopCount; loop++) {
                            ParseStringList(forLoopTokens);
                        }

                        i++;
                        break;
                    
                    case "ENDFOR":
                        i++;
                        break;

                    case "PRINT":
                        String val = tokens.get(i+1);
                        Variable variable;
                        if (variables.containsKey(val)) {
                            variable = variables.get(val);
                            if (variable.type == Variable.varType.STRING) {
                                System.out.println(val + "=" + variable.strVal);
                            }
                            else if (variable.type == Variable.varType.NUMBER) {
                                System.out.println(val + "=" + variable.numVal);
                            }
                        }
                        else {
                            // Runtime error: using nonexistent variable
                            System.out.println("RUNTIME ERROR: Line " + lineCount);
                            System.exit(0);
                        }
                        i += 2;
                        break;
                    case "=":
                        value = tokens.get(i+1);

                        if (value.charAt(0) == '\"') {
                            modifyVar.strVal = value.substring(1, value.length() - 1);
                            modifyVar.type = Variable.varType.STRING;
                        }
                        else if (isNumber(value)) {
                            modifyVar.numVal = Integer.parseInt(value);
                            modifyVar.type = Variable.varType.NUMBER;
                        }
                        else {
                            if (variables.containsKey(value)) {
                                Variable otherVar = variables.get(value);
                                if (otherVar.type == Variable.varType.STRING) {
                                    if (modifyVar.type == Variable.varType.STRING) {
                                        modifyVar.strVal = otherVar.strVal;
                                        modifyVar.type = Variable.varType.STRING;
                                    }
                                    else {
                                        // Tried adding string to a number
                                        System.out.println("RUNTIME ERROR: Line " + lineCount);
                                        System.exit(0);
                                    }
                                }
                                else if (otherVar.type == Variable.varType.NUMBER) {
                                    if (modifyVar.type == Variable.varType.NUMBER) {
                                        modifyVar.numVal = otherVar.numVal;
                                        modifyVar.type = Variable.varType.NUMBER;
                                    }
                                    else {
                                        // Tried adding a number to a string
                                        System.out.println("RUNTIME ERROR: Line " + lineCount);
                                        System.exit(0);
                                    }
                                }
                            }
                            else {
                                // Variable Doesn't Exist
                                System.out.println("RUNTIME ERROR: Line " + lineCount);
                                System.exit(0);
                            }
                        }
                        i += 2;
                        break;
                    case "+=":
                        value = tokens.get(i+1);

                        if (value.charAt(0) == '\"') {
                            if (modifyVar.type == Variable.varType.STRING) {
                                modifyVar.strVal += value.substring(1, value.length() - 1);
                            }
                            else {
                                // Can't add string to number
                                System.out.println("RUNTIME ERROR: Line " + lineCount);
                                System.exit(0);
                            }
                        }
                        else if (isNumber(value)) {
                            if (modifyVar.type == Variable.varType.NUMBER) {
                                modifyVar.numVal += Integer.parseInt(value);
                            }
                            else {
                                // Can't add number to string
                                System.out.println("RUNTIME ERROR: Line " + lineCount);
                                System.exit(0);
                            }
                        }
                        else {
                            if (variables.containsKey(value)) {
                                Variable otherVar = variables.get(value);
                                if (otherVar.type == Variable.varType.STRING) {
                                    if (modifyVar.type == Variable.varType.STRING) {
                                        modifyVar.strVal += otherVar.strVal;
                                        modifyVar.type = Variable.varType.STRING;
                                    }
                                    else {
                                        // Tried adding string to a number
                                        System.out.println("RUNTIME ERROR: Line " + lineCount);
                                        System.exit(0);
                                    }
                                }
                                else if (otherVar.type == Variable.varType.NUMBER) {
                                    if (modifyVar.type == Variable.varType.NUMBER) {
                                        modifyVar.numVal += otherVar.numVal;
                                        modifyVar.type = Variable.varType.NUMBER;
                                    }
                                    else {
                                        // Tried adding a number to a string
                                        System.out.println("RUNTIME ERROR: Line " + lineCount);
                                        System.exit(0);
                                    }
                                }
                            }
                            else {
                                // Variable Doesn't Exist
                                System.out.println("RUNTIME ERROR: Line " + lineCount);
                                System.exit(0);
                            }
                        }
                        i += 2;
                        break;
                    case "-=":
                        value = tokens.get(i+1);

                        if (isNumber(value)) {
                            if (modifyVar.type == Variable.varType.NUMBER) {
                                modifyVar.numVal -= Integer.parseInt(value);
                            }
                            else {
                                // Can't subtract number from string
                                System.out.println("RUNTIME ERROR: Line " + lineCount);
                                System.exit(0);
                            }
                        }
                        else if (variables.containsKey(value)) {
                            Variable otherVar = variables.get(value);
                            if (otherVar.type == Variable.varType.NUMBER) {
                                if (modifyVar.type == Variable.varType.NUMBER) {
                                    modifyVar.numVal *= otherVar.numVal;
                                }
                                else {
                                    // Can't subtract number with string
                                    System.out.println("RUNTIME ERROR: Line " + lineCount);
                                    System.exit(0);
                                }
                            }
                            else {
                                // Can't subtract string with anything
                                System.out.println("RUNTIME ERROR: Line " + lineCount);
                                System.exit(0);
                            }
                        }
                        else {
                            // Can't subtract string
                            System.out.println("RUNTIME ERROR: Line " + lineCount);
                            System.exit(0);
                        }
                        i += 2;
                        break;
                    case "*=":
                        value = tokens.get(i+1);

                        if (isNumber(value)) {
                            if (modifyVar.type == Variable.varType.NUMBER) {
                                modifyVar.numVal *= Integer.parseInt(value);
                            }
                            else {
                                // Can't multiply number from string
                                System.out.println("RUNTIME ERROR: Line " + lineCount);
                                System.exit(0);
                            }
                        }
                        else if (variables.containsKey(value)) {
                            Variable otherVar = variables.get(value);
                            if (otherVar.type == Variable.varType.NUMBER) {
                                if (modifyVar.type == Variable.varType.NUMBER) {
                                    modifyVar.numVal *= otherVar.numVal;
                                }
                                else {
                                    // Can't multiply number with string
                                    System.out.println("RUNTIME ERROR: Line " + lineCount);
                                    System.exit(0);
                                }
                            }
                            else {
                                // Can't multiply string with anything
                                System.out.println("RUNTIME ERROR: Line " + lineCount);
                                System.exit(0);
                            }
                        }
                        else {
                            // Can't multiply string
                            System.out.println("RUNTIME ERROR: Line " + lineCount);
                            System.exit(0);
                        }
                        i += 2;
                        break;
                    case ";":
                        lineCount++;
                        i++;
                        break;
                }
            }
            else {
                // If not language keyword, then must be variable name
                // If we haven't defined this variable yet, create it
                if (!variables.containsKey(token)) {
                    Variable newVar = new Variable(token);
                    variables.put(token, newVar);
                    modifyVar = newVar;
                }
                else {
                    modifyVar = variables.get(token);
                }
                i++;
            }
        }
    }

    public void ParseFile() {
        try {
            Scanner scanner = new Scanner(file);
            List<String> tokens = new ArrayList<String>();

            while (scanner.hasNextLine()) {
                String[] subTokens = scanner.nextLine().split(" ");
                for (String tok : subTokens) {
                    tokens.add(tok);
                }
            }
            
            ParseStringList(tokens);

            scanner.close();
        } catch (FileNotFoundException ex) {
            System.out.println("Error: file not found");
        }
    }

    private Boolean isLangKeyword(String token) {
        for (String langTok : langKeywords) {
            if (token.equals(langTok)) {
                return true;
            }
        }
        return false;
    }

    private Boolean isNumber(String str) {
        for (int i = 0; i < str.length(); i++) {
            char ch = str.charAt(i);
            if (!Character.isDigit(ch) || (ch != '-' && i == 0)) return false;
        }
        return true;
    }

    public static void main(String[] args) {
        Zpm interpreter = new Zpm(args[0]);
        interpreter.ParseFile();
    }
}
