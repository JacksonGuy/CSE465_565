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
    /*
        Gets the common city names between the states listed in states.txt
    */
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

        // Get intersection
        HashSet<string> intersection = new HashSet<string>();
        foreach (string city in cities) {
            // Check that city is contained in each entry in states
            bool inAll = true;
            foreach(string state in states) {
                if (!stateCities[state].Contains(city)) {
                    inAll = false;
                    break;
                }
            }

            if (inAll) {
                intersection.Add(city);
            }
        }

        // Convert intersection to array
        string[] cityArr = new string[intersection.Count];
        intersection.CopyTo(cityArr);

        // Sort alphabetically and put into file
        Array.Sort(cityArr);
        string result = "";
        foreach (string city in cityArr) {
            result += city + Environment.NewLine;
        }
        File.WriteAllText("CommonCityNames.txt", result);
    }

    /*
        Gets the first latitude and longitude for each zipcode 
    */
    public static void GetLatLon(string[] lines)
    {
        string[] zips = File.ReadAllLines("zips.txt");

        Dictionary<string, string> zipLocations = 
            new Dictionary<string, string>();

        // Iterate over lines
        foreach (string line in lines) {
            // Get details about the line
            string[] tokens = line.Split("\t");
            string zipcode = tokens[1];
            string lat = tokens[6];
            string lon = tokens[7];

            // Current line has zipcode we aren't looking for
            if (Array.IndexOf(zips, zipcode) == -1) {
                continue;
            }

            // Only add first instance for each zipcode
            if (!zipLocations.ContainsKey(zipcode)) {
                zipLocations.Add(zipcode, lat + " " + lon);
            }
        }

        // Write result to file
        string result = "";
        foreach (string zip in zips) {
            result += zipLocations[zip] + Environment.NewLine;
        }
        File.WriteAllText("LatLon.txt", result);
    }

    /*
        Gets all the states which contain the given cities
    */
    public static void GetCityStates(string[] lines)
    {
        string[] cities = File.ReadAllLines("cities.txt");

        // Convert city names to upper case
        for (int i = 0; i < cities.Length; i++) {
            cities[i] = cities[i].ToUpper();
        }

        // HashSet of states for each city to ensure uniqueness
        Dictionary<string, HashSet<string>> cityStates = 
            new Dictionary<string, HashSet<string>>();

        // Initialize HashSets
        foreach (string city in cities) {
            cityStates.Add(city, new HashSet<string>());
        }

        // Iterate over each line
        foreach(string line in lines) {
            // Get line details
            string[] tokens = line.Split("\t");
            string city = tokens[3];
            string state = tokens[4];

            // Skip line if doesn't contain relevant city
            if (Array.IndexOf(cities, city) == -1) {
                continue;
            }

            // Add state to city HashSet
            cityStates[city].Add(state);
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

        GetCommonCityNames(lines);
        GetLatLon(lines);

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