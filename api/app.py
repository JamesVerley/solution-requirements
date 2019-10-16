import os
import sqlite3
from flask import Flask, jsonify, request
from sqlconnector import *


app = Flask(__name__)

# if os.path.exists('data.db'):
#     os.remove('data.db')

dbconn = sqlite3.connect('data.db')

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
        c.execute(create_student_sql, ("s001", "Bob", "Doe", "01/04/2000", "M", "1"))
        conn.commit()
        c.close()
    except sqlite3.Error as e:
        print(e)

if dbconn is not None:
    create_table(dbconn, sql_create_students_table)
    addStudent(dbconn, sql_create_students_entry)
else:
    print("Error! cannot create the database connection.")

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
                student["student_number"] = row[1]
                student["first_name"] = row[2]
                student["last_name"] = row[3]
                student["birthday"] = row[4]
                student["gender"] = row[5]
                student["year_group_id"] = row[6]
                students.append(student)
            c.close()
            return students
        except sqlite3.Error as e:
            print(e)


def new_student(studentNum, firstName, lastName, dob, gender, yearGroupId):
    with sqlite3.connect('data.db') as dbconn_local:
        try:
            c = dbconn_local.cursor()
            c.execute(sql_create_students_entry, (studentNum, firstName, lastName, dob, gender, yearGroupId))
            dbconn_local.commit()
            c.close()
        except sqlite3.Error as e:
            print(e)


@app.route('/', methods=['GET'])
def get_tasks():
    return jsonify({'students': getStudent()})


@app.route('/addstudent', methods=['POST'])
def add_student():
    content = request.get_json()
    new_student(content['student_num'], content['first_name'], content['last_name'], content['birthday'], content['gender'], content['year_group_id'])
    return jsonify(content)

def getsubjectperiodbysubject_id(subject_id):
    periods = []
    with sqlite3.connect('data.db') as dbconn_local:
        try:
            c = dbconn_local.cursor()
            c.execute(sql_get_subject_periods_by_subject_id, (subject_id))
            records = c.fetchall()

            for row in records:
                period = {}
                period["id"] = row[0]
                period["start_time"] = row[1]
                period["end_time"] = row[2]
                period["day"] = row[3]
                period["subject_id"] = row[4]
                periods.append(period)
            c.close()
            return periods
        except sqlite3.Error as e:
            print(e)

@app.route('/addclass', methods=['POST'])
def add_class():
    return

@app.route('/addsubject', methods=['POST'])
def add_subject():
    return

@app.route('/addteacher', methods=['POST'])
def add_teacher():
    return

@app.route('/addyeargroup', methods=['POST'])
def add_yeargroup():
    return

@app.route('/markstudent', methods=['POST'])
def mark_student():
    return

def getSubjectById():
    return

def getPeriodsBySubjetId():
    return

@app.route('/getsubjectperiodsbysubject_id', methods=['GET'])
def getsubjectperiodsbysubject_id():
    subject_id = request.args.get('subject_id')
    records = getsubjectperiodbysubject_id(subject_id)
    return jsonify({"periods": records})

sampleStudent = {
  "id": 1,
  "student_num": "s001",
  "first_name": "Bob",
  "last_name": "Doe",
  "birthday": "01/04/2000",
  "gender": "m",
  "year_group_id": "1",
}

sampleYearGroup = {
  "id": 1,
  "year_run": "2018",
  "year_level": "12"
}

@app.route('/sample/student', methods=['GET'])
def get_samplestudent():
    return jsonify({'student': sampleStudent})

@app.route('/sample/yeargroup', methods=['GET'])
def get_sampleyeargroup():
    return jsonify({'yeargroup': sampleYearGroup})

# ====================================
#  Get and Return All Students in School

# ====================================
#  Get and Return All Students by Year Group

# ====================================
#  Get and Return All Students by Subject

# ====================================
#  Get and Return Student by Student Number

# ====================================
#  Get and Return Student by Student id

# ====================================
#  Get and Return All Year Groups

# ====================================
#  Get and Return All Subjects

# ====================================
#  Enrol Student to School

# ====================================
#  Enrol Student to Year Group

# ====================================
#  Enrol Student to Subject


if __name__ == '__main__':
    app.run(debug=True)
