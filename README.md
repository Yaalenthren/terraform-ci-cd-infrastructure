## Terraform CI/CD Infrastructure Automation on AWS

This project demonstrates a complete Infrastructure as Code (IaC) workflow using Terraform and a CI/CD pipeline built with GitHub Actions to automatically provision infrastructure in Amazon Web Services.
The pipeline provisions core AWS infrastructure components while also implementing state management, cost monitoring, and automated infrastructure deployment.

## Project Overview

This project automates the provisioning of cloud infrastructure using Terraform and a GitHub-based CI/CD pipeline.
Whenever changes are pushed to the repository, GitHub Actions automatically:
Initializes Terraform
Validates the configuration
Generates an execution plan
Applies the infrastructure changes to AWS
The pipeline also supports safe infrastructure destruction when needed.

## Architecture
```
Developer Push
       │
       ▼
GitHub Repository
       │
       ▼
GitHub Actions CI/CD Pipeline
       │
       ▼
Terraform Infrastructure Provisioning
       │
       ▼
AWS Infrastructure
├── VPC
├── Public Subnet
├── Security Group
├── EC2 Instance
├── S3 Bucket (Terraform State)
├── DynamoDB (State Locking)
├── AWS Budget Alerts
└── AWS Cost & Usage Reports
```
### Technologies Used
Category	Tools
Infrastructure as Code	Terraform
CI/CD Pipeline	GitHub Actions
Cloud Platform	Amazon Web Services
Compute	Amazon EC2
Networking	Amazon VPC
State Storage	Amazon S3
State Locking	Amazon DynamoDB
Cost Monitoring	AWS Budgets
Cost Reporting	AWS Cost and Usage Report
Key Features
Infrastructure as Code

Infrastructure is fully defined using Terraform modules for:

VPC

Subnets

Security Groups

EC2 instances

Automated CI/CD Pipeline

A GitHub Actions workflow automatically performs:

Terraform initialization

Terraform validation

Terraform planning

Terraform apply

This enables fully automated infrastructure provisioning.

Remote Terraform State Management

Terraform state is stored remotely in AWS for better collaboration and safety.

State files stored in Amazon S3

State locking handled using Amazon DynamoDB

This prevents concurrent modifications to infrastructure.

Cost Monitoring

The project includes built-in cost monitoring using AWS services.

Budget Alerts

An AWS Budget is configured with:

Monthly cost limit

80% usage alert

100% usage alert

Email notifications are triggered when thresholds are reached.

Cost and Usage Reports

AWS Cost & Usage Reports are configured to automatically generate detailed cost reports and store them in an S3 bucket.

These reports provide insights into:

Service usage

Resource-level costs

Billing breakdown

### Repository Structure
```
terraform-ci-cd-infrastructure
│
├── .github
│   └── workflows
│       └── terraform.yml
│
├── env
│   └── dev
│       └── main.tf
│
├── modules
│   ├── vpc
│   │   └── main.tf
│   │
│   ├── ec2
│   │   ├── main.tf
│   │   └── outputs.tf
│   │
│   ├── budget
│   │   └── main.tf
│   │
│   └── cost_reports
│       └── main.tf
│
└── README.md
```
### CI/CD Workflow

## The pipeline performs the following stages:

Validate
Runs Terraform initialization and validation.

Plan
Generates the Terraform execution plan.

Apply
Deploys the infrastructure automatically when changes are pushed to the main branch.

Destroy 
Infrastructure can be destroyed manually when required.

Example Infrastructure Created

When the pipeline runs successfully, the following AWS resources are provisioned:

VPC

Public Subnet

Security Group

EC2 instance

S3 bucket for cost reports

Terraform remote state storage

DynamoDB state lock table

AWS Budget alerts
