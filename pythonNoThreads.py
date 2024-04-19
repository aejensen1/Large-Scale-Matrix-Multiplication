# Title: pythonNoThreads
# Author: Anders Jensen
# Description: A program that multiplies two matrices with no threading
# Version 1.0 (02/27/2024)

import sys
import time
import os

# Introduce program
print("Running pythonNoThreads: \n")

# Check if the command line argument is provided for the number of rows and columns
if len(sys.argv) > 1:
    try:
        n = int(sys.argv[1])
        if n < 1:
            raise ValueError("The number of rows and columns must be greater than zero.")
    except ValueError as e:
        print(f"Error: {e}\nPlease provide a valid integer for the number of rows/columns.")
        sys.exit(1)
else:
    print("Error: No size argument provided for the number of rows/columns.")
    sys.exit(1)

# Create array1 with n rows and n columns filled with 1s
print(f"Creating first array with {n} columns and {n} rows... \n")
array1 = [[1 for _ in range(n)] for _ in range(n)]

# Create array2
print(f"Creating second array with {n} columns and {n} rows... \n")
array2 = [[1 for _ in range(n)] for _ in range(n)]

# Perform matrix multiplication to compute array3
start_time = time.time()  # Start the timer
print("Performing matrix multiplication... \n")
array3 = [[sum(array1[i][k] * array2[k][j] for k in range(n)) for j in range(n)] for i in range(n)]
end_time = time.time()  # End the timer
execution_time = end_time - start_time  # Calculate the execution time

# Print a message or the resulting array based on the size condition
if n > 15:
    print(f"Array of size {n}x{n} created but too large to display.")
else:
    print("Resulting Array: ")
    for row in array3:
        print(' '.join(map(str, row)))

# Write statistics to file, including the number of threads
stats_filename = "pythonNoThreads_stats.txt"
with open(stats_filename, "w") as stats_file:
    stats_file.write(f"File name: {os.path.basename(__file__)}\n")
    stats_file.write(f"Matrix Size: {n}x{n}\n")
    stats_file.write(f"Number of Threads: 1\n")  # Specify number of threads used for non-threaded script
    stats_file.write(f"Execution Time: {execution_time:.4f} seconds\n")
print(f"Statistics written to {stats_filename}")
