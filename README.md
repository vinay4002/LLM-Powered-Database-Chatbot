# LLM-Powered-Database-Chatbot
LLM-powered database chatbot that converts natural language questions into SQL queries and returns human-like answers using MySQL, PHP APIs, Python, and the Mistral-7B model from Hugging Face.
# LLM-Powered Database Chatbot

An intelligent chatbot system that allows users to query a MySQL database using natural language.  
The system converts user questions into SQL queries using an LLM and returns human-like responses.

This project integrates **PHP APIs**, **Python scripts**, **MySQL**, and the **Mistral-7B LLM** to dynamically fetch and generate answers from the database.

---

## Features

- Natural language questions converted to SQL queries
- Dynamic responses fetched from a MySQL database
- Human-like chatbot responses
- Backend API built with PHP
- Python integration for LLM processing
- Optimized SQL queries for faster responses
- Supports Hugging Face LLM models

---

## Technologies Used

- Python
- PHP
- MySQL
- Hugging Face Models
- Mistral-7B-Instruct
- Postman (for API testing)

---

## LLM Model

This project uses the following model:

**mistral-7b-instruct-v0.2.Q4_K_M.gguf**

Download it from Hugging Face and place it inside the **models/** folder.

Example:
models/
mistral-7b-instruct-v0.2.Q4_K_M.gguf


---

## Project Structure
project-root
│
├── api.php
├── connection.php
├── generate_sql.py
├── generate_answer.py
│
├── dataset/
├── models/
├── database/
│ └── student_management_system.sql
│
├── pictures/
│
├── venv/
└── README.md


---

## Setup Instructions

### 1️⃣ Clone the Repository
database/student_management_system.sql


into your MySQL server.

This will create the following tables:

- students
- teachers
- student_marks

---

### 3️⃣ Configure Database Connection

Open:


connection.php


Update your database credentials:

#php
$host = "localhost";
$user = "your_username";
$password = "your_password";
$db = "student_management_system";
4️⃣ Download the LLM Model

Download the model from Hugging Face:

mistral-7b-instruct-v0.2.Q4_K_M.gguf

Place it inside the models/ folder.

5️⃣ Activate Python Virtual Environment

Create and activate the virtual environment.

Windows:

venv\Scripts\activate

Linux / Mac:

source venv/bin/activate

Install required dependencies if needed.

6️⃣ Start the PHP Server

Run the following command:

php -S localhost:8000

Your API will be available at:

http://localhost:8000/api.php
Testing the API Using Postman

Use Postman to send a POST request.

Endpoint
POST http://localhost:8000/api.php
Request Body
{
 "question": "who is home room teacher for arjun class 9"
}
Example Response
{
 "sql_query": "SELECT DISTINCT teachers.teacher_name FROM teachers JOIN students ON teachers.class = students.class AND teachers.section = students.section WHERE students.student_name = 'arjun' AND students.class = 9;",
 "data": [
   {
     "teacher_name": "Ravi Kumar"
   }
 ],
 "answer": "Ravi Kumar is the homeroom teacher for Arjun's class 9."
}

The chatbot:

Converts the question into SQL

Fetches the data from MySQL

Generates a human-like response

Example API Test

How the System Works

1️⃣ User sends a natural language question
2️⃣ Python LLM converts the question into an SQL query
3️⃣ PHP API executes the SQL query on MySQL
4️⃣ The result is returned to the Python script
5️⃣ The LLM generates a human-like response
6️⃣ API returns structured JSON output

Example Questions You Can Ask

You can query the database using natural language such as:

Who is the homeroom teacher for Arjun?

What marks did Rahul score in maths?

Which class does teacher Ravi Kumar teach?

Show marks for student Arjun

Who teaches class 10?

The chatbot fetches the data from the students, teachers, and student_marks tables and generates answers like a real assistant.
