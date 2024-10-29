using System;
using System.IO;
using System.Collections.Generic;

class average
{
    static void Main(string[] args)
    {
        var lines = File.ReadAllLines("inputNumbers.txt");

        float average = 0.0f;
        int count = 0;
        foreach(var line in lines)
        {
            average += int.Parse(line.Trim());
            count++;
        }
        average = average / count;
    
        var outputPath = "outputSummary.txt";
        var outputStr = $"Average of the {count} numbers is {average}";
        Console.WriteLine(outputStr);
        File.WriteAllText(outputPath, outputStr + Environment.NewLine);
    }
}
