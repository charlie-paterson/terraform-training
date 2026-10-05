# Terraform Training

A hands-on Terraform training repository focused on learning infrastructure as code through practical projects.

The repository is designed to build Terraform skills progressively, starting with local infrastructure and moving toward more realistic cloud architecture, automation, and CI/CD workflows.

## Goals

This repository is used to practise:

- Terraform fundamentals
- Infrastructure as Code (IaC)
- Terraform modules
- Variables and outputs
- Resource dependencies
- Terraform state management
- Terraform providers
- AWS infrastructure
- Docker
- Local cloud development
- CI/CD
- GitHub Actions
- Infrastructure testing
- Cloud architecture
- Event-driven architecture
- Serverless architecture

The emphasis is on building working infrastructure rather than following isolated tutorials.

## Repository Structure

    terraform-training/
    │
    ├── local-cloud/
    │   ├── infrastructure/
    │   │   ├── modules/
    │   │   │   ├── networking/
    │   │   │   ├── compute/
    │   │   │   ├── database/
    │   │   │   ├── messaging/
    │   │   │   ├── lambda/
    │   │   │   ├── api/
    │   │   │   └── iam/
    │   │   │
    │   │   ├── main.tf
    │   │   ├── provider.tf
    │   │   ├── variables.tf
    │   │   ├── terraform.tfvars
    │   │   ├── outputs.tf
    │   │   └── ...
    │   │
    │   ├── lambda/
    │   │   ├── publish/
    │   │   └── worker/
    │   │
    │   └── README.md
    │
    └── README.md

## Projects

### Local Cloud Simulator

The first major project is a local AWS-style environment built with:

- Terraform
- Docker
- LocalEmu
- GitHub Actions

The project provides a local environment for deploying and testing AWS-compatible infrastructure without requiring an AWS account.

Current resources include:

- VPC
- Subnet
- Security Group
- EC2
- IAM
- DynamoDB
- SNS
- SQS
- Lambda
- API Gateway
- S3
- PostgreSQL
- Redis

The current application flow is:

    Client
      │
      ▼
    API Gateway
      │
      ▼
    Publish Lambda
      │
      ▼
    SNS
      │
      ▼
    SQS
      │
      ▼
    Worker Lambda
      │
      ▼
    DynamoDB

See the project documentation:

[Local Cloud Simulator](./local-cloud/README.md)

## Terraform Approach

Terraform is treated as the source of truth for infrastructure.

Changes are made through Terraform configuration rather than manually creating resources through the LocalEmu dashboard.

The general workflow is:

    Make Change
        │
        ▼
    Create Pull Request
        │
        ▼
    Terraform Format
        │
        ▼
    Terraform Validate
        │
        ▼
    Terraform Plan
        │
        ▼
    Review
        │
        ▼
    Merge to main
        │
        ▼
    Terraform Apply

This mirrors a real-world infrastructure workflow while keeping the environment local.

## CI/CD

GitHub Actions is used to validate and deploy Terraform changes.

### Pull Requests

Pull requests run:

    terraform init
    terraform fmt -check
    terraform validate
    terraform plan

Pull requests do not apply infrastructure.

### Main Branch

Changes merged into `main` run:

    terraform init
    terraform fmt -check
    terraform validate
    terraform plan
    terraform apply -auto-approve

The Terraform workflow runs using a self-hosted GitHub Actions runner.

## Terraform Modules

The projects in this repository are progressively structured using reusable Terraform modules.

The local cloud project currently contains modules for:

- Networking
- Compute
- Database
- Messaging
- Lambda
- API Gateway
- IAM

Modules are designed around responsibility rather than simply splitting resources into separate files.

For example:

    modules/
    ├── networking/
    ├── compute/
    ├── database/
    ├── messaging/
    ├── lambda/
    ├── api/
    └── iam/

Terraform `moved` blocks are used when existing resources are refactored into modules.

This allows infrastructure to be reorganised without unnecessarily destroying and recreating resources.

## State Management

Terraform state is kept outside the Git repository.

State files are not committed to Git.

The local cloud project uses a local Terraform backend with state stored outside the repository:

    /home/pater/terraform-state/local-cloud/terraform.tfstate

This keeps Terraform state separate from the source code and prevents state files from being accidentally committed.

## Development Environment

The projects are developed using:

- WSL
- Linux
- Docker
- Terraform
- Git
- GitHub
- GitHub Actions
- LocalEmu

The local environment is intended to provide a realistic development and CI/CD workflow without requiring cloud infrastructure for every experiment.

## Learning Path

The repository is intended to evolve over time.

### Terraform Fundamentals

- [x] Providers
- [x] Resources
- [x] Variables
- [x] Outputs
- [x] Terraform state
- [x] Terraform plan
- [x] Terraform apply
- [x] Terraform validation
- [x] Terraform formatting

### Terraform Structure

- [x] Terraform modules
- [x] Module inputs
- [x] Module outputs
- [x] Resource dependencies
- [x] `moved` blocks
- [ ] More reusable modules
- [ ] Module versioning

### AWS Infrastructure

- [x] VPC
- [x] Subnets
- [x] Security Groups
- [x] EC2
- [x] IAM
- [x] DynamoDB
- [x] SNS
- [x] SQS
- [x] Lambda
- [x] API Gateway
- [x] S3

### Automation

- [x] GitHub Actions
- [x] Pull request validation
- [x] Terraform plan
- [x] Automated apply on `main`
- [x] Self-hosted runner
- [ ] Automated infrastructure smoke tests
- [ ] Automated application tests

### Architecture

- [x] Serverless architecture
- [x] Event-driven architecture
- [x] API Gateway → Lambda
- [x] Lambda → SNS
- [x] SNS → SQS
- [x] SQS → Lambda
- [x] Lambda → DynamoDB
- [ ] More complex networking
- [ ] Multiple application workflows
- [ ] Observability and monitoring

## Roadmap

Future work will include:

- Expand the Local Cloud environment
- Add additional EC2 instances
- Add additional Lambda functions
- Add additional SNS and SQS workflows
- Add more DynamoDB tables
- Expand API Gateway routes
- Improve networking
- Add automated smoke tests
- Add infrastructure testing
- Add architecture diagrams
- Experiment with additional Terraform providers
- Build additional Terraform training projects
- Introduce more advanced Terraform patterns

## Philosophy

The goal of this repository is not simply to collect Terraform examples.

Each project should demonstrate a practical infrastructure problem and use Terraform to solve it.

The preferred workflow is:

    Infrastructure as Code
            +
    Version Control
            +
    Automated Validation
            +
    Terraform Plan
            +
    Code Review
            +
    CI/CD

The repository will evolve as new Terraform concepts and infrastructure patterns are introduced.

## Status

**Status:** Active development

This repository is primarily a learning and portfolio project focused on developing practical Terraform, cloud infrastructure, and CI/CD skills.
