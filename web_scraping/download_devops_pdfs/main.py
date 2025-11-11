from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import os
import requests
from urllib.parse import urlparse, urljoin

# --- CONFIGURATION ---
GITHUB_DOCS_URL = "https://github.com/NotHarshhaa/DevOps-Interview-Questions/tree/master/docs"
DOWNLOAD_DIR = "./downloaded_pdfs"

# Paths
homedir = os.path.expanduser("~")
chrome_bin = f"{homedir}/chrome-linux64/chrome"
chrome_driver = f"{homedir}/chromedriver-linux64/chromedriver"

# --- Setup Chrome Options ---
chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--no-sandbox")
chrome_options.binary_location = chrome_bin

# --- Setup WebDriver Service ---
service = Service(chrome_driver)
driver = webdriver.Chrome(service=service, options=chrome_options)

# Create download directory if not exists
os.makedirs(DOWNLOAD_DIR, exist_ok=True)

try:
    # Load the folder page
    driver.get(GITHUB_DOCS_URL)
    
    # Wait for file table to load
    WebDriverWait(driver, 10).until(
        EC.presence_of_all_elements_located((By.CSS_SELECTOR, "a[href*='/blob/']"))
    )
    
    # Find PDF links
    links = driver.find_elements(By.XPATH, "//a[contains(@href, '/blob/') and contains(translate(@href, '.PDF', '.pdf'), '.pdf')]")

    pdf_urls = []
    for a in links:
        href = a.get_attribute("href")
        if href and href.lower().endswith(".pdf"):
            # Convert to raw link
            raw_url = href.replace("github.com", "raw.githubusercontent.com").replace("/blob/", "/")
            pdf_urls.append(raw_url)

    print(f"Found {len(pdf_urls)} PDF(s) to download.")

    # Download PDFs
    for url in pdf_urls:
        filename = os.path.basename(urlparse(url).path)
        filepath = os.path.join(DOWNLOAD_DIR, filename)

        if os.path.exists(filepath):
            print(f"Skipping {filename}, already exists.")
            continue

        print(f"Downloading {filename} ...")
        resp = requests.get(url)
        if resp.status_code == 200:
            with open(filepath, "wb") as f:
                f.write(resp.content)
            print(f"Saved to {filepath}")
        else:
            print(f"Failed to download {url}: Status {resp.status_code}")

finally:
    driver.quit()
