import json

with open('data/schacon.repos.json', 'r', encoding='utf-8') as file:
    data = json.load(file)

with open('chacon.csv', 'w') as outfile:
    for repo in data[:5]:
        line = f"{repo['name']},{repo['html_url']},{repo['updated_at']},{repo['visibility']}\n"
        outfile.write(line)