import pandas as pd


def analyze_transactions():
    df = pd.read_csv("transactions.csv")

    print("\n===== TRANSACTION DATA =====")
    print(df)

    print("\n===== FIRST 5 TRANSACTIONS =====")
    print(df.head())

    print("\n===== BASIC INFORMATION =====")
    print(df.info())

    print("\n===== TOTAL TRANSACTIONS =====")
    print(len(df))

    print("\n===== TOTAL TRANSACTION AMOUNT =====")
    print(df["amount"].sum())

    print("\n===== AVERAGE TRANSACTION AMOUNT =====")
    print(df["amount"].mean())

    print("\n===== TRANSACTION TYPE SUMMARY =====")
    print(df.groupby("type")["amount"].agg(["count", "sum", "mean"]))

    print("\n===== ACCOUNT-WISE TRANSACTION SUMMARY =====")
    print(
        df.groupby("account_holder")["amount"]
        .agg(["count", "sum", "mean"])
    )


if __name__ == "__main__":
    analyze_transactions()