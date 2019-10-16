# Design Note

![Model](./student_helper.png "Data Model")

---

#### (Table) Student

_Description: Students are individually represented as an entry in this table._

- **id:** primary key
- **student_number:** how students are identified in existing school system
- **first_name:** student's first name
- **last_name:** student's last name
- **birthday:** student's birther (used to calculate age)
- **gender:** student's gender (e.g. M/F/O)

#### (Table) Level

_Description: The Level table is an abstract representation of the different academic year and year group that student are in. In every academic year, there would be multiple year groups representing the different grades that students are at._

- **id:** primary key
- **year_run:** academic years
- **year_level:** the year level in each academic year (e.g. Year 9, Year 10, etc.)

#### (Table) Registration

_Description: Each entry represents the each individual student's registration in each academic year, at the corresponding year level._

- **id:** primary key
- **student_id:** foreign key to **Student**
- **level_id:** foreign key to **Level**

#### (Table) Subject

_Description: A subject entry represents a subject that the school offers._

- **id:** primary key
- **subject_code:** subject code used in existing school system to identify each subject
- **subject_name:** name of the subject
- **subject_description:** description notes to the subject

#### (Table) Enrolment

_Description: Individual students are enroled into subject in each academic year and year level._

- **id:** primary key
- **registration_id:** foreign key to **Registration**
- **subject_id:** foreign key to **Subject**

#### (Table) Subject Periods

#### (Table) Teacher

#### (Table) Allocation

#### (Table) Session

#### (Table) Criterion

#### (Table) Grade

---
