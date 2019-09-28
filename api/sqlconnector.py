# ====================================
#  Year Group Table
# ====================================

sql_create_yeargroup_table ="""
    CREATE TABLE IF NOT EXISTS yeargroup (
        yeargroup_id    integer     PRIMARY KEY,
        year_run        text(4),
        year_level      text(4)
    );
"""

# ====================================
#  Students Table
# ====================================

sql_create_students_table = """ 
    CREATE TABLE IF NOT EXISTS students (
        student_id      integer     PRIMARY KEY,
        student_num     text(50),
        first_name      text(50),
        last_name       text(50),
        birthday        text(50),
        gender          text(10),
        yeargroup_id   integer,
        FOREIGN KEY(yeargroup_id) REFERENCES yeargroup(yeargroup_id)
    ); 
"""

sql_create_students_entry = """ 
    INSERT INTO students (
        student_num,
        first_name,
        last_name,
        birthday,
        gender,
        yeargroup_id 
    ) VALUES (?, ?, ?, ?, ?, ?); 
"""

sql_get_students_entry = """ 
    SELECT * FROM students; 
"""

