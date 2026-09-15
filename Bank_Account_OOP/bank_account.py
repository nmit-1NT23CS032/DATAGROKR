class BankAccount:
    def __init__(self, account_number, account_holder, balance=0):
        self.account_number = account_number
        self.account_holder = account_holder
        self.balance = balance
        self.transactions = []

    def deposit(self, amount):
        if amount <= 0:
            print("Deposit amount must be greater than 0.")
            return

        self.balance += amount

        self.transactions.append({
            "type": "Deposit",
            "amount": amount
        })

        print(f"₹{amount:.2f} deposited successfully.")

    def withdraw(self, amount):
        if amount <= 0:
            print("Withdrawal amount must be greater than 0.")
            return

        if amount > self.balance:
            print("Insufficient balance.")
            return

        self.balance -= amount

        self.transactions.append({
            "type": "Withdrawal",
            "amount": amount
        })

        print(f"₹{amount:.2f} withdrawn successfully.")

    def check_balance(self):
        print(f"Current balance: ₹{self.balance:.2f}")

    def show_transactions(self):
        if not self.transactions:
            print("No transactions yet.")
            return

        print("\nTransaction History:")

        for transaction in self.transactions:
            print(
                f"{transaction['type']}: "
                f"₹{transaction['amount']:.2f}"
            )