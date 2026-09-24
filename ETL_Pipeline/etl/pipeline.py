import requests
import pandas as pd


API_URL = "https://jsonplaceholder.typicode.com/users"


# EXTRACT
def extract_data():
    response = requests.get(API_URL)
    response.raise_for_status()
    return response.json()


# TRANSFORM
def transform_data(data):
    df = pd.DataFrame(data)

    # Keep only required columns
    df = df[["id", "name", "username", "email"]]

    # Convert names to uppercase
    df["name"] = df["name"].str.upper()

    return df


# LOAD
def load_data(df, filename="data/users.csv"):
    df.to_csv(filename, index=False)