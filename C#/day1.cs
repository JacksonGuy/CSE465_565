using System;       // For console
using System.IO;    // File IO
using System.Collections.Generic; // Data Structures

/*
 * Classes without an access modifier are "internal" by default.
 * Internal classes are accessible from any code from within the same project.
 */
class Test 
{
    /*
     * Method names start with capital letter.
     * Methods without access modifiers are private by default.
     */
    static void Main(string[] args)
    {
        Console.Write("Enter an integer: ");

        int userInput = int.Parse(Console.ReadLine());
        // OR var userInput = int.Parse(Console.ReadLine());
        
        string inputFile = "inputNums.txt";
        var lines = File.ReadAllLines(inputFile);

        List<int> numbers = new List<int>();
        foreach(var line in lines)
        {
            int num = int.Parse(line.Trim());
            numbers.Add(num);
        }

        var outputPath = "output.txt";
        File.WriteAllText(outputPath, string.Empty);

        for (int i = 0; i < numbers.Count; i++)
        {
            if (numbers[i] > userInput)
            {
                var outStr = $"{numbers[i]} is greater than {userInput}";
                Console.WriteLine(outStr);
            
                // \n does not work on all computers (???)
                // so we use Environment.NewLine instead
                File.AppendAllText(outputPath, outStr + Environment.NewLine);
            }
            else if (numbers[i] < userInput) 
            {
                var outStr = $"{numbers[i]} is less than {userInput}";
                Console.WriteLine(outStr);
                File.AppendAllText(outputPath, outStr + Environment.NewLine);
            }
            else
            {
                var outStr = $"{numbers[i]} is equal to{userInput}";
                Console.WriteLine(outStr);
                File.AppendAllText(outputPath, outStr + Environment.NewLine);
            }
        }
    }
}
