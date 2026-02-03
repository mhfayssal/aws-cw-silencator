# aws-cw-silencator

![AWS](https://img.shields.io/badge/AWS-CloudWatch-orange)
![Terraform](https://img.shields.io/badge/Terraform-IaC-purple)
![Lambda](https://img.shields.io/badge/AWS-Lambda-yellow)
![License](https://img.shields.io/badge/License-MIT-green)

> **aws-cw-silencator** est une solution **serverless** permettant de **désactiver ou réactiver les actions des alarmes Amazon CloudWatch** en fonction de mots-clés.  
Elle est idéale pour **silencier les alertes pendant des périodes de maintenance**, de déploiement ou de tests.

---

## 📌 Pourquoi ce projet ?

Lors de :
- déploiements applicatifs
- maintenances planifiées
- migrations infra
- tests de charge

👉 les alarmes CloudWatch peuvent générer **des alertes inutiles** (Slack, PagerDuty, email…).

**aws-cw-silencator** permet de :
- 🔕 **désactiver temporairement** les actions d’alarme
- 🔔 **les réactiver automatiquement**
- 🎯 cibler précisément les alarmes par **mots-clés**
- 🚀 rester **100 % IaC** avec Terraform

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

### Composants
- **AWS Lambda** : logique métier
- **CloudWatch Alarms**
- **IAM Role** (permissions minimales)
- **Terraform** pour le déploiement

---

## 📂 Structure du projet

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

## ⚙️ Prérequis

- Terraform **≥ 1.x**
- AWS CLI configuré
- Un compte AWS avec accès CloudWatch, IAM et Lambda

---

## 🚀 Déploiement

```bash
terraform init
terraform plan
terraform apply
```

À la fin du déploiement, Terraform fournit :
- le **nom de la Lambda**
- son **ARN**

---

## ▶️ Utilisation

### Payload d’entrée

```json
{
  "keywords": ["app", "critical", "prod"],
  "status": "stop"
}
```

### Champs

| Champ     | Type   | Obligatoire | Description |
|----------|--------|-------------|------------|
| keywords | array  | Oui | Mots-clés recherchés dans le nom des alarmes |
| status   | string | Oui | `stop` ou `start` |

---

### 🔕 Désactiver les alarmes

```json
{
  "keywords": ["api", "prod"],
  "status": "stop"
}
```

➡️ Appelle `DisableAlarmActions` sur les alarmes correspondantes.

---

### 🔔 Réactiver les alarmes

```json
{
  "keywords": ["api", "prod"],
  "status": "start"
}
```

➡️ Appelle `EnableAlarmActions`.

---

## 🧪 Exemple d’invocation AWS CLI

```bash
aws lambda invoke   --function-name aws-cw-silencator   --payload '{
    "keywords": ["prod", "critical"],
    "status": "stop"
  }'   response.json
```

---

## 📜 Logs & observabilité

La Lambda log :
- le nombre d’alarmes analysées
- le nombre d’alarmes modifiées
- les erreurs éventuelles

Logs disponibles dans **CloudWatch Logs**.

---

## 🔐 Sécurité

- Permissions IAM au strict minimum
- Aucun secret stocké
- Aucun environnement client hardcodé

---

## 🛣️ Roadmap

- Mode dry-run
- Exclusions par mot-clé
- Filtrage par tags CloudWatch
- Support multi-régions
- EventBridge Schedule
- Multi-comptes (AssumeRole)
- GitHub Actions

---

## 📄 Licence

MIT License
