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
        if (line[3] in states):
            stateCities[str(line[3])].append(line[4])

def ZipCodes(zipcodes):
    pass

def CityStates(zipcodes):
    pass

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
    

