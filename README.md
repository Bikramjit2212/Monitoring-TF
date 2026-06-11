# Monitoring Infrastructure with Terraform, Prometheus & Grafana

## 📌 Project Overview

This project automates the provisioning of a complete monitoring stack on AWS using **Terraform**. It deploys an Ubuntu EC2 instance, installs Docker and Docker Compose through EC2 User Data, and launches **Prometheus** and **Grafana** containers for infrastructure monitoring and visualization.

The objective of this project is to demonstrate practical DevOps skills involving Infrastructure as Code (IaC), cloud provisioning, containerization, and observability.

---

## 🚀 Features

* Provision AWS infrastructure using Terraform
* Automatically deploy an EC2 instance
* Dynamically create Security Group rules
* Fetch the latest Ubuntu 22.04 AMI automatically
* Bootstrap EC2 using User Data scripts
* Install Docker and Docker Compose automatically
* Deploy Prometheus using Docker Compose
* Deploy Grafana using Docker Compose
* Expose monitoring dashboards via public URLs
* Output service endpoints using Terraform outputs
* Fully automated and reproducible deployment

---

## 🏗️ Architecture

```text
Terraform
    │
    ▼
AWS EC2 Instance (Ubuntu 22.04)
    │
    ├── Security Group
    │      ├─ SSH (22)
    │      ├─ Prometheus (9090)
    │      └─ Grafana (3000)
    │
    ▼
User Data Bootstrap Script
    │
    ├── Install Docker
    ├── Install Docker Compose
    ├── Configure Prometheus
    └── Deploy Docker Containers
             │
             ├── Prometheus
             └── Grafana
```

---

## 🛠️ Tech Stack

| Category                | Technologies     |
| ----------------------- | ---------------- |
| Infrastructure as Code  | Terraform        |
| Cloud Provider          | AWS              |
| Compute                 | EC2              |
| Operating System        | Ubuntu 22.04 LTS |
| Containerization        | Docker           |
| Container Orchestration | Docker Compose   |
| Monitoring              | Prometheus       |
| Visualization           | Grafana          |

---

## 📂 Project Structure

```text
Monitoring-TF/
├── main.tf
├── variables.tf
├── outputs.tf
└── user_data.sh
```

---

## ⚙️ Infrastructure Components

### AWS Provider Configuration

Terraform is configured to deploy resources in:

```hcl
Region: us-east-1
```

---

### Security Group

The project creates a Security Group allowing inbound traffic for:

| Port | Service    |
| ---- | ---------- |
| 22   | SSH        |
| 3000 | Grafana    |
| 9090 | Prometheus |

Outbound traffic is unrestricted.

Dynamic ingress rules are used to simplify configuration and improve scalability.

---

### Ubuntu AMI Selection

Terraform automatically retrieves the latest:

```text
Ubuntu 22.04 LTS (Jammy Jellyfish)
```

Benefits:

* No hardcoded AMI IDs
* Improved portability
* Automatic adoption of updated Ubuntu images

---

### EC2 Instance Deployment

| Configuration    | Value            |
| ---------------- | ---------------- |
| Instance Type    | t2.micro         |
| Region           | us-east-1        |
| Key Pair         | linuxkey         |
| Operating System | Ubuntu 22.04     |
| Bootstrap Method | User Data Script |

---

## 📊 Monitoring Stack Deployment

The EC2 User Data script performs the following actions automatically.

### 1. Install Required Packages

```bash
sudo apt-get update -y
sudo apt-get install -y docker.io docker-compose
```

Installs:

* Docker Engine
* Docker Compose

---

### 2. Enable Docker Service

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

Ensures Docker starts automatically after reboot.

---

### 3. Configure Prometheus

A Prometheus configuration file is generated:

```yaml
global:
  scrape_interval: 5s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets:
          - "prometheus:9090"
```

Prometheus scrapes its own metrics every 5 seconds.

---

### 4. Deploy Monitoring Containers

Docker Compose launches two services:

#### Prometheus

```yaml
image: prom/prometheus
```

Responsibilities:

* Metrics collection
* Time-series storage
* Monitoring engine

Port exposed:

```text
9090
```

---

#### Grafana

```yaml
image: grafana/grafana
```

Responsibilities:

* Dashboard creation
* Visualization
* Metrics analysis

Port exposed:

```text
3000
```

Default login credentials:

```text
Username: admin
Password: admin
```

---

## 📤 Terraform Outputs

After deployment, Terraform provides the following outputs.

### EC2 Public IP

```bash
terraform output instance_public_ip
```

---

### Prometheus URL

```bash
terraform output prometheus_url
```

Example:

```text
http://<EC2-PUBLIC-IP>:9090
```

---

### Grafana URL

```bash
terraform output grafana_url
```

Example:

```text
http://<EC2-PUBLIC-IP>:3000
```

---

## 🚀 Deployment Instructions

### Prerequisites

Ensure the following are installed and configured:

* AWS CLI
* Terraform
* AWS Credentials
* Existing AWS EC2 Key Pair named:

```text
linuxkey
```

---

### Clone the Repository

```bash
git clone <repository-url>
cd Monitoring-TF
```

---

### Initialize Terraform

```bash
terraform init
```

---

### Review the Execution Plan

```bash
terraform plan
```

---

### Deploy Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

when prompted.

---

### Access Monitoring Services

Prometheus:

```text
http://<PUBLIC-IP>:9090
```

Grafana:

```text
http://<PUBLIC-IP>:3000
```

Grafana Credentials:

```text
Username: admin
Password: admin
```

---

### Destroy Resources

To prevent unnecessary AWS charges:

```bash
terraform destroy
```

---

## 💡 DevOps Skills Demonstrated

This project showcases hands-on experience with:

* Terraform
* Infrastructure as Code (IaC)
* AWS EC2 Provisioning
* Security Group Configuration
* Dynamic Terraform Blocks
* AWS Data Sources
* Linux Administration
* EC2 User Data Bootstrapping
* Docker Installation and Management
* Docker Compose
* Prometheus Deployment
* Grafana Deployment
* Infrastructure Monitoring
* Cloud Automation
* Infrastructure Lifecycle Management

---

## 🔒 Production Improvements

For production-grade environments, consider implementing:

* Remote Terraform state using S3
* DynamoDB state locking
* Restricting SSH access to trusted IP ranges
* Storing secrets securely using AWS Secrets Manager
* Using IAM Roles instead of static credentials
* Grafana credential hardening
* Deploying the monitoring stack on Kubernetes using Helm
* Integrating Alertmanager for notifications
* Adding Node Exporter for host-level monitoring

---

## 🎯 Resume Impact Statement

> Designed and automated the deployment of a cloud-based monitoring platform using Terraform on AWS by provisioning EC2 infrastructure and deploying Prometheus and Grafana containers with Docker Compose, enabling infrastructure observability and dashboard-driven monitoring.

---

## 📌 Learning Outcomes

Through this project, I gained practical experience in:

* Building cloud infrastructure using Terraform
* Automating server provisioning on AWS
* Managing Docker-based services
* Deploying and configuring Prometheus
* Visualizing metrics with Grafana
* Implementing monitoring solutions using Infrastructure as Code
* Understanding the fundamentals of observability in modern DevOps environments.
