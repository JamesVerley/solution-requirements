-- DROP TABLE "grade";
-- DROP TABLE "session";
-- DROP TABLE "subject_periods";
-- DROP TABLE "allocation";
-- DROP TABLE "teacher";
-- DROP TABLE "enrolment";
-- DROP TABLE "subject";
-- DROP TABLE "registration";
-- DROP TABLE "level";
-- DROP TABLE "student";
-- DROP TABLE "criterion";

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
CONSTRAINT "fk_allocation_teacher" FOREIGN KEY ("teacher_id") REFERENCES "teacher" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "fk_allocation_subject" FOREIGN KEY ("subject_id") REFERENCES "subject" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE "session" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK,
"session_date" TEXT NOT NULL,
"period_id" INTEGER NOT NULL,
"allocation_id" INTEGER,
CONSTRAINT "period_id" FOREIGN KEY ("period_id") REFERENCES "subject_periods" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT "allocation_id" FOREIGN KEY ("allocation_id") REFERENCES "allocation" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE "criterion" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"allocation_id" INTEGER,
"datatype_id" INTEGER NOT NULL,
"name" TEXT,
"description" TEXT,
"min" INTEGER,
"max" INTEGER,
"auxiliary" TEXT,
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
CONSTRAINT "fk_grade_criteria" FOREIGN KEY ("criteria_id") REFERENCES "criterion" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE "subject_periods" (
"id" INTEGER NOT NULL,
"start_time" TEXT,
"end_time" TEXT,
"day" TEXT,
"subject_id" INTEGER,
PRIMARY KEY ("id") ,
CONSTRAINT "fk_subject_subject_period" FOREIGN KEY ("subject_id") REFERENCES "subject" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

