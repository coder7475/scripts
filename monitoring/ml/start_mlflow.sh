#!/bin/bash

mlflow server --host 0.0.0.0 --port 5000 --backend-store-uri /mlflow_data & sleep 5; 
python train_model.py
wait