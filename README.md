# AWS CW Silencator

**AWS CW Silencator** is an AWS Lambda function deployed with Terraform that allows you to **start or stop CloudWatch alarms** based on keyword matching. It is useful for silencing alarms temporarily (e.g., during maintenance windows) or re-enabling them afterward.

---

## 📦 Features

- Filter CloudWatch alarms using keyword matching
- Disable (`stop`) or enable (`start`) alarm actions
- Fully managed via Terraform
- Includes support for multiple environments via variable files

---

## 🚀 Usage

The Lambda function accepts the following event payload:

```json
{
  "keywords": ["application name", "alert", "critical"],
  "status": "stop"
}
