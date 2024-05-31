import os
import time
import requests

def run_load_generator(api_url, delay_ms):
    while True:
        try:
            response = requests.get(api_url)
            print(f"Request to {api_url} completed with status code {response.status_code}")
        except requests.RequestException as e:
            print(f"Request to {api_url} failed: {e}")
        
        time.sleep(delay_ms / 1000.0)

if __name__ == "__main__":
    # Read environment variables
    api_url = os.getenv('API_URL')
    delay_ms = float(os.getenv('DELAY_MS', 1000))  # Default delay to 1000 milliseconds if not set

    if not api_url:
        print("Error: API_URL environment variable is not set.")
        exit(1)

    print(f"Starting load generator for {api_url} with a delay of {delay_ms} milliseconds between requests.")
    run_load_generator(api_url, delay_ms)
