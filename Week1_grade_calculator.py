import csv
students = {}
subjects = ("Python", "DBMS", "OS")
def get_grade(avg):
    if avg >= 90:
        return "A+"
    elif avg >= 80:
        return "A"
    elif avg >= 70:
        return "B"
    elif avg >= 60:
        return "C"
    elif avg >= 50:
        return "D"
    else:
        return "F"
def add_student():
    name = input("Enter student name: ")
    name = name.strip().title()
    marks = []
    for subject in subjects:
        while True:
            try:
                mark = float(input("Enter marks in " + subject + ": "))

                if mark >= 0 and mark <= 100:
                    marks.append(mark)
                    break
                else:
                    print("Enter marks between 0 and 100")

            except ValueError:
                print("Please enter a number")

    total = sum(marks)
    average = total / len(marks)
    grade = get_grade(average)
    students[name] = {
        "marks": marks,
        "total": total,
        "average": average,
        "grade": grade
    }
    print("Student added successfully")
def display_students():
    if len(students) == 0:
        print("No students found")
        return

    for name in students:
        print("\nName:", name)
        print("Marks:", students[name]["marks"])
        print("Total:", students[name]["total"])
        print("Average:", round(students[name]["average"], 2))
        print("Grade:", students[name]["grade"])
def show_grades():
    grades = set()
    for student in students.values():
        grades.add(student["grade"])
    print("Different grades:", grades)
def save_file():
    try:
        file = open("students.txt", "w")
        for name in students:
            data = students[name]
            file.write(
                name + " " +
                str(data["total"]) + " " +
                str(data["average"]) + " " +
                data["grade"] + "\n"
            )
        file.close()
        print("Data saved in students.txt")
    except:
        print("Error while saving file")
    finally:
        print("File operation completed")
def save_csv():
    try:
        file = open("students.csv", "w", newline="")
        writer = csv.writer(file)
        writer.writerow(["Name", "Total", "Average", "Grade"])
        for name in students:
            data = students[name]
            writer.writerow([
                name,
                data["total"],
                data["average"],
                data["grade"]
            ])
        file.close()
        print("Data saved in students.csv")
    except:
        print("Error while saving CSV file")
    finally:
        print("CSV operation completed")
while True:
    print("\n----- Grade Calculator -----")
    print("1. Add Student")
    print("2. Display Students")
    print("3. Show Grades")
    print("4. Save Text File")
    print("5. Save CSV File")
    print("6. Exit")
    try:
        choice = int(input("Enter your choice: "))
        if choice == 1:
            add_student()
        elif choice == 2:
            display_students()
        elif choice == 3:
            show_grades()
        elif choice == 4:
            save_file()
        elif choice == 5:
            save_csv()
        elif choice == 6:
            print("Program ended")
            break
        else:
            print("Invalid choice")
    except ValueError:
        print("Enter a valid number")
    finally:
        print("Done")

