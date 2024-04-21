import os
import time
import shutil

def create_header(filename):
    with open(filename, 'w') as f:
        f.write("file_type,array_size,num_threads,num_cores,job_name,num_nodes,ntasks_per_node,time_spent\n")

def process_file(source_dir, dest_dir):
    files = os.listdir(source_dir)
    for file in files:
        if file.endswith('.txt'):  # Adjust file extension as needed
            source_file = os.path.join(source_dir, file)
            dest_file = os.path.join(dest_dir, file)
            shutil.move(source_file, dest_file)
            with open(dest_file, 'r') as f:
                lines = f.readlines()
                if len(lines) > 0:
                    with open(dest_dir + "/data.csv", 'a') as output_file:  # Adjust output file name
                        for line in lines:
                            output_file.write(line)
            os.remove(dest_file)

def monitor_directory(source_dir, dest_dir):
    print("Monitoring directory for new files...")
    while True:
        process_file(source_dir, dest_dir)
        time.sleep(1)

def main():
    source_dir = './output-statistics'  # Replace with your source directory
    dest_dir = './report'  # Replace with your destination directory

    # Create the output file and add the header if it doesn't exist
    output_file = dest_dir + "/data.csv"  # Adjust output file name
    if not os.path.exists(output_file):
        create_header(output_file)

    # Start monitoring the source directory for new files
    monitor_directory(source_dir, dest_dir)

if __name__ == "__main__":
    main()

