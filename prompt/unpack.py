import json

problem_set = json.load(open("./solved_problem.json"))

dumped = "\n\n".join([
    f"Problem Name: {problem['title']}\nProblem Description: {problem['description']}\nProblem Solution:\n{problem['solution']}"
    for problem in problem_set
])

with open("./testings.txt", "w", encoding = "utf-8") as f:
    f.write(dumped)
