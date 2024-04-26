# Large-Scale-Matrix-Multiplication

Author: Anders Jensen
Date: 4-22-2024

Matrix Multiplication Developed to work on a significant number of cores using batch jobs

This is a project that is supposed to demonstrate how a greater amount of processing power and resources impacts the speed of basic matrix multiplication of arrays with varying sizes.

--------------------------------------------------------------

You can find the final report for this project [here](https://github.com/aejensen1/Large-Scale-Matrix-Multiplication/blob/main/report/FinalReport.pdf)

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

Arrays were to have an equal amount of columns as rows (denoted as array_size) and to be filled with 1's.

--------------------------------------------------------------

This set of programs were first to be implemented on a PC, and then were to be used on a cluster computer that had 128 cores. Batch jobs were used on the larger computer to ensure proper allocation of resources.

A batch job script generally looked like the following:
```
#!/bin/bash
#SBATCH --job-name=$job_name
#SBATCH --nodes=$num_nodes
#SBATCH --ntasks-per-node=$ntasks_per_node
#SBATCH --cpus-per-task=$num_cores
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load gcc

./compiled-programs/$program_type $array_size $num_threads $num_cores $job_name $num_nodes $ntasks_per_node
EOF
```

Due to the need to run hundreds of unique batch jobs with varying values for each resource, I decided it to be best to automate the creating of batch jobs. This is where the create-batch-job.sh script comes in. On the user side this script is simple. Just enter the following fields:

```
bash create-bash-job.sh <file_type> <array_size> <num_threads> <job_name> <num_nodes> <ntasks-per-node>
```

In the program, it will take valid values for each argument. It will take the program that is provided and set up compilation along with adding all the specified resources to the batch job. Compiled programs are named uniquely to avoid clashing when executing and are sent into the compiled-programs directory. This can be cleaned up periodically. It then executes the .sbatch file created and it goes into a "PENDING" state on the server if all the inputs are valid. Once the job is complete, the data from executing the program is appended to the end of ./report/data.csv file. Really, the only new data is the time_spent executing the matrix multiplication, but this is important for testing the speed of the server.

To overcome the issue of running many of these scripts with different variables was to create the bulk-batch-jobs.sh file in combination with jobs-queue.csv. To load in a bulk set of requests, all that must be done is to put the arguments in csv format into the jobs-queue.csv and then run bulk-batch-jobs.csv. An easy way to do this is to put the data into excel, save as csv, and open the csv in notepad. Then you can copy the text into jobs-queue.csv. Example csv formatting is below:

```
cOpenMP.c,100,20,job500,1,1
cPThread.c,100,20,job501,1,1
pythonWithThreads.py,100,20,job502,1,1
cOpenMP.c,200,20,job503,1,1
cPThread.c,200,20,job504,1,1
pythonWithThreads.py,200,20,job505,1,1
```
The bulk-batch-jobs.sh file is set to use a short random amount of time between submitting batch jobs to attempt to avoid the submission looking like a DoS (Denial of Service) attack. This code can be removed if desired.

--------------------------------------------------------------

A final report was generated detailing the similarities and differences in performance metrics between different languages and resource usages.

python scripts, such as graph-generator.py were run to create good graphs that could help analyze the data collected. Once graphs were generated, they could be put into a word document and annotated to develop a final report.
