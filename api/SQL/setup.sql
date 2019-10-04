-- DROP TABLE "grade";
-- DROP TABLE "session";
-- DROP TABLE "allocation";
-- DROP TABLE "teacher";
-- DROP TABLE "enrolment";
-- DROP TABLE "subject";
-- DROP TABLE "registration";
-- DROP TABLE "level";
-- DROP TABLE "student";
-- DROP TABLE "criteria";
-- DROP TABLE "measure";


CREATE TABLE "teacher" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"teacher_first_name" TEXT NOT NULL,
"teacher_last_name" TEXT NOT NULL,
"teacher_email" TEXT NOT NULL,
"teacher_password" TEXT
);
CREATE TABLE "subject" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"subject_code" TEXT NOT NULL,
"subject_name" TEXT NOT NULL,
"subject_description" TEXT NOT NULL
);
CREATE TABLE "allocation" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"teacher_id" INTEGER,
"subject_id" INTEGER,
CONSTRAINT "fk_allocation_teacher" FOREIGN KEY ("teacher_id") REFERENCES "teacher" ("id") ON DELETE SET NULL ON UPDATE SET NULL,
CONSTRAINT "fk_allocation_subject" FOREIGN KEY ("subject_id") REFERENCES "subject" ("id") ON DELETE SET NULL ON UPDATE SET NULL
);
CREATE TABLE "session" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"session_date" TEXT NOT NULL,
"week_number" INTEGER NOT NULL,
"allocation_id" INTEGER NOT NULL,
CONSTRAINT "fk_session_allocation" FOREIGN KEY ("allocation_id") REFERENCES "allocation" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE TABLE "measure" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"description" TEXT,
"min" TEXT,
"max" TEXT,
"category" TEXT
);
CREATE TABLE "criteria" (
"id" INTEGER NOT NULL,
"measure_id" INTEGER,
"allocation_id" INTEGER,
"description" TEXT,
PRIMARY KEY ("id") ,
CONSTRAINT "fk_criteria_measure" FOREIGN KEY ("measure_id") REFERENCES "measure" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_criteria_allocation" FOREIGN KEY ("allocation_id") REFERENCES "allocation" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE "level" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"year_run" TEXT,
"year_level" TEXT
);
CREATE TABLE "student" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"student_number" TEXT,
"first_name" TEXT,
"last_name" TEXT,
"birthday" TEXT,
"gender" TEXT
);
CREATE TABLE "registration" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"student_id" INTEGER,
"level_id" TEXT,
CONSTRAINT "fk_registration_student" FOREIGN KEY ("student_id") REFERENCES "level" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_registration_level" FOREIGN KEY ("level_id") REFERENCES "student" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE "enrolment" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"registration_id" INTEGER,
"subject_id" INTEGER,
CONSTRAINT "fk_enrolment_registration" FOREIGN KEY ("registration_id") REFERENCES "registration" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_enrolment_subject" FOREIGN KEY ("subject_id") REFERENCES "subject" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE "grade" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"enrolment_id" INTEGER,
"session_id" INTEGER,
"criteria_id" INTEGER,
"grade" TEXT,
CONSTRAINT "fk_grade_enrolment" FOREIGN KEY ("enrolment_id") REFERENCES "enrolment" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_grade_session" FOREIGN KEY ("session_id") REFERENCES "session" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_grade_criteria" FOREIGN KEY ("criteria_id") REFERENCES "criteria" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);


-- ======================
-- teacher
-- ======================
INSERT INTO "teacher" VALUES (1, 'Jonas', 'Smith', 'jonas.smith@mailinator.com', 'password');
INSERT INTO "teacher" VALUES (2, 'Jane', 'Di', 'jane.di@mailinator.com', 'password');
INSERT INTO "teacher" VALUES (3, 'Ed', 'Coconut', 'ed.coconut@mailinator.com', 'password');
INSERT INTO "teacher" VALUES (4, 'Tom', 'Stone', 'tom.stone@mailinator.com', 'password');
INSERT INTO "teacher" VALUES (5, 'Sue', 'Abe', 'sue.abe@mailinator.com', 'password');
INSERT INTO "teacher" VALUES (6, 'Kate', 'Black', 'kate.black@mailinator.com', 'password');
INSERT INTO "teacher" VALUES (7, 'George', 'Shack', 'george.shack@mailinator.com', 'password');

-- ======================
-- subject
-- ======================
INSERT INTO "subject" VALUES (1, 'ENG101', 'English Literature', 'Literature in English');
INSERT INTO "subject" VALUES (2, 'ENG102', 'English Grammar', 'English Grammer Introduction');
INSERT INTO "subject" VALUES (3, 'MAT101', 'Maths Foundation', 'Foundation Mathematics');
INSERT INTO "subject" VALUES (4, 'MAT102', 'Advanced Maths', 'Advanced Maths Course');
INSERT INTO "subject" VALUES (5, 'COM101', 'Programming with Python', 'Foundation Python Programming');
INSERT INTO "subject" VALUES (6, 'COM102', 'Database Foundation', 'Foundation Course for Database');
INSERT INTO "subject" VALUES (7, 'PED101', 'Introduction to Swimming', 'Basic Swimming Techniques');
INSERT INTO "subject" VALUES (8, 'PED102', 'PE General', 'General PE Class');

