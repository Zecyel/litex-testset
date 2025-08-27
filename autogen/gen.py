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
    problem_set = list(jsonlines.open("./theory.jsonl"))
    proof_set = solve_problem_set(problem_set)
    with jsonlines.open("./proof-r1.jsonl.appendix", "w") as f:
        for proof in proof_set:
            f.write(proof)