## Student Record Helper Back End

REST API implemented using Python, Flask and SQLite, allowing users to query and add student records.

**Instructions**

**Dependency: **

- Install pipenv (ensure that you are in the `API` directory)

  `pip install pipenv`

- Set up virtual environment

  `pipenv install`

- Activate environment

  `pipenv shell`

- Run Application

  `python app.py`

URL [http://127.0.0.1:5000](http://127.0.0.1:5000)

---

**Test API End Points**

`http://127.0.0.1:5000/getallstudents`

`http://127.0.0.1:5000/getstudents/usingyeargroup`

`http://127.0.0.1:5000/getstudents/usingsubject`

`http://127.0.0.1:5000/getstudent/?id=1`

`http://127.0.0.1:5000/getsubjects/usingstudent?id=1`