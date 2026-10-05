# Local Cloud Simulator

A local AWS-style cloud environment built with **Terraform, Docker, LocalEmu, and GitHub Actions**.

The goal of this project is to practise real-world Terraform workflows without needing an AWS account or incurring cloud costs.

Terraform manages the infrastructure, LocalEmu provides local AWS-compatible services, and GitHub Actions acts as the CI/CD pipeline.

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

All AWS-style resources are created locally through LocalEmu.

## Project Structure

    local-cloud/
    ├── infrastructure/
    │   ├── main.tf
    │   ├── provider.tf
    │   ├── variables.tf
    │   ├── terraform.tfvars
    │   ├── outputs.tf
    │   ├── ec2.tf
    │   ├── dynamodb.tf
    │   ├── sqs.tf
    │   ├── sns.tf
    │   ├── lambda.tf
    │   ├── iam.tf
    │   ├── api_gateway.tf
    │   │
    │   └── modules/
    │       ├── networking/
    │       ├── compute/
    │       ├── database/
    │       ├── messaging/
    │       ├── lambda/
    │       ├── api/
    │       └── iam/
    │
    ├── lambda/
    │   ├── publish/
    │   │   └── index.py
    │   └── worker/
    │       └── index.py
    │
    └── README.md

The infrastructure is progressively being refactored into reusable Terraform modules.

## LocalEmu

LocalEmu provides the local AWS-compatible API used by Terraform.

The LocalEmu container exposes port `4566`.

    http://localhost:4566

The LocalEmu dashboard is available at:

    http://localhost:4566/_localemu/dashboard

Health information is available at:

    http://localhost:4566/_localemu/health

The environment uses a persistent Docker volume so LocalEmu resources survive container restarts.

## Terraform

Terraform is the source of truth for the infrastructure.

The Terraform working directory is:

    local-cloud/infrastructure

Terraform state is stored outside the repository:

    /home/pater/terraform-state/local-cloud/terraform.tfstate

State files are intentionally not committed to Git.

## CI/CD

Infrastructure changes are managed through GitHub Actions.

### Pull Requests

Pull requests run:

    terraform init
    terraform fmt -check
    terraform validate
    terraform plan

No infrastructure is applied from a pull request.

### Main Branch

Changes merged into `main` run:

    terraform init
    terraform fmt -check
    terraform validate
    terraform plan
    terraform apply -auto-approve

The workflow runs on a self-hosted GitHub Actions runner.

This keeps CI/CD as the normal way of applying infrastructure changes.

## Terraform Modules

The infrastructure is organised into modules based on responsibility.

### Networking

Manages:

- VPC
- Subnet
- Security Group

### Compute

Manages:

- EC2 instances

### Database

Manages:

- DynamoDB

### Messaging

Manages:

- SNS
- SQS
- SNS → SQS subscriptions
- SQS policies

### Lambda

Manages:

- Lambda functions
- Lambda event source mappings

### API

Manages:

- API Gateway HTTP API
- Lambda integration
- Routes
- Stage

### IAM

Manages:

- Lambda IAM role
- EC2 SSM IAM role
- Instance profile
- IAM policies

Terraform `moved` blocks are used when resources are migrated into modules so that existing resources can be moved in Terraform state rather than destroyed and recreated.

## Testing the API

The API Gateway HTTP API exposes the `/events` route.

The LocalEmu execution endpoint is:

    http://localhost:4566/_aws/execute-api-v2/<api-id>/$default/events

For example:

    curl -i -X POST \
      'http://localhost:4566/_aws/execute-api-v2/mnpzymfe/$default/events' \
      -H "Content-Type: application/json" \
      -d '{"message":"hello"}'

> **Note:** Use single quotes around the URL because `$default` is otherwise interpreted by the Bash shell as an environment variable.

A successful request should trigger the application event flow:

    API Gateway
        ↓
    Publish Lambda
        ↓
    SNS
        ↓
    SQS
        ↓
    Worker Lambda
        ↓
    DynamoDB

LocalEmu logs can be inspected with:

    docker logs localemu --since 2m

## Running LocalEmu

Example Docker command:

    docker run -d \
      --name localemu \
      -p 4566:4566 \
      -p 4510-4559:4510-4559 \
      -v localemu-data:/var/lib/localemu \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -e PERSISTENCE=1 \
      -e DASHBOARD_API_OPEN=1 \
      localemu/localemu:latest

Check that the container is running:

    docker ps

Check LocalEmu health:

    curl http://localhost:4566/_localemu/health

## Design Goals

This project is primarily a Terraform learning environment.

The main goals are to practise:

- Terraform modules
- Terraform state management
- Resource dependencies
- Terraform variables and outputs
- `terraform plan`
- `terraform apply`
- Terraform `moved` blocks
- AWS-compatible infrastructure
- Serverless architecture
- Event-driven architecture
- IAM
- Docker
- GitHub Actions
- CI/CD
- Infrastructure testing
- Local cloud development

The project intentionally favours infrastructure-as-code and automation over manually configuring resources.

## Roadmap

Planned improvements include:

- [ ] Add additional EC2 instances
- [ ] Add additional DynamoDB tables
- [ ] Add multiple SNS/SQS workflows
- [ ] Add additional Lambda functions
- [ ] Expand API Gateway routes
- [ ] Add more S3 resources
- [ ] Add more realistic networking
- [ ] Add application-level test automation
- [ ] Add automated infrastructure smoke tests
- [ ] Improve LocalEmu dashboard visibility
- [ ] Add architecture diagrams
- [ ] Document Terraform module interfaces

## Status

**Current status:** Active development

The core local cloud environment is operational and managed through Terraform and GitHub Actions.

The API Gateway → Lambda → SNS → SQS → Lambda → DynamoDB workflow has been successfully exercised against LocalEmu.
