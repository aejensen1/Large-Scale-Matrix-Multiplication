# Large-Scale-Matrix-Multiplication

Author: Anders Jensen
Date: 4-19-2024

Matrix Multiplication Developed to work on a significant number of cores using batch jobs

This is a project for operating systems class that is supposed to demonstrate the difference 

--------------------------------------------------------------

The requirements for the assignment were as follows:
Implement Matrix multiplication using:
1. Python no threads
2. Python with threads
3. C no threads
4. C with POSIX threads (compile with -lpthread)
5. with openMP (compile with -fopenmp)
The program should read in the size of the array and generate it at random. 
Compare the time of the different implementations for different array sizes e.g. 10, 50, 100, 500....., experiment with the number of threads

--------------------------------------------------------------

This set of programs were first to be implemented on a PC, and then were to be used on a cluster computer that had 128 cores. Batch jobs would be used on the larger computer to ensure proper allocation of resources.
I ended up setting the array sizes, cores used, nodes, and other stats manually for better comparison between programs.
A final report was generated detailing the similarities and differences in performance metrics between different languages and resource usages.
