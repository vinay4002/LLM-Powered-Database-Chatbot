import sys
import json
from llama_cpp import Llama


# ---------- LOAD DATASET ----------
dataset = []
with open("dataset/sql_dataset.jsonl", "r") as f:
    for line in f:
        line = line.strip()
        if line:
            dataset.append(json.loads(line))
# ---------------------------------


# ---------- GET USER QUESTION ----------
question = sys.argv[1].lower().strip()
question_words = set(question.split())
# --------------------------------------


# ---------- FIND TOP MATCHING DATASET EXAMPLES ----------
scored_matches = []

for item in dataset:
    dataset_words = set(item["question"].lower().split())
    common_words = question_words.intersection(dataset_words)
    score = len(common_words)

    if score > 0:
        scored_matches.append((score, item))

# Sort by highest score first
scored_matches.sort(reverse=True, key=lambda x: x[0])

# Take top 3 matches
top_matches = [item for _, item in scored_matches[:3]]
# -------------------------------------------------------


# ---------- BUILD EXAMPLE TEXT ----------
example_text = ""

for match in top_matches:
    example_text += f"""
Example:
User Question: {match['question']}
SQL Query: {match['sql']}
"""
# ----------------------------------------


# ---------- LOAD MODEL ----------
model_path = "models/Mistral-7B-Instruct-v0.2.Q4_K_M.gguf"

llm = Llama(
    model_path=model_path,
    n_ctx=2048,
    n_threads=8
)
# --------------------------------


# ---------- BUILD PROMPT ----------
prompt = f"""
You are a MySQL expert.

Database Schema:

students(
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    class INT,
    section CHAR(1)
)

teachers(
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(100),
    subject VARCHAR(50),
    class INT,
    section CHAR(1)
)

student_marks(
    student_id INT PRIMARY KEY,
    telugu INT,
    hindi INT,
    english INT,
    math INT,
    science INT,
    total_marks INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
)

Relationship Notes:
- student_marks is linked to students using student_id
- teachers table is linked to students using class and section

{example_text}

PRIORITY RULES (Highest Priority — MUST FOLLOW):
- Use ONLY tables and columns from schema
- Follow relationship notes when writing JOIN
- DO NOT explain anything
- DO NOT give comments
- DO NOT correct examples
- OUTPUT ONLY VALID SQL QUERY
- Output must start with SELECT / INSERT / UPDATE / DELETE

LOW PRIORITY FORMATTING PREFERENCES
- When JOIN operations may create duplicate rows that do not change logical meaning,
  prefer using DISTINCT unless duplicates are explicitly requested.

- When returning multiple student rows, prefer ordering by:
  class ASC, section ASC, student_name ASC

- When returning multiple teacher rows, prefer ordering by:
  class ASC, section ASC, teacher_name ASC

- If user requests "latest", "recent", or "last", prefer:
  ORDER BY primary key DESC LIMIT 1

- If user requests unique results, prefer using DISTINCT

- Do NOT add ORDER BY to aggregate-only queries like COUNT, SUM, AVG unless logically required

IMPORTANT:
- SQL correctness is the highest priority
- If these guidelines conflict with correct SQL logic, ignore formatting.

User request:
{question}
"""
# --------------------------------


# ---------- RUN MODEL ----------
output = llm(prompt, max_tokens=200)
answer = output["choices"][0]["text"]
# --------------------------------


# ---------- CLEAN OUTPUT ----------
answer = answer.replace("```sql", "").replace("```", "").strip()

keywords = ["SELECT", "CREATE", "INSERT", "UPDATE", "DELETE"]

for key in keywords:
    if key in answer.upper():
        answer = answer[answer.upper().index(key):]
        break

# Remove comments if model still adds them
answer = answer.split("--")[0].strip()
# --------------------------------


print(answer)
