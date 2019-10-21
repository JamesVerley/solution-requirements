# Student Record Helper

**Heroku App Deployment API Base URL (Demo)**

```
https://student-record-helper-backend.herokuapp.com
```

### Description

**Student Record Helper** is a collaboration project with an objective of helping school teachers conveniently create and manage student records. 

This repository contains the backend REST API code. We are also currently working on a front end React Web App as part of the project, available via

```
https://github.com/juntao-dev/student-record-helper-front
```

[Placeholder - System Design Diagram]

_Note: This project is built upon a previous student project that aims to provide student grading solution to school PE teachers. The original project files remain available at the `original-project` branch._

_Dummy data records are created in for testing purposes, do not use real personal data when interacting with this API!_

### Tools

This demo project is currently under development. Tools that we are using include: 

- **Framework:** Python Flask
- **Hosting:** Heroku App
- **Data Storage:** SQLite

---

### API End Points

```HTTP
GET /get-all-students
```
**Usage:**

**Example:**


```HTTP
GET /get-student-by-id?id=<student id>
```
**Usage:**

**Example:**

```HTTP
GET /get-student-by-subject-code?code=<subject code>
```
**Usage:**

**Example:**

```HTTP
GET /getsubjectsbystudentid?id=<student id>
```
**Usage:**

**Example:**

```HTTP
GET /getsubjectsbyteacherid?id=<teacher id>
```
**Usage:**

**Example:**

```HTTP
GET /getcriteriabysubjectid?id=<subject id>
```
**Usage:**

**Example:**