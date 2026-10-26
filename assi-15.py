"""1.
Install the sqlite3 module in Python and write a script to create a new database called foodie.db with a table Restaurants (id, name, cuisine, rating)."""


# import mysql.connector
# from mysql.connector import Error

try:
    # Connect to MySQL Server
    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password="*********"
    )

    if connection.is_connected():
        print("Successfully connected to MySQL!")

        # Create a cursor to execute SQL commands
        cursor = connection.cursor()

        # Create the database
        cursor.execute("CREATE DATABASE IF NOT EXISTS sql_cte_practice")

        print("Database created successfully!")

        # Show all databases
        cursor.execute("SHOW DATABASES")

        print("\nAvailable databases:")

        for database in cursor.fetchall():
            print(database[0])

except Error as e:
    print("Error:", e)

finally:
    # Close the cursor and connection safely
    if "cursor" in locals() and cursor:
        cursor.close()

    if "connection" in locals() and connection.is_connected():
        connection.close()
        print("\nMySQL connection closed.")


"""Q.2
Using sqlite3 in Python, insert three sample restaurants into the Restaurants table in foodie.db and write a query to fetch all restaurants with a rating above 4.0, then print their names.
"""


import sqlite3

# 1. Connect to the database (creates foodie.db if it doesn't exist)
connection = sqlite3.connect("foodie.db")

cursor = connection.cursor()


cursor.execute("""
    CREATE TABLE IF NOT EXISTS Restaurants (
        restaurant_id INTEGER PRIMARY KEY,
        name TEXT,
        rating REAL
    )
""")


restaurants = [
    (1, "Spice Garden", 4.5),
    (2, "Pizza Corner", 3.8),
    (3, "Dosa Delight", 4.7)
]

cursor.executemany("""
    INSERT OR IGNORE INTO Restaurants (restaurant_id, name, rating)
    VALUES (?, ?, ?)
""", restaurants)


connection.commit()


cursor.execute("""
    SELECT name
    FROM Restaurants
    WHERE rating > 4.0
""")


results = cursor.fetchall()

print("Restaurants with a rating above 4.0:")

for restaurant in results:
    print(restaurant[0])

connection.close()



"""**3.**
Write Python code to load all rows from the Restaurants table in foodie.db into a Pandas DataFrame and display the top 2 rows using DataFrame.head()."""

import pandas as pd
connection = sqlite3.connect("foodie.db")
df = pd.read_sql_query("SELECT * FROM Restaurants", connection)
print(df.head(2))
connection.close()





"""4.
Add a new column 'delivery_charge' to your DataFrame, setting it to 50 for all restaurants, and then calculate a new column 'final_rating' as rating + (0.1 if cuisine is 'Italian').<br><br><em><strong>Hint:</strong> Use DataFrame.apply() or a lambda function for the conditional logic.</em>

"""
import sqlite3
import pandas as pd

connection = sqlite3.connect("foodie.db")

df = pd.read_sql_query("SELECT * FROM Restaurants", connection)

df["delivery_charge"] = 50


df["final_rating"] = df.apply(
    lambda row: row["rating"] + 0.1
    if row["cuisine"] == "Italian"
    else row["rating"],
    axis=1
)

print(df)
connection.close()



"""5.
Automate a daily summary: Write a Python script that connects to foodie.db, fetches all restaurants with rating above 4.5, loads them into a DataFrame, and saves the result as a CSV file named top_rated_restaurants.csv."""



try:
    
    connection = sqlite3.connect("foodie.db")
    print("Connected to foodie.db successfully!")

    
    query = """
        SELECT *
        FROM Restaurants
        WHERE rating > 4.5
    """

    
    df = pd.read_sql_query(query, connection)


    df.to_csv("top_rated_restaurants.csv", index=False)

    
    print("\nTop-rated restaurants:")
    print(df)

    print("\nData saved to top_rated_restaurants.csv")

except sqlite3.Error as error:
    print("Database error:", error)

finally:
    if "connection" in locals():
        connection.close()
        print("Database connection closed.")