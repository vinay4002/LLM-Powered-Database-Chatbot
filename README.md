# LLM-Powered Database Chatbot

An intelligent chatbot system that allows users to query a MySQL database using natural language.  
The system converts user questions into SQL queries using an LLM and returns human-like responses.

This project integrates **PHP APIs, Python scripts, MySQL, and the Mistral-7B LLM** to dynamically fetch and generate answers from the database.

---

# Features

- Natural language questions converted into SQL queries
- Dynamic responses fetched from a MySQL database
- Human-like chatbot responses
- Backend API built with PHP
- Python integration for LLM processing
- Optimized SQL queries for faster responses
- Supports Hugging Face LLM models

---

# Technologies Used

- Python
- PHP
- MySQL
- Hugging Face Models
- Mistral-7B-Instruct
- Postman (API testing)

---

# LLM Model

This project uses the following model:

mistral-7b-instruct-v0.2.Q4_K_M.gguf

Download it from Hugging Face and place it inside the **models/** folder.

Example:

models/
└── mistral-7b-instruct-v0.2.Q4_K_M.gguf

---

# Project Structure

```
LLM-Powered-Database-Chatbot
│
├── api.php
├── connection.php
├── generate_sql.py
├── generate_answer.py
│
├── dataset/
│
├── models/
│   └── mistral-7b-instruct-v0.2.Q4_K_M.gguf
│
├── database/
│   └── student_management_system.sql
│
├── pictures/
│   └── llm_ans.png
│
├── venv/
│
└── README.md
```

---

# Setup Instructions

## 1. Clone the Repository

```
git clone https://github.com/vinay4002/LLM-Powered-Database-Chatbot.git
cd LLM-Powered-Database-Chatbot
```

---

## 2. Import the Database

Import the SQL file located at:

```
database/student_management_system.sql
```

into your MySQL server.

This will create the following tables:

- students  
- teachers  
- student_marks  

---

## 3. Configure Database Connection

Open the file:

```
connection.php
```

Update your database credentials:

```php
$host = "localhost";
$user = "your_username";
$password = "your_password";
$db = "student_management_system";
```

---

## 4. Download the LLM Model

Download the model from Hugging Face:

```
mistral-7b-instruct-v0.2.Q4_K_M.gguf
```

Place it inside the **models/** folder.

---

## 5. Activate Python Virtual Environment

### Windows

```
venv\Scripts\activate
```

### Linux / Mac

```
source venv/bin/activate
```

Install required Python dependencies if needed.

---

## 6. Start the PHP Server

Run the following command:

```
php -S localhost:8000
```

Your API will run at:

```
http://localhost:8000/api.php
```

---

# Testing the API Using Postman

Send a **POST request** to:

```
http://localhost:8000/api.php
```

### Request Body

```json
{
 "question": "who is home room teacher for arjun class 9"
}
```

---

# Example Response

```json
{
 "sql_query": "SELECT DISTINCT teachers.teacher_name FROM teachers JOIN students ON teachers.class = students.class AND teachers.section = students.section WHERE students.student_name = 'arjun' AND students.class = 9;",
 "data": [
  {
   "teacher_name": "Ravi Kumar"
  }
 ],
 "answer": "Ravi Kumar is the homeroom teacher for Arjun's class 9."
}
```

---

# Example API Response

![Chatbot Response](https://github.com/vinay4002/LLM-Powered-Database-Chatbot/blob/main/pictures/llm_ans.png)

---

# How the System Works

1. User sends a natural language question  
2. Python LLM converts the question into an SQL query  
3. PHP API executes the SQL query on MySQL  
4. The result is returned to the Python script  
5. The LLM generates a human-like response  
6. API returns structured JSON output  

---

# Example Questions You Can Ask

You can query the database using natural language such as:

- Who is the homeroom teacher for Arjun?
- What marks did Rahul score in maths?
- Which class does teacher Ravi Kumar teach?
- Show marks for student Arjun
- Who teaches class 10?

The chatbot fetches data from the **students**, **teachers**, and **student_marks** tables and generates answers like a real assistant.

---

# Author

Developed as a **Database-Driven AI Chatbot integrating LLM and SQL databases**.