from bank_account import BankAccount


def main():
    account = BankAccount(
        "ACC1001",
        "Arifa",
        10000
    )

    print("===== OOP BANK ACCOUNT =====")
    print(f"Account Holder: {account.account_holder}")
    print(f"Account Number: {account.account_number}")

    while True:
        print("\n===== MENU =====")
        print("1. Deposit")
        print("2. Withdraw")
        print("3. Check Balance")
        print("4. Transaction History")
        print("5. Exit")

        choice = input("Enter your choice: ")

        if choice == "1":
            amount = float(input("Enter deposit amount: "))
            account.deposit(amount)

        elif choice == "2":
            amount = float(input("Enter withdrawal amount: "))
            account.withdraw(amount)

        elif choice == "3":
            account.check_balance()

        elif choice == "4":
            account.show_transactions()

        elif choice == "5":
            print("Thank you for using the banking system.")
            break

        else:
            print("Invalid choice. Please try again.")


if __name__ == "__main__":
    main()