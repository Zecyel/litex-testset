import os
import requests

def ask(prompt: str, model: str = "deepseek-v3-250324") -> str:
    api_key = os.getenv("OPENAI_API_KEY")
    base_url = os.getenv("OPENAI_BASE_URL")
    
    # print(f"API Key set: {'Yes' if api_key else 'No'}")
    # print(f"Base URL set: {'Yes' if base_url else 'No'}")
    
    if not api_key:
        raise ValueError("OPENAI_API_KEY environment variable is not set")
    if not base_url:
        raise ValueError("OPENAI_BASE_URL environment variable is not set")

    response = requests.post(
        url = base_url,
        json = {
            "model": model,
            "messages": [
                {
                    "role": "user",
                    "content": prompt
                }
            ],
            "temperature": 0.7,
            "stream": False,
        },
        headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {api_key}"
        }
    )
    response.raise_for_status()
    return response.json()["choices"][0]["message"]["content"]
