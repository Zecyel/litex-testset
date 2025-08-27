import jsonlines
import os
from llm import ask
import json
from tqdm import tqdm
import re
import litex

def extract_litex_code(proof_text):
    pattern = r'```litex\s*\n(.*?)\n```'
    matches = re.findall(pattern, proof_text, re.DOTALL)
    if matches:
        return matches[-1].strip()
    return ""

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
Notice that in Litex we don't have grammar like |a| for absolute value of a, we don't provide sin function, we don't use non-ascii letters like θ, Σ.
When a new concept is introduced, you should provide a definition of it.
You can never use mathematical language. You should always be careful when using Litex Grammar. If you failed to follow the grammar, you'll get pubished.
""".strip()

tutor = load_prompt('../prompt/tutor.txt')
testings = load_prompt('../prompt/testings.txt')
examples = load_prompt('../prompt/examples.txt')
documentation = f"Tutorial:\n{tutor}\nHere's some solved problems:\n{testings}\n" #Here's other examples:\n{examples}"

def answer_question(question: str, model: str = "deepseek-r1-250528") -> str:
    llm_prompt = f"{prompt}\nProblem: {question}\nDocumentation: {documentation}"
    try:
        resp = ask(llm_prompt, model=model)
        return resp
    except Exception as e:
        print(f"Error processing problem {question}: {e}")
        return ""

def solve_problem_set(problem_set: list, model: str = "deepseek-r1-250528") -> list:
    proof_set = []
    pbar = tqdm(problem_set, desc="Processing problems")
    for problem in pbar:
        pbar.set_description(f"Solving: {problem['name']}")
        try:
            resp = answer_question(problem['description'], model)
            proof_set.append({
                "name": problem["name"],
                "description": problem["description"],
                "proof": resp
            })
        except Exception as e:
            print(f"Error processing problem {problem['name']}: {e}")
            continue
    return proof_set

if __name__ == "__main__":
    problem_set = json.load(open("./testings.json"))
    for problem in problem_set:
        try:
            print("Solving problem", problem['name'], "...")
            llm_solution = answer_question(problem['description'])
            litex_solution = extract_litex_code(llm_solution)
            print("LLM answer solution:\n", litex_solution)
            if litex_solution == "":
                continue
            verified = litex.verify(litex_solution)
            if not verified:
                # Maybe read the error message and start another try?
                continue
            print("Solved!")
            with open(f"./solution/{problem['name']}.lix", 'w', encoding='utf-8') as f:
                f.write(litex_solution)
        except Exception as e:
            print("Encountered exception", e)
            continue
    