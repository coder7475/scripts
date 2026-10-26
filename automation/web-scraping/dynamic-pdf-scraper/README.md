# Script to Scrape Data and Download using Selenium

#### 1. Clone this repository

```sh
git clone https://github.com/coder7475/dynamic_pdf_scraping
```

#### 2. Run Bash script to install Selenium

```sh
chmod +x install_selenium.sh
./install_selenium.sh
```

#### 3. Create a virtual environment

- On Linux/Mac:

```
python3 -m venv venv
source venv/bin/activate
```

#### 4. Install dependencies:

```
pip install -r requirements.txt
```

> for help, see: https://packaging.python.org/en/latest/tutorials/installing-packages

#### 5. Run Script

- Run the `main.py` file to scrape the data and pdfs:

```sh
python3 main.py
```

- To run the script in the background and save the output to a log file:

```sh
nohup python3 main.py > scrape.log 2>&1 &
```

You can check the progress with:

```sh
tail -f scrape.log
```

The results will be saved in `investment_products.json`

## Textract

# Basic installation

```sh
pip install textract
```

# On Ubuntu/Debian (install system dependencies)

sudo apt-get update
sudo apt-get install -y \
 python-dev \
 libxml2-dev \
 libxslt1-dev \
 antiword \
 unrtf \
 poppler-utils \
 pstotext \
 tesseract-ocr \
 flac \
 ffmpeg \
 lame \
 libmad0 \
 libsox-fmt-mp3 \
 sox \
 libjpeg-dev \
 swig

pip install textract

# On macOS

brew install libxml2 libxslt poppler antiword unrtf tesseract swig
pip install textract

# For Windows

# Download and install dependencies manually or use WSL

pip install textract
