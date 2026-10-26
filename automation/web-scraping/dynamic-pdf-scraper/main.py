import time
import os
import json
import requests
import logging
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler()
    ]
)

# Config
BASE_URL = "https://apps.sfc.hk/productlistWeb/searchProduct/globalSearch.do"
PDF_DIR = "pdf"
os.makedirs(PDF_DIR, exist_ok=True)

# Set Selenium dirs
homedir = os.path.expanduser("~")
chrome_bin = f"{homedir}/chrome-linux64/chrome"
chrome_driver = f"{homedir}/chromedriver-linux64/chromedriver"

chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--no-sandbox")
chrome_options.binary_location = chrome_bin

driver = webdriver.Chrome(service=Service(chrome_driver), options=chrome_options)
wait = WebDriverWait(driver, 20)

logging.info("Navigating to the target page...")
driver.get(BASE_URL)

# Wait until the table is populated with non-empty text
logging.info("Waiting for product table to load...")
wait.until(lambda d: len(d.find_elements(By.CSS_SELECTOR, "div.investment-product-table table tr")) > 1)
time.sleep(2)

# Wait until accordion button is clickable and click it
# Click the correct accordion only for Unit Trusts & Mutual Funds
logging.info("Waiting for accordion header and clicking it for Unit Trusts & Mutual Funds...")
accordion_header = wait.until(
    EC.presence_of_element_located(
        (By.XPATH, "//h4[contains(text(), 'Unit Trusts')]/div[@class='fs-accordion-button']")
    )
)
driver.execute_script("arguments[0].click();", accordion_header)
time.sleep(2)

# wait for the table to load dynamically
logging.info("Waiting for dynamic table data to populate...")
time.sleep(3)

rows = driver.find_elements(By.CSS_SELECTOR, "div.investment-product-table table tr")[1:]
results = []
main_window = driver.current_window_handle

logging.info("Beginning scraping of investment products table...")
count = 0

for row in rows:
    count += 1
    logging.info(f"Processing row {count}")

    # Testing only
    if len(results) >= 2:
        break

    cols = row.find_elements(By.TAG_NAME, "td")
    if len(cols) < 5:
        logging.warning(f"Row {count} skipped: not enough columns")
        continue

    product = cols[0].text.strip()
    subfund = cols[1].text.strip()
    issuer = cols[2].text.strip()
    auth_date = cols[3].text.strip()
    pdf_paths = []

    # Handle popup for PDFs
    try:
        doc_id = None
        # Click cell link: "Offering Documents"
        doc_link = cols[4].find_element(By.TAG_NAME, "a")
        driver.execute_script("arguments[0].click();", doc_link)
        logging.info(f"Clicked on 'Offering Documents' link for product: {product}")

        # Wait for popup window to appear
        wait.until(lambda d: len(d.window_handles) > 1)
        popup = [h for h in driver.window_handles if h != main_window][0]
        driver.switch_to.window(popup)
        logging.info("Switched to document popup window.")

        # Wait for PDF links to show inside the popup
        pdf_els = wait.until(
            EC.presence_of_all_elements_located(
                (By.XPATH, "//table//a[contains(@onClick,'getDoc.do')]")
            )
        )

        for pdf_el in pdf_els:
            on_click = pdf_el.get_attribute("onClick")
            # Extract docId securely
            doc_id = on_click.split("docId=")[1].split("'")[0]

            pdf_url = (
                f"https://apps.sfc.hk/productlistWeb/searchProduct/getDoc.do"
                f"?lang=EN&docId={doc_id}"
            )
            pdf_url_cn = (
                f"https://apps.sfc.hk/productlistWeb/searchProduct/getDoc.do"
                f"?lang=TC&docId={doc_id}"
            )

            filename = f"{product}_{doc_id}_EN.pdf".replace(" ", "_")
            filename_cn = f"{product}_{doc_id}_CN.pdf".replace(" ", "_")
            file_path = os.path.join(PDF_DIR, filename)
            file_path_cn = os.path.join(PDF_DIR, filename_cn)

            # Download PDF
            try:
                logging.info(f"Downloading EN PDF for doc_id={doc_id} to {file_path}")
                r = requests.get(pdf_url)
                r.raise_for_status()
                with open(file_path, "wb") as f:
                    f.write(r.content)
                pdf_paths.append(file_path)
            except Exception as pdf_e:
                logging.error(f"Failed to download EN PDF for doc_id={doc_id}: {pdf_e}")

            try:
                logging.info(f"Downloading CN PDF for doc_id={doc_id} to {file_path_cn}")
                rc = requests.get(pdf_url_cn)
                rc.raise_for_status()
                with open(file_path_cn, "wb") as f:
                    f.write(rc.content)
                pdf_paths.append(file_path_cn)
            except Exception as pdf_e:
                logging.error(f"Failed to download CN PDF for doc_id={doc_id}: {pdf_e}")

        driver.close()
        driver.switch_to.window(main_window)
        logging.info("Closed popup and returned to main window.")

    except Exception as e:
        logging.error(f"Error processing row {count} (product: {product}): {e}")
        try:
            driver.switch_to.window(main_window)
        except Exception as switch_e:
            logging.warning(f"Could not switch to main window: {switch_e}")

    results.append({
        "doc_id": doc_id,
        "Product": product,
        "Subfund": subfund,
        "Issuer": issuer,
        "Authorisation Date": auth_date,
        "pdf_documents": pdf_paths
    })

driver.quit()

output_file = "investment_products.json"
try:
    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(results, f, indent=2, ensure_ascii=False)
    logging.info(f"Results saved to {output_file}")
except Exception as e:
    logging.error(f"Failed to save results to {output_file}: {e}")

total_rows = len(results)
logging.info(f"Scraped {total_rows} rows of data.")
logging.info("Sample results:\n" + json.dumps(results, indent=5))
