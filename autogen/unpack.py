import json

problem_set = json.load(open("./unsolved_problem.json"))

dumped = [
    {
        "name": problem['title'],
        "description": problem['description']
    }
    for problem in problem_set
]

json.dump(dumped, open("./testings.json", "w", encoding = "utf-8"), indent = 4, ensure_ascii = False)