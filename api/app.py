# ==========================================
# Dependency
# ==========================================
import os
import sqlite3
from flask import Flask, jsonify, request
from flask_cors import CORS
import dbSetup

# ==========================================
# Set Up
# ==========================================
app = Flask(__name__)
CORS(app)

# ==========================================
# Uncomment the follow code to reset data.db
# ==========================================
if os.path.exists('data.db'):
    os.remove('data.db')
    dbSetup.setupSQLiteDB()

sqlite3.connect('data.db')

# ==========================================
# SQL Connector - 1. Student
# ==========================================

def JsonifyQueryRecords(sqlScript, labels, variableData=[]):
    students = []
    with sqlite3.connect('data.db') as dbconn_local:
        try:
            c = dbconn_local.cursor()
            c.execute(sqlScript, variableData)
            records = c.fetchall()

            for row in records:
                student = {}
                labelCounter = 0
                for label in labels:
                    student[label] = row[labelCounter]
                    labelCounter = labelCounter + 1
                students.append(student)
            c.close()
            return jsonify(students)
        except sqlite3.Error as e:
            print(e)

# 1.1 Students - Get All Students

sql_get_all_students = """ 
    SELECT * FROM student; 
"""

@app.route('/get-all-students', methods=['GET'])
def getAllStudents():
    labels = ["id", "student_number", "first_name", "last_name", "birthday", "gender"]
    return JsonifyQueryRecords(sql_get_all_students, labels)

# 1.2 Students - Get Student By ID

sql_get_student_by_id = """ 
    SELECT * FROM student WHERE id = ?;
"""
@app.route('/get-student-by-id', methods=['GET'])
def getStudentById():
    studentId = request.args.get('id')
    labels = ["id", "student_number", "first_name", "last_name", "birthday", "gender"]
    return JsonifyQueryRecords(sql_get_student_by_id, labels, [studentId])

# 1.3 Students - Get Student By Subject Code

sql_get_student_by_subject_code = """ 
SELECT
	student.student_number,
	student.first_name,
	student.last_name,
	student.gender,
	student.birthday,
	subject.subject_code,
	subject.subject_name
FROM enrolment
INNER join subject on enrolment.subject_id = subject.id
INNER join registration on enrolment.registration_id = registration.id
INNER join student on registration.student_id = student.id
WHERE subject_code=?;
""" 
@app.route('/get-student-by-subject-code', methods=['GET'])
def getStudentBySubjectCode():
    subjectCode = request.args.get('code')
    labels = ["studentNumber", "firstName", "lastName", "gender", "birthday", "subjectCode", "subjectName"]
    return JsonifyQueryRecords(sql_get_student_by_subject_code, labels, [subjectCode])

# ==========================================
# Step to grade students
# 1. Teacher query sessions info based on subject code, day, and teacher id
# 2. Query all students and relevant grade info based on session id
# 3. Grades are updated to DB
# ==========================================

sql_get_session_by_subjectcode_day_teacherid = """ 
SELECT 
	subject.subject_code,
	subject.subject_name,
	subject_periods.day,
	subject_periods.start_time,
	subject_periods.end_time
FROM 
	session
	INNER JOIN subject_periods on session.period_id = subject_periods.id
	INNER JOIN subject on subject_periods.subject_id = subject.id
WHERE
	subject_code = "ENG101" AND
	day = "Monday"
;
""" 

sql_get_session_full_table = """
SELECT 
	student.student_number,
	student.first_name,
	student.last_name,
	student.gender,
	subject.subject_code,
	subject.subject_name,
	subject_periods.day,
	subject_periods.start_time,
	subject_periods.end_time,
    session.session_date
FROM 
	session
	INNER JOIN subject_periods on session.period_id = subject_periods.id
	INNER JOIN subject on subject_periods.subject_id = subject.id
	INNER JOIN enrolment on enrolment.subject_id = subject.id
	INNER JOIN registration on enrolment.registration_id = registration.id
	INNER JOIN student on registration.student_id = student.id
WHERE
	subject_code = "ENG101" AND
	day = "Monday" AND
	session_date = "19/2/2019"
;
"""

sql_test = """ 
SELECT 
	student.student_number,
	student.first_name,
	student.last_name,
	subject.subject_code,
	session.session_date,
	criterion.name,
	grade.grade
FROM 
	session
	INNER JOIN subject_periods on session.period_id = subject_periods.id
	INNER JOIN subject on subject_periods.subject_id = subject.id
	INNER JOIN enrolment on enrolment.subject_id = subject.id
	INNER JOIN registration on enrolment.registration_id = registration.id
	INNER JOIN student on registration.student_id = student.id
	INNER JOIN grade on session.id = grade.session_id AND grade.enrolment_id = enrolment.id
	INNER JOIN criterion on grade.criteria_id = criterion.id
WHERE
	subject_code = "ENG101" AND
	day = "Monday" AND
	session_date = "19/2/2019"
ORDER BY student.student_number
;
"""

if __name__ == '__main__':
    app.run(debug=True)
