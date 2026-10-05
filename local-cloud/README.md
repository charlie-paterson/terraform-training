# Local Cloud Simulator

A local AWS-style cloud environment built with **Terraform, Docker, LocalEmu, and GitHub Actions**.

The goal of this project is to practise real-world Terraform workflows without needing an AWS account or incurring cloud costs. Terraform manages the infrastructure, LocalEmu provides local AWS-compatible services, and GitHub Actions acts as the CI/CD pipeline.

## Architecture

The current environment contains:

- VPC
- Subnet
- Security Group
- EC2 instance
- IAM roles and instance profile
- DynamoDB table
- SNS topic
- SQS queue
- Lambda functions
- Lambda → SNS → SQS → Lambda event flow
- API Gateway HTTP API
- S3 bucket
- Local PostgreSQL and Redis containers

The main application flow is:

```text
Client
  │
  ▼
API Gateway
  │
  ▼
Publish Lambda
  │
  ▼
SNS Topic
  │
  ▼
SQS Queue
  │
  ▼
Worker Lambda
  │
  ▼
DynamoDB
