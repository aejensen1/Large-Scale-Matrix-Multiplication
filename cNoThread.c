// Title: cNoThreads
// Author: Anders Jensen
// Description: Matrix Multiplication in c with no threading involved
// Version: 1.0 (02/27/2024)

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    printf("Running cNoThreads:\n\n");

    if (argc < 7) {
        fprintf(stderr, "Usage: %s <array_size> <num_threads> <num_cores> <job_name> <num_nodes> <ntasks_per_node>\n", argv[0]);
        return 1;
    }
    int n = atoi(argv[1]); // n = number of rows and columns

    // Check if n is valid
    if (n <= 0) {
        fprintf(stderr, "The number of rows/columns must be greater than zero.\n");
        return 1;
    }

    int array1[n][n];
    int array2[n][n];
    int array3[n][n];

    // Initialize elements to 1 for array1 and array2
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            array1[i][j] = 1;
            array2[i][j] = 1;
        }
    }

    // Timing multiplication
    clock_t start = clock();
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            array3[i][j] = 0;
            for (int k = 0; k < n; k++) {
                array3[i][j] += array1[i][k] * array2[k][j];
            }
        }
    }
    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;

    // Conditionally print the resulting matrix
    if (n <= 15) {
        printf("Resulting Matrix:\n");
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                printf("%d ", array3[i][j]);
            }
            printf("\n");
        }
    } else {
        printf("Matrix of size %dx%d created but too large to display.\n", n, n);
    }

    // Write statistics to file
    FILE *stats_file;
    char filename[100]; // Adjust the size as needed
    
    // Construct the filename with argv[4] appended
    sprintf(filename, "./output-statistics/%s_cNoThread_stats.txt", argv[4]); // Change the directory path as needed
    
    stats_file = fopen(filename, "w");
    if (stats_file != NULL) {
        fprintf(stats_file, "%s,%s,%s,%s,%s,%s,%s,%4444f", __FILE__, argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], time_spent);
        //fprintf(stats_file, "File name: %s\n", __FILE__);
        //fprintf(stats_file, "Matrix Size: %dx%d\n", n, n);
        //fprintf(stats_file, "Number of Threads: 1\n"); // It's a single-threaded program
        //fprintf(stats_file, "Execution Time: %f seconds\n", time_spent);
        fclose(stats_file);
    } else {
        perror("Unable to open the statistics file");
    }

    return 0;
}
