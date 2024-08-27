public class Variable {
    public enum varType {
        UNDEFINED,
        STRING,
        NUMBER
    };

    public String name;
    public int numVal;
    public String strVal;
    public varType type;

    public Variable() {
        name = "";
        numVal = 0;
        strVal = "";
        type = varType.UNDEFINED;
    }

    public Variable(String name) {
        this.name = name;
        numVal = 0;
        strVal = "";
        type = varType.UNDEFINED;
    }
}
