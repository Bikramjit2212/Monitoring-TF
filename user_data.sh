#!/bin/bash
# update packages
apt-get update -y
apt-get install docker.io docker-compose

#  enable docker service
systemctl enable docker
systemctl start docker

mkdir -p /opt/monitoring
cd /opt/monitoring

cat <<EOF prometheus.yml #EOF- End Of File
global:
  scrape_interval: 5s
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["prometheus:9090"]
EOF

cat <<EOF > docker-compose.yml
services:
  prometheus:
    image: prom/prometheus
    container_name: prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"
  grafana:
    image: grafana/grafana
    container_name: grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_USER=admin 
      - GF_SECURITY_ADMIN_PASSWORD=admin 
    depends_on:
      - prometheus
EOF

#  start elk
docker-compose up -d