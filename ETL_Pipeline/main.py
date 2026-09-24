from etl.pipeline import extract_data, transform_data, load_data


def main():

    print("Starting ETL pipeline...")

    # Extract
    data = extract_data()
    print("Data extracted successfully.")

    # Transform
    df = transform_data(data)
    print("Data transformed successfully.")

    # Load
    load_data(df)
    print("Data loaded successfully.")

    print("ETL pipeline completed.")


if __name__ == "__main__":
    main()