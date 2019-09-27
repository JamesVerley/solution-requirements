import os
import sqlite3
from flask import Flask, jsonify, request


app = Flask(__name__)

# if os.path.exists('data.db'):
#     os.remove('data.db')

dbconn = sqlite3.connect('data.db')


sql_create_students_table = """ 
    CREATE TABLE IF NOT EXISTS students (
        student_id      integer     PRIMARY KEY,
        student_name    text(50),
        student_age     integer,
        student_class   TEXT(50)    DEFAULT 'A'); 
"""


sql_create_students_entry = """ 
    INSERT INTO students (
        student_name,
        student_age,
        student_class 
    ) VALUES (?, ?, ?); 
"""

sql_get_students_entry = """ 
    SELECT * FROM students; 
"""


def create_table(conn, create_table_sql):
    try:
        c = conn.cursor()
        c.execute(create_table_sql)
        c.close()
    except sqlite3.Error as e:
        print(e)


def addStudent(conn, create_student_sql):
    try:
        c = conn.cursor()
        c.execute(create_student_sql, (1, "Tom", 13, "A"))
        conn.commit()
        c.close()
    except sqlite3.Error as e:
        print(e)


def getStudent():
    students = []
    with sqlite3.connect('data.db') as dbconn_local:
        try:
            c = dbconn_local.cursor()
            c.execute(sql_get_students_entry)
            records = c.fetchall()

            for row in records:
                student = {}
                student["id"] = row[0]
                student["name"] = row[1]
                student["age"] = row[2]
                student["class"] = row[3]
                students.append(student)
            c.close()
            return students
        except sqlite3.Error as e:
            print(e)


if dbconn is not None:
    create_table(dbconn, sql_create_students_table)
    addStudent(dbconn, sql_create_students_entry)

else:
    print("Error! cannot create the database connection.")


def new_student(name, age, classname):
    with sqlite3.connect('data.db') as dbconn_local:
        try:
            c = dbconn_local.cursor()
            c.execute(sql_create_students_entry, (name, age, classname))
            dbconn_local.commit()
            c.close()
        except sqlite3.Error as e:
            print(e)


@app.route('/', methods=['GET'])
def get_tasks():
    return jsonify({'students': getStudent()})


@app.route('/add_student_record', methods=['POST'])
def add_student_record():
    content = request.get_json()
    new_student(content['name'], content['age'], content['class'])
    return jsonify(content)


if __name__ == '__main__':
    app.run(debug=True)
