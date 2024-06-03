import os
import time
import requests
import signal
import sys
import logging

terminate = False

def run_load_generator(api_url, delay_ms):
    global terminate
    while not terminate:
        try:
            response = requests.get(api_url)
            logging.info(f"Request to {api_url} completed with status code {response.status_code}")
        except requests.RequestException as e:
            logging.error(f"Request to {api_url} failed: {e}")
        
        time.sleep(delay_ms / 1000.0)
    logging.info("Load generator terminated gracefully.")

def signal_handler(signum, frame):
    global terminate
    logging.info(f"Received signal {signum}, terminating...")
    terminate = True

if __name__ == "__main__":
    # Configure logging
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

    # Read environment variables
    api_url = os.getenv('API_URL')
    delay_ms = float(os.getenv('DELAY_MS', 1000))  # Default delay to 1000 milliseconds if not set

    if not api_url:
        logging.error("Error: API_URL environment variable is not set.")
        sys.exit(1)

    # Set up signal handler
    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGINT, signal_handler)

    logging.info(f"Starting load generator for {api_url} with a delay of {delay_ms} milliseconds between requests.")
    run_load_generator(api_url, delay_ms)
