import sys
import json
from llama_cpp import Llama


# ---------- GET INPUT ----------
import base64

question = sys.argv[1]
encoded_json = sys.argv[2]

try:
    decoded_json = base64.b64decode(encoded_json).decode("utf-8")
    result_data = json.loads(decoded_json)
except:
    result_data = []
# --------------------------------


# ---------- LOAD MODEL ----------
model_path = "models/Mistral-7B-Instruct-v0.2.Q4_K_M.gguf"

llm = Llama(
    model_path=model_path,
    n_ctx=2048,
    n_threads=8
)
# --------------------------------


# ---------- HANDLE EMPTY RESULT ----------
if not result_data:
    print("No matching records found.")
    sys.exit()
# --------------------------------


# ---------- BUILD PROMPT ----------
prompt = f"""
You are a helpful assistant that converts database query results into clear human-readable answers.

Rules:
- Answer naturally in one or two sentences.
- Do NOT mention SQL.
- Do NOT show JSON.
- Use information from result data only.

User Question:
{question}

Database Result:
{json.dumps(result_data, indent=2)}

Answer:
"""
# --------------------------------


# ---------- RUN MODEL ----------
output = llm(prompt, max_tokens=150)
answer = output["choices"][0]["text"].strip()
# --------------------------------


print(answer)