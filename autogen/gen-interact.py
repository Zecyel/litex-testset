import jsonlines
import os
from llm import ask
from tqdm import tqdm

def load_prompt(filepath: str) -> str:
    try:
        with open(filepath, "r", encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        print(f"Warning: Could not find file {filepath}")
        return ""
    except Exception as e:
        print(f"Error reading file {filepath}: {e}")
        return ""

prompt = """
Here's a machine proof language. Hereby's its documentation. Please follow the documentation, and write the proof of the following problem.
Note that you must wrap your proof with ```litex and ``` code block.
If you think the problem is so easy that the litex engine should have known it, you can simply write the question in litex without providing a proof.
""".strip()

tutor = load_prompt('../prompt/tutor.txt')
testings = load_prompt('../prompt/testings.txt')
examples = load_prompt('../prompt/examples.txt')
documentation = f"Tutorial: {tutor}\nExample: {testings}\n{examples}"

# Check if theory.jsonl exists
if not os.path.exists("./theory.jsonl"):
    print("Error: theory.jsonl file not found!")
    exit(1)

problem_description = input("Enter the problem description: ")

# load problem set from ./theory.jsonl
problem_set = list(jsonlines.open("./theory.jsonl"))

llm_prompt = f"{prompt}\nProblem: {problem_description}\nDocumentation: {documentation}"

try:
    resp = ask(llm_prompt, model="deepseek-v3-250324")
    print(resp)
except Exception as e:
    print(f"Error processing problem: {e}")