import json
def save_task(task):
    with open("task.json", "w") as file:
        json.dump(task, file)

def load_task():
    try:
        with open("task.json", "r") as file:
            return json.load(file)
    except FileNotFoundError:
        return []            

import tkinter as tk
from tkcalendar import Calendar

def choose_date():
    selected_date = None

    def get_date():
        nonlocal selected_date
        selected_date = cal.get_date()
        root.destroy()

    root = tk.Tk()
    cal = Calendar(root, selectmode='day')
    cal.pack(pady=20)
    tk.Button(root, text="Select Date", command=get_date).pack(pady=20)
    root.mainloop()
    return selected_date
           

task=load_task()
while True:
    print("to do list menu")
    print("---------------")
    print("1. view tasks")
    print("2. add task")
    print("3. edit task detail")
    print("4. mark task as done")
    print("5. delete task")
    print("6. exit")
    choice=input("Enter action of choice(1-6): ")

    if choice=="1":
        if not task:
            print("Menu empty!\n📂")
        else:
            print("\nTask list:")
            for i, t in enumerate(task, start=1):
                print(f"{i}. {t['title']} | Done:{t['done']} | Deadline: {t['deadline']}")

    elif choice=="2":
        new_task=input("Add new task: ")
        task.append({
            "title": new_task,
            "deadline": None,
            "notes": "",
            "mute": False,
            "done": False
        })
        save_task(task)
        print(f"Task '{new_task}' added to list.")

    elif choice=="3":
        if not task:
            print("Not edited!")
            continue
        for i, t in enumerate(task, start=1):
            print(f"{i}. {t['title']}")
        index=int(input("Enter task number to edit: "))-1
        if 0<=index <len(task):
            new_task=input("Enter new task description: ")
            task[index]["title"]=new_task

            print("Edit deadline?(Y/N): ")
            if input().upper()=="Y":
                d= choose_date()
                if d:
                    task[index]["deadline"]=d
                else:
                    print("Deadline unchanged.")

            print("Add notes?(Y/N): ")
            if input().upper()=="Y":
                task[index]["notes"]=input("Notes: ")

            save_task(task)
            print("Task Updated!")    

        else:        
            print("No changes made!")
    
    elif choice=="4":
        if not task:
            print("Not done!")
            continue
        for i, t in enumerate(task, start=1):
            print(f"{i}. {t['title']}")

        index=int(input("Enter task number to mark as done: "))-1
        if 0<=index<len(task):
            task[index]["done"]=True
            save_task(task)
            print(f"'{task[index]['title']}' done!")
        else:
            print("Task not done.")    

    elif choice=="5":
        if not task:
            print("Not deleted!")
            continue
        for i, t in enumerate(task, start=1):
            print(f"{i}. {t['title']}")

        index=int(input("Enter task number to delete: "))-1
        if 0<=index<len(task):
            deleted=task.pop(index)
            save_task(task)
            print(f"Task '{deleted['title']}' deleted")
        else:
            print("Task not deleted.")    

    elif choice=="6":
        leave=input("Exit task menu? (Y/N): ")
        if leave.upper()=="Y":
            save_task(task)
            print("Goodbye!\n🚶‍♀️")
            break
        else:
            print("We love your company too!\n💞")
            save_task(task)
          

           