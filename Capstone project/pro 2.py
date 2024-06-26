import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Define the file path
file_path = "E:/Data handling/zomato.csv"

# List of encodings to try
encodings = ['utf-8', 'latin1', 'ISO-8859-1', 'cp1252']

# Function to try reading the file with different encodings
def read_csv_with_encodings(file_path, encodings):
    for encoding in encodings:
        try:
            dataframe = pd.read_csv(file_path, encoding=encoding)
            print(f"File loaded successfully with encoding: {encoding}")
            return dataframe
        except UnicodeDecodeError as e:
            print(f"Failed to read file with encoding {encoding}: {e}")
    raise Exception("Failed to read file with all specified encodings")

# Load the dataset
dataframe = read_csv_with_encodings(file_path, encodings)

# Display the column names to verify
print("Column names in the dataframe:", dataframe.columns)

# Display the first few rows to verify it's loaded correctly
print(dataframe.head())

# Function to handle 'Aggregate rating' column
def handleRating(value):
    try:
        return float(value)
    except ValueError:
        return np.nan

# Apply handleRating function to 'Aggregate rating' column
dataframe['Aggregate rating'] = dataframe['Aggregate rating'].apply(handleRating)
print(dataframe.head())

# Print information about the dataframe
dataframe.info()

# Countplot for 'Rating text'
if 'Rating text' in dataframe.columns:
    plt.figure(figsize=(10, 6))
    sns.countplot(x=dataframe['Rating text'])
    plt.xlabel("Rating Text")
    plt.title("Count of Ratings by Text")
    plt.xticks(rotation=90)
    plt.show()
else:
    print("Column 'Rating text' not found in the dataframe.")

# Group by 'Rating text' and sum 'Votes'
if 'Rating text' in dataframe.columns and 'Votes' in dataframe.columns:
    grouped_data = dataframe.groupby('Rating text')['Votes'].sum()
    result = pd.DataFrame({'Votes': grouped_data})

    # Plot votes vs rating text
    plt.figure(figsize=(10, 6))
    plt.plot(result, c="green", marker="o")
    plt.xlabel("Rating Text")
    plt.ylabel("Votes")
    plt.title("Votes vs Rating Text")
    plt.xticks(rotation=90)
    plt.show()
else:
    print("Columns 'Rating text' or 'Votes' not found in the dataframe.")

# Find restaurant(s) with maximum votes
if 'Votes' in dataframe.columns and 'Restaurant Name' in dataframe.columns:
    max_votes = dataframe['Votes'].max()
    restaurant_with_max_votes = dataframe.loc[dataframe['Votes'] == max_votes, 'Restaurant Name']
    print("Restaurant(s) with the maximum votes:")
    print(restaurant_with_max_votes)
else:
    print("Columns 'Votes' or 'Restaurant Name' not found in the dataframe.")

# Countplot for 'Has Online delivery'
if 'Has Online delivery' in dataframe.columns:
    plt.figure(figsize=(10, 6))
    sns.countplot(x=dataframe['Has Online delivery'])
    plt.xlabel("Has Online Delivery")
    plt.title("Count of Restaurants with Online Delivery")
    plt.show()
else:
    print("Column 'Has Online delivery' not found in the dataframe.")

# Histogram of 'Aggregate rating' column
if 'Aggregate rating' in dataframe.columns:
    plt.figure(figsize=(10, 6))
    plt.hist(dataframe['Aggregate rating'].dropna(), bins=5)
    plt.title("Distribution of Aggregate Ratings")
    plt.xlabel("Rating")
    plt.ylabel("Frequency")
    plt.show()
else:
    print("Column 'Aggregate rating' not found in the dataframe.")

# Countplot for 'Average Cost for two'
if 'Average Cost for two' in dataframe.columns:
    plt.figure(figsize=(10, 6))
    sns.countplot(x=dataframe['Average Cost for two'])
    plt.xlabel("Average Cost (for two people)")
    plt.title("Count of Restaurants by Average Cost for Two")
    plt.xticks(rotation=90)
    plt.show()
else:
    print("Column 'Average Cost for two' not found in the dataframe.")

# Boxplot of 'Aggregate rating' vs 'Has Online delivery'
if 'Has Online delivery' in dataframe.columns and 'Aggregate rating' in dataframe.columns:
    plt.figure(figsize=(10, 6))
    sns.boxplot(x='Has Online delivery', y='Aggregate rating', data=dataframe)
    plt.title("Aggregate Rating vs Online Delivery")
    plt.show()
else:
    print("Columns 'Has Online delivery' or 'Aggregate rating' not found in the dataframe.")

# Pivot table and heatmap
if 'Rating text' in dataframe.columns and 'Has Online delivery' in dataframe.columns:
    pivot_table = dataframe.pivot_table(index='Rating text', columns='Has Online delivery', aggfunc='size', fill_value=0)
    plt.figure(figsize=(10, 8))
    sns.heatmap(pivot_table, annot=True, cmap="YlGnBu", fmt='d')
    plt.title("Heatmap of Rating Text vs Online Delivery")
    plt.xlabel("Online Delivery")
    plt.ylabel("Rating Text")
    plt.show()
else:
    print("Columns 'Rating text' or 'Has Online delivery' not found in the dataframe.")
