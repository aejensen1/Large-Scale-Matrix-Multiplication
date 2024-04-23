import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from mpl_toolkits.mplot3d import Axes3D

def generate_graphs(df):
    # Create directory if it doesn't exist
    os.makedirs('./report/images/', exist_ok=True)

    # Line graph
    plt.figure(figsize=(10, 6))
    sns.lineplot(data=df, x='array_size', y='time_spent', hue='file_type')
    plt.title('Line Graph')
    plt.xlabel('Array Size')
    plt.ylabel('Time Spent (s)')
    plt.legend(title='File Type')
    plt.savefig('./report/images/line_graph.png')  # Save the graph as PNG file
    plt.close()

    # line graph for c files only
    # Filter the DataFrame to include only specific file types
    filtered_df = df[df['file_type'].isin(['cOpenMP.c', 'cPThread.c', 'cNoThread.c'])]

    plt.figure(figsize=(10, 6))
    sns.lineplot(data=filtered_df, x='array_size', y='time_spent', hue='file_type')
    plt.title('Line Graph')
    plt.xlabel('Array Size')
    plt.ylabel('Time Spent (s)')
    plt.legend(title='File Type')
    plt.savefig('./report/images/c_line_graph.png')  # Save the graph as PNG file
    plt.close()

    # line graph for threaded c files only
    # Filter the DataFrame to include only specific file types
    filtered_df = df[df['file_type'].isin(['cOpenMP.c', 'cPThread.c'])]

    plt.figure(figsize=(10, 6))
    sns.lineplot(data=filtered_df, x='array_size', y='time_spent', hue='file_type')
    plt.title('Line Graph')
    plt.xlabel('Array Size')
    plt.ylabel('Time Spent (s)')
    plt.legend(title='File Type')
    plt.savefig('./report/images/threaded_c_line_graph.png')  # Save the graph as PNG file
    plt.close()

    # 3D box graph (example)
    fig = plt.figure(figsize=(10, 6))
    ax = fig.add_subplot(111, projection='3d')

    # Loop through unique file types to plot each one separately
    for file_type in df['file_type'].unique():
        subset_df = df[df['file_type'] == file_type]
        ax.scatter(subset_df['num_cores'], subset_df['array_size'], subset_df['time_spent'], label=file_type)

    ax.set_xlabel('Number of Cores')
    ax.set_ylabel('Array Size')
    ax.set_zlabel('Time Spent (s)')
    plt.title('3D Box Graph')
    plt.legend(title='File Type', bbox_to_anchor=(1.05, 1), loc='upper left')
    plt.tight_layout()  # Adjust layout to prevent overlap    
    plt.savefig('./report/images/3d_box_graph_v2.png')  # Save the graph as PNG file
    plt.close()

def main():
    # Read data from CSV
    df = pd.read_csv('./report/data.csv')  # Replace 'input.csv' with your CSV file path

    # Generate graphs
    generate_graphs(df)

if __name__ == "__main__":
    main()

