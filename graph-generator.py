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
    sns.lineplot(data=df, x='array_size', y='num_threads', hue='file_type')
    plt.title('Line Graph')
    plt.xlabel('Array Size')
    plt.ylabel('Number of Threads')
    plt.legend(title='File Type')
    plt.savefig('./report/images/line_graph.png')  # Save the graph as PNG file
    plt.close()

    # Bar graph
    plt.figure(figsize=(10, 6))
    sns.barplot(data=df, x='num_nodes', y='array_size', hue='job_name', ci=None)
    plt.title('Bar Graph')
    plt.xlabel('Number of Nodes')
    plt.ylabel('Array Size')
    plt.legend(title='Job Name', loc='upper right')
    plt.savefig('./report/images/bar_graph.png')  # Save the graph as PNG file
    plt.close()

    # 3D box graph
    fig = plt.figure(figsize=(10, 6))
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(df['num_nodes'], df['array_size'], df['num_threads'], c='r', marker='o')
    ax.set_xlabel('Number of Nodes')
    ax.set_ylabel('Array Size')
    ax.set_zlabel('Number of Threads')
    plt.title('3D Box Graph')
    plt.savefig('./report/images/3d_box_graph.png')  # Save the graph as PNG file
    plt.close()

    # Scatter plot
    plt.figure(figsize=(10, 6))
    sns.scatterplot(data=df, x='num_cores', y='num_nodes', hue='job_name')
    plt.title('Scatter Plot')
    plt.xlabel('Number of Cores')
    plt.ylabel('Number of Nodes')
    plt.legend(title='Job Name', loc='upper left')
    plt.savefig('./report/images/scatter_plot.png')  # Save the graph as PNG file
    plt.close()

    # Radar chart (example)
    categories = list(df['file_type'].unique())
    values = df.groupby('file_type').mean().values.flatten().tolist()
    values += values[:1]
    
    angles = [n / float(len(categories)) * 2 * 3.14159 for n in range(len(categories))]
    angles += angles[:1]
    
    plt.figure(figsize=(10, 6))
    ax = plt.subplot(111, polar=True)
    plt.xticks(angles[:-1], categories, color='grey', size=8)
    ax.plot(angles, values)
    ax.fill(angles, values, 'blue', alpha=0.1)
    plt.title('Radar Chart')
    plt.savefig('./report/images/radar_chart.png')  # Save the graph as PNG file
    plt.close()

def main():
    # Read data from CSV
    df = pd.read_csv('input.csv')  # Replace 'input.csv' with your CSV file path

    # Calculate num_cores
    df['num_cores'] = df['num_threads'] / 2

    # Generate graphs
    generate_graphs(df)

if __name__ == "__main__":
    main()

