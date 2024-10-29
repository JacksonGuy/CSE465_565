/* 
  Homework#4

  Add your name here: Jackson Frey

  You are free to create as many classes within the Hw4.cs file or across 
  multiple files as you need. However, ensure that the Hw4.cs file is the 
  only one that contains a Main method. This method should be within a 
  class named hw4. This specific setup is crucial because your instructor 
  will use the hw4 class to execute and evaluate your work.
  */
  // BONUS POINT:
  

using System;
using System.IO;
using System.Collections.Generic;

public class Hw4
{
    public static void GetCommonCityNames(string[] lines)
    {
        // Open states.txt to get states
        string[] states = File.ReadAllLines("states.txt");

        // List of cities for each state
        Dictionary<string, List<string>> stateCities = 
            new Dictionary<string, List<string>>();

        // List of all cities
        List<string> cities = new List<string>();

        // Iterate over zipcode file lines
        // and add cities to their respective lists        
        foreach(string line in lines) {
            // Get details about the line
            string[] tokens = line.Split("\t");
            string city = tokens[3];
            string state = tokens[4];

            // Don't do anything if line is for state we don't care about
            if (Array.IndexOf(states, state) == -1) {
                continue;
            }

            // Check if dictionary contains key
            if (!stateCities.ContainsKey(state)) {
                stateCities.Add(state, new List<string>());
            }

            // Add to state List and overall List
            stateCities[state].Add(city);
            cities.Add(city);
        }


    }

    public static void Main(string[] args)
    {
        // Capture the start time
        // Must be the first line of this method
        DateTime startTime = DateTime.Now; // Do not change
        // ============================
        // Do not add or change anything above, inside the 
        // Main method
        // ============================

        string[] lines = File.ReadAllLines("zipcodes.txt");

        // ============================
        // Do not add or change anything below, inside the 
        // Main method
        // ============================

        // Capture the end time
        DateTime endTime = DateTime.Now;  // Do not change
        
        // Calculate the elapsed time
        TimeSpan elapsedTime = endTime - startTime; // Do not change
        
        // Display the elapsed time in milliseconds
        Console.WriteLine($"Elapsed Time: {elapsedTime.TotalMilliseconds} ms");
    }
}