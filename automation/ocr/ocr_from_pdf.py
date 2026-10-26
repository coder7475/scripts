"""
This script processes PDF files in the 'pdf_docs' directory using the Mistral OCR API.
For each PDF file, it uploads the file, performs OCR, and saves the result as a JSON file in the 'ocr_results' directory.

Environment variable 'MISTRAL_API_KEY' (e.g., set in a .env file) is required for authentication with the Mistral API.

Requires:
    - python-dotenv
    - mistralai
    - A .env file with MISTRAL_API_KEY
    - PDF documents inside the 'pdf_docs' folder.

Usage:
    python ocr_from_pdf.py

Output:
    For each PDF, a corresponding _ocr.json file is created in the 'ocr_results' folder.
"""

import os
from dotenv import load_dotenv
from mistralai import Mistral

# Load environment variables from .env file
load_dotenv()

api_key = os.getenv("MISTRAL_API_KEY")
client = Mistral(api_key=api_key)

PDF_DIR = "pdf_docs"
OUTPUT_DIR = "ocr_results"
os.makedirs(OUTPUT_DIR, exist_ok=True)

def ocr_pdf(pdf_path, client, output_dir):
    """
    Uploads a PDF to Mistral, performs OCR, and saves the result as a JSON file.

    Args:
        pdf_path (str): Path to the PDF file.
        client (Mistral): An authenticated Mistral client instance.
        output_dir (str): Directory where OCR results will be saved.
    """
    with open(pdf_path, "rb") as f:
        uploaded_pdf = client.files.upload(
            file={
                "file_name": os.path.basename(pdf_path),
                "content": f,
            },
            purpose="ocr"
        )
    print(f"Uploaded: {pdf_path} -> {uploaded_pdf}")

    signed_url = client.files.get_signed_url(file_id=uploaded_pdf.id)
    ocr_response = client.ocr.process(
        model="mistral-ocr-latest",
        document={
            "type": "document_url",
            "document_url": signed_url.url,
        },
        include_image_base64=False
    )
    output_filename = os.path.splitext(os.path.basename(pdf_path))[0] + ".json"
    output_path = os.path.join(output_dir, output_filename)
    with open(output_path, "w", encoding="utf-8") as out_f:
        out_f.write(ocr_response.model_dump_json(indent=2, ensure_ascii=False))
    print(f"OCR response saved to {output_path}")

    client.files.delete(file_id=uploaded_pdf.id)

def main():
    # Find all pdf files in PDF_DIR
    pdf_files = [f for f in os.listdir(PDF_DIR) if f.lower().endswith(".pdf")]
    # print(pdf_files)
    if not pdf_files:
        print("No PDF files found in", PDF_DIR)
    else:
        for pdf_filename in pdf_files:
            pdf_path = os.path.join(PDF_DIR, pdf_filename)
            try:
                ocr_pdf(pdf_path, client, OUTPUT_DIR)  
            except Exception as e:
                print(f"Failed to OCR {pdf_path}: {e}")

if __name__ == "__main__":
    main()
