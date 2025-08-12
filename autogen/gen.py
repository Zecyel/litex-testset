import jsonlines
from llm import ask

def load_prompt(filepath: str) -> str:
    with open(filepath, "r") as f:
        return f.read()

prompt = f"Here's a machine proof language. Hereby's its documentation. Please follow the documentation, and write the proof of the following problem."

documentation = f"Tutorial: {load_prompt('../prompt/tutor.txt')}\nExample: {load_prompt('../prompt/example.txt')}"

# load problem set from ./theory.jsonl
problem_set = list(jsonlines.open("./theory.jsonl"))

proof_set = []

for problem in problem_set:
    print("Solving problem: ", problem["name"])
    llm_prompt = f"{prompt}\nProblem: {problem['description']}\nDocumentation: {documentation}"
    # print(llm_prompt[:1000])
    resp = ask(llm_prompt, model="deepseek-v3-250324")
    # print(resp)
    proof_set.append({
        "name": problem["name"],
        "description": problem["description"],
        "proof": resp
    })

with jsonlines.open("./proof.jsonl", "w") as f:
    for proof in proof_set:
        f.write(proof)