import time

"""
  Homework#5

  Add your name here: Jackson Frey

  You are free to create as many classes within the hw5.py file or across 
  multiple files as you need. However, ensure that the hw5.py file is the 
  only one that contains a __main__ method. This specific setup is crucial 
  because your instructor will run the hw5.py file to execute and evaluate 
  your work.

"""
"""
1- => Lambda was used in line/s: ............
2- => Filter or map was used in line/s: ...........
3- => yield was used in line/s: .........
"""

def CommonCityNames(zipcodes):
    file = open("states.txt")
    states = [state[:-1] for state in file][:-1]
   
    # Dictionary for State -> City list
    stateCities = {state:[] for state in states}

    # Collect cities for each state
    for line in zipcodes:
        if (line[4] in states):
            stateCities[str(line[4])].append(line[3])

    # Get intersection
    common = list(set.intersection(*[set(x) for x in stateCities.values()]))
    common.sort()

    # Write to file
    outfile = open("CommonCityNames.txt", "w")
    for city in common:
        outfile.write(city + '\n')

def ZipCodes(zipcodes):
    file = open("zips.txt")
    codes = [code[:-1] for code in file]
    
    # Dictionary for Zipcode -> Lat/Lon
    coords = {code:"" for code in codes}

    # Collect coords for each zipcode
    found = []
    for line in zipcodes:
        if (line[1] in codes and line[1] not in found):
            coords[line[1]] = line[6] + " " + line[7]
            found.append(line[1])

    # Write to file
    outfile = open("LatLon.txt", "w")
    for latlon in coords.values():
        outfile.write(latlon + "\n")

def CityStates(zipcodes):
    file = open("cities.txt")
    cities = [city[:-1] for city in file]

    # Dictionary for City -> list of states
    cityStates = {city:[] for city in cities}

    # Collect states
    for line in zipcodes:
        city = line[3][0] + line[3][1:].lower()
        state = line[4]

        if (city in cities and state not in cityStates[city]):
            cityStates[city].append(state)
    
    # Sort lists
    for city in cities:
        cityStates[city].sort()

    print(cityStates)

if __name__ == "__main__": 
    start_time = time.perf_counter()  # Do not remove this line
    '''
    Inisde the __main__, do not add any codes before this line.
    -----------------------------------------------------------
    '''

    zipcodeFile = open("zipcodes.txt")
    zipCodeLines = [line.split('\t') for line in zipcodeFile]
    zipcodes = zipCodeLines[1:]


    CommonCityNames(zipcodes)
    ZipCodes(zipcodes)
    CityStates(zipcodes)

    '''
    Inside the __main__, do not add any codes after this line.
    ----------------------------------------------------------
    '''
    end_time = time.perf_counter()
    # Calculate the runtime in milliseconds
    runtime_ms = (end_time - start_time) * 1000
    print(f"The runtime of the program is {runtime_ms} milliseconds.")  
    

