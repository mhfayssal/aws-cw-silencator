# aws-cw-silencator

![AWS](https://img.shields.io/badge/AWS-CloudWatch-orange)
![Terraform](https://img.shields.io/badge/Terraform-IaC-purple)
![Lambda](https://img.shields.io/badge/AWS-Lambda-yellow)
![License](https://img.shields.io/badge/License-MIT-green)

> **aws-cw-silencator** is a **serverless solution** that allows you to **disable or re-enable Amazon CloudWatch alarm actions** based on keywords.  
It is designed to **silence alerts during maintenance windows**, deployments, or testing phases.

---

## 📌 Why this project?

During:
- application deployments
- planned maintenance
- infrastructure migrations
- load or stress testing

👉 CloudWatch alarms may trigger **unnecessary alerts** (Slack, PagerDuty, email, etc.).

**aws-cw-silencator** helps you:
- 🔕 **temporarily disable** alarm actions
- 🔔 **re-enable them later**
- 🎯 precisely target alarms using **keywords**
- 🚀 stay **100% Infrastructure as Code** with Terraform

---

## 🏗️ Architecture

```
User / CI / EventBridge
        |
        v
   AWS Lambda
        |
        v
CloudWatch Alarms
(Enable / Disable actions)
```

### Components
- **AWS Lambda** – business logic
- **CloudWatch Alarms**
- **IAM Role** with least-privilege permissions
- **Terraform** for deployment

---

## 📂 Project structure

```text
.
├── cloudwatch.tf
├── iam.tf
├── lambda.tf
├── variables.tf
├── outputs.tf
├── sources/
│   └── lambda_function.py
└── README.md
```

---

## ⚙️ Prerequisites

- Terraform **≥ 1.x**
- AWS CLI configured
- An AWS account with access to CloudWatch, IAM, and Lambda

---

## 🚀 Deployment

```bash
terraform init
terraform plan
terraform apply
```

After deployment, Terraform outputs:
- the **Lambda function name**
- its **ARN**

---

## ▶️ Usage

### Input payload

```json
{
  "keywords": ["app", "critical", "prod"],
  "status": "stop"
}
```

### Fields

| Field    | Type   | Required | Description |
|---------|--------|----------|-------------|
| keywords | array  | Yes | Keywords matched against alarm names |
| status   | string | Yes | `stop` or `start` |

---

### 🔕 Disable alarms

```json
{
  "keywords": ["api", "prod"],
  "status": "stop"
}
```

➡️ Calls `DisableAlarmActions` on matching alarms.

---

### 🔔 Re-enable alarms

```json
{
  "keywords": ["api", "prod"],
  "status": "start"
}
```

➡️ Calls `EnableAlarmActions`.

---

## 🧪 AWS CLI invocation example

```bash
aws lambda invoke   --function-name aws-cw-silencator   --payload '{
    "keywords": ["prod", "critical"],
    "status": "stop"
  }'   response.json
```

---

## 📜 Logs & observability

The Lambda function logs:
- number of alarms scanned
- number of alarms updated
- any errors encountered

Logs are available in **CloudWatch Logs**.

---

## 🔐 Security

- Least-privilege IAM permissions
- No secrets stored
- No customer-specific configuration hardcoded

---

## 🛣️ Roadmap

- Dry-run mode
- Keyword exclusions
- CloudWatch tag-based filtering
- Multi-region support
- EventBridge scheduling
- Multi-account support (AssumeRole)
- GitHub Actions (linting & security)

---

## 📄 License

MIT License