-- ======================
-- allocation
-- ======================
INSERT INTO "allocation" VALUES (1, 1, 1);
INSERT INTO "allocation" VALUES (2, 1, 2);
INSERT INTO "allocation" VALUES (3, 2, 1);
INSERT INTO "allocation" VALUES (4, 2, 2);
INSERT INTO "allocation" VALUES (5, 3, 3);
INSERT INTO "allocation" VALUES (6, 4, 4);
INSERT INTO "allocation" VALUES (7, 5, 5);
-- 
-- ======================
-- session
-- ======================
INSERT INTO "session"("id", "session_date", "week_number", "allocation_id") VALUES (NULL,'19/2/2019',4, 1);
INSERT INTO "session"("id", "session_date", "week_number", "allocation_id") VALUES (NULL,'26/2/2019',5, 1);
INSERT INTO "session"("id", "session_date", "week_number", "allocation_id") VALUES (NULL,'5/3/2019',6, 1);
INSERT INTO "session"("id", "session_date", "week_number", "allocation_id") VALUES (NULL,'12/3/2019',7, 1);
INSERT INTO "session"("id", "session_date", "week_number", "allocation_id") VALUES (NULL,'19/3/2019',8, 1);
INSERT INTO "session"("id", "session_date", "week_number", "allocation_id") VALUES (NULL,'26/3/2019',9, 1);
INSERT INTO "session"("id", "session_date", "week_number", "allocation_id") VALUES (NULL,'2/4/2019',10, 1);
INSERT INTO "session"("id", "session_date", "week_number", "allocation_id") VALUES (NULL,'9/4/2019',11, 1);
INSERT INTO "session"("id", "session_date", "week_number", "allocation_id") VALUES (NULL,'16/4/2019',12, 1);

-- ======================
-- measure
-- ======================
INSERT INTO "measure" VALUES (1, 'percentage', '0', '100', '{}');
INSERT INTO "measure" VALUES (2, 'checkbox', '0', '1', '{}');
INSERT INTO "measure" VALUES (3, 'category', '0', '4', '{"0":"N", "1":"P", "2":"C","3":"D","4":"HD"}');

-- ======================
-- criteria
-- ======================
-- 
-- ======================
-- student
-- ======================
INSERT INTO "student" VALUES (1, 1, 'Christi', 'Bella', '12/1/2000', 'F');

-- ======================
-- level
-- ======================
INSERT INTO "level" VALUES (1, '2017', '1');
INSERT INTO "level" VALUES (2, '2017', '2');
INSERT INTO "level" VALUES (3, '2017', '3');
INSERT INTO "level" VALUES (4, '2017', '4');
INSERT INTO "level" VALUES (5, '2017', '5');
INSERT INTO "level" VALUES (6, '2017', '6');
INSERT INTO "level" VALUES (7, '2017', '7');
INSERT INTO "level" VALUES (8, '2017', '8');
INSERT INTO "level" VALUES (9, '2017', '9');
INSERT INTO "level" VALUES (10, '2017', '10');
INSERT INTO "level" VALUES (11, '2017', '11');
INSERT INTO "level" VALUES (12, '2017', '12');
INSERT INTO "level" VALUES (13, '2018', '1');
INSERT INTO "level" VALUES (14, '2018', '2');
INSERT INTO "level" VALUES (15, '2018', '3');
INSERT INTO "level" VALUES (16, '2018', '4');
INSERT INTO "level" VALUES (17, '2018', '5');
INSERT INTO "level" VALUES (18, '2018', '6');
INSERT INTO "level" VALUES (19, '2018', '7');
INSERT INTO "level" VALUES (20, '2018', '8');
INSERT INTO "level" VALUES (21, '2018', '9');
INSERT INTO "level" VALUES (22, '2018', '10');
INSERT INTO "level" VALUES (23, '2018', '11');
INSERT INTO "level" VALUES (24, '2018', '12');
INSERT INTO "level" VALUES (25, '2019', '1');
INSERT INTO "level" VALUES (26, '2019', '2');
INSERT INTO "level" VALUES (27, '2019', '3');
INSERT INTO "level" VALUES (28, '2019', '4');
INSERT INTO "level" VALUES (29, '2019', '5');
INSERT INTO "level" VALUES (30, '2019', '6');
INSERT INTO "level" VALUES (31, '2019', '7');
INSERT INTO "level" VALUES (32, '2019', '8');
INSERT INTO "level" VALUES (33, '2019', '9');
INSERT INTO "level" VALUES (34, '2019', '10');
INSERT INTO "level" VALUES (35, '2019', '11');
INSERT INTO "level" VALUES (36, '2019', '12');

-- ======================
-- registration
-- ======================
INSERT INTO "registration"("student_id", "level_id") VALUES (1, '1');

-- ======================
-- enrolment
-- ======================
INSERT INTO "enrolment"("registration_id", "subject_id") VALUES (1, 1);

-- ======================
-- grade
-- ======================
-- 
