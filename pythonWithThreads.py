# Title: pythonWithThreads
# Author: Anders Jensen
# Description: A program that multiplies two matrices using threads
# Version 1.0 (02/27/2024)

import sys
import threading
import time
import os

# Function to perform matrix multiplication for a given range of row indices
def multiply_rows(start_row, end_row, array1, array2, result, n):
    for row_index in range(start_row, end_row):
        result_row = [sum(array1[row_index][k] * array2[k][j] for k in range(n)) for j in range(n)]
        result[row_index] = result_row

if __name__ == "__main__":
    print("Running pythonWithThreads: \n")

    # Check command line arguments for the number of rows/columns and threads
    if len(sys.argv) < 7:
        print("Error: 6 arguments required - number of rows/columns and number of threads.")
        sys.exit(1)
    
    try:
        n = int(sys.argv[1])  # Argument parsing for matrix size
        num_threads = int(sys.argv[2])  # Argument parsing for number of threads
        if n < 1 or num_threads < 1:
            raise ValueError("Both arguments must be greater than zero.")
    except ValueError as e:
        print(f"Invalid input: {e}")
        sys.exit(1)

    # Initialize matrices
    array1 = [[1] * n for _ in range(n)]
    array2 = [[1] * n for _ in range(n)]
    array3 = [[0] * n for _ in range(n)]  # Fully initialize array3 to the right size

    # Dynamically adjust the number of threads if more threads than rows
    num_threads = min(num_threads, n)

    # Timing and matrix multiplication
    start_time = time.time()
    print(f"Performing matrix multiplication using {num_threads} thread(s)...\n")
    
    # Create and start threads
    threads = []
    for i in range(num_threads):
        start_row = (n * i) // num_threads
        end_row = (n * (i + 1)) // num_threads
        thread = threading.Thread(target=multiply_rows, args=(start_row, end_row, array1, array2, array3, n))
        threads.append(thread)
        thread.start()
    
    # Wait for threads to complete
    for thread in threads:
        thread.join()

    end_time = time.time()
    execution_time = end_time - start_time

    # Conditional printing of the result
    print("Resulting Matrix:")
    if n <= 15:
        for row in array3:
            print(' '.join(map(str, row)))
    else:
        print(f"Matrix of size {n}x{n} created but too large to display.")

    # Save results
    with open("./report/data.csv", "a") as stats_file:
        stats_file.write(f"{os.path.basename(__file__)},{sys.argv[1]},{sys.argv[2]},{sys.argv[3]},{sys.argv[4]},{sys.argv[5]},{sys.argv[6]},{execution_time:.4f}\n")
    print(f"Statistics written to {stats_filename}")
