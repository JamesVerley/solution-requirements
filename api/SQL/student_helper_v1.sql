DROP TABLE "main"."teacher";
DROP TABLE "main"."subject";
DROP TABLE "main"."allocation";
DROP TABLE "main"."session";
DROP TABLE "main"."measure";
DROP TABLE "main"."criteria";
DROP TABLE "main"."level";
DROP TABLE "main"."student";
DROP TABLE "main"."studentyear";
DROP TABLE "main"."registration";
DROP TABLE "main"."enrolment";
DROP TABLE "main"."grade";

CREATE TABLE "main"."teacher" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"teacher_first_name" TEXT NOT NULL,
"teacher_last_name" TEXT NOT NULL,
"teacher_email" TEXT NOT NULL,
"teacher_password" TEXT
);
CREATE TABLE "main"."subject" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"subject_code" TEXT NOT NULL,
"subject_name" TEXT NOT NULL,
"subject_description" TEXT NOT NULL
);
CREATE TABLE "main"."allocation" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"teacher_id" INTEGER,
"subject_id" INTEGER,
CONSTRAINT "fk_allocation_teacher" FOREIGN KEY ("teacher_id") REFERENCES "teacher" ("id") ON DELETE SET NULL ON UPDATE SET NULL,
CONSTRAINT "fk_allocation_subject" FOREIGN KEY ("subject_id") REFERENCES "subject" ("id") ON DELETE SET NULL ON UPDATE SET NULL
);
CREATE TABLE "main"."session" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"session_date" TEXT NOT NULL,
"week_number" INTEGER NOT NULL,
"allocation_id" INTEGER NOT NULL,
CONSTRAINT "fk_session_allocation" FOREIGN KEY ("allocation_id") REFERENCES "allocation" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT
);
CREATE TABLE "main"."measure" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"description" TEXT NOT NULL,
"constraint" TEXT
);
CREATE TABLE "main"."criteria" (
"id" INTEGER NOT NULL,
"measure_id" INTEGER,
"allocation_id" INTEGER,
"description" TEXT,
PRIMARY KEY ("id") ,
CONSTRAINT "fk_criteria_measure" FOREIGN KEY ("measure_id") REFERENCES "measure" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_criteria_allocation" FOREIGN KEY ("allocation_id") REFERENCES "allocation" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE "main"."level" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"year_run" TEXT,
"year_level" TEXT
);
CREATE TABLE "main"."student" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"student_number" INTEGER,
"first_name" TEXT,
"last_name" TEXT,
"birthday" TEXT,
"gender" TEXT
);
CREATE TABLE "main"."studentyear" (
);
CREATE TABLE "main"."registration" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"student_id" INTEGER,
"level_id" TEXT,
CONSTRAINT "fk_registration_student" FOREIGN KEY ("student_id") REFERENCES "level" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_registration_level" FOREIGN KEY ("level_id") REFERENCES "student" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE "main"."enrolment" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"registration_id" INTEGER,
"subject_id" INTEGER,
CONSTRAINT "fk_enrolment_registration" FOREIGN KEY ("registration_id") REFERENCES "registration" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_enrolment_subject" FOREIGN KEY ("subject_id") REFERENCES "subject" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE "main"."grade" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"enrolment_id" INTEGER,
"session_id" INTEGER,
"criteria_id" INTEGER,
"grade" TEXT,
CONSTRAINT "fk_grade_enrolment" FOREIGN KEY ("enrolment_id") REFERENCES "enrolment" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_grade_session" FOREIGN KEY ("session_id") REFERENCES "session" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_grade_criteria" FOREIGN KEY ("criteria_id") REFERENCES "criteria" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
