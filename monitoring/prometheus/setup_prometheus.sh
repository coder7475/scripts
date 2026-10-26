#!/bin/bash
# Update the system
sudo apt-get update
sleep 1
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz
sleep 10
tar xvf prometheus-2.42.0.linux-amd64.tar.gz
sleep 2
sudo cp prometheus-2.42.0.linux-amd64/prometheus /usr/local/bin/
sudo cp prometheus-2.42.0.linux-amd64/promtool /usr/local/bin/
sleep 2
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo cp -r prometheus-2.42.0.linux-amd64/consoles /etc/prometheus
sudo cp -r prometheus-2.42.0.linux-amd64/console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sleep 5
rm -rf prometheus-2.42.0.linux-amd64.tar.gz prometheus-2.42.0.linux-amd64
sudo touch /etc/prometheus/prometheus.yml
​
echo "global:
  scrape_interval: 15s
scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']" | sudo tee /etc/prometheus/prometheus.yml
cd 
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
sleep 2 
sudo touch /etc/systemd/system/prometheus.service
echo "[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target
​
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries
​
[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/prometheus.service
sleep 2
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
sudo systemctl status prometheus
exit
echo "prometheus installation Completed!!! "