# 🧠 Mistral OCR Automation

This project automates **Optical Character Recognition (OCR)** on PDF files using the **[Mistral AI API](https://docs.mistral.ai/)**.  
It uploads PDF documents to Mistral, performs OCR, and saves the extracted text as structured JSON files.

---

## 🚀 Features

- Automatically scans and uploads all PDFs from a local folder
- Uses **Mistral OCR API** for text extraction
- Saves each OCR result as a `.json` file in an output directory
- Cleans up uploaded files from Mistral after processing
- Supports environment configuration via `.env`

---

## 📦 Requirements

- **Python 3.9+**
- **Dependencies:**
  ```bash
  python-dotenv==1.0.1
  mistralai==1.2.3
  ```

````

Install them via:

```bash
pip install -r requirements.txt
```

---

## ⚙️ Setup

1. **Clone this repository**

   ```bash
   git clone https://github.com/yourusername/mistral-ocr-automation.git
   cd mistral-ocr-automation
   ```

2. **Create and configure a `.env` file**

   ```bash
   # .env
   MISTRAL_API_KEY=sk-your-mistral-api-key-here
   PDF_DIR=pdf_docs
   OUTPUT_DIR=ocr_results
   ```

   > ⚠️ Keep your `.env` private — never commit it to version control.

3. **Prepare directories**

   Place your PDF files inside the `pdf_docs/` folder:

   ```
   pdf_docs/
   ├── document1.pdf
   ├── document2.pdf
   ```

   The script will automatically create `ocr_results/` for output JSON files.

---

## 🧩 Usage

Run the script:

```bash
python ocr_from_pdf.py
```

### Example Output

For a file `document1.pdf`, you’ll get:

```
ocr_results/
├── document1.json
```

Each JSON file contains structured OCR output from the Mistral model.

---

## 🧰 File Structure

```
mistral-ocr-automation/
├── ocr_from_pdf.py       # Main OCR script
├── requirements.txt      # Dependency list
├── .env                  # Environment variables
├── pdf_docs/             # Input PDFs
└── ocr_results/          # OCR output JSONs
```

---

## 🔒 Security Notes

* Do **not** hardcode your API key in the code. Use the `.env` file.
* Avoid committing `.env` or `ocr_results/` to public repositories.
* You can add these to `.gitignore`:

  ```
  .env
  ocr_results/
  pdf_docs/
  ```

---

## 📚 References

* [Mistral AI Python SDK Documentation](https://pypi.org/project/mistralai/)
* [python-dotenv Documentation](https://pypi.org/project/python-dotenv/)
* [Mistral API Reference](https://docs.mistral.ai/api/)

---

## 🧑‍💻 Author

**Robiul Hossain**
Software Engineer • Focused on AI automation, DevOps, and system design
📧 [robiulhossain7475@gmail.com](mailto:robiulhossain7475@gmail.com)

````
