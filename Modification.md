# Flask App Deployment on AWS ECS with Terraform and GitHub Actions

## 🧾 Overview
This project deploys a Flask application using Docker, AWS ECS Fargate, RDS PostgreSQL, and Terraform. It uses GitHub Actions to automate Docker image builds and pushes to Amazon ECR.

##  Tech Stack
- **Flask** (entrypoint.sh supports dev/prod)
- **Gunicorn** for production readiness
- **Docker**
- **Amazon ECS Fargate**
- **Amazon RDS PostgreSQL**
- **Amazon ECR**
- **Terraform** (modular structure)
- **GitHub Actions** for CI/CD

## Feature 
Switched to entrypoint.sh script:
Replaced direct CMD invocation of Flask with an entrypoint script. This allows dynamic switching between development and production modes based on the FLASK_ENV environment variable.

Production readiness:
Flask’s built-in server is not recommended for production. The script now uses Gunicorn when FLASK_ENV is not set to development.

Environment control:
Enabled configuration via external environment variables (e.g., in Terraform) to set FLASK_ENV and later, database credentials.



---
## Directory Structure

<pre lang="nohighlight"><code>```text 
.
├── app
│   ├── beer_catalog
│   │   ├── app.py
│   │   ├── beer.py
│   │   ├── db.py
│   │   └── poetry.toml
│   ├── poetry.lock
│   ├── pyproject.toml
│   ├── README.md
│   └── seed.py
├── docker
│   ├── Dockerfile
│   └── Dockerfile2
├── entrypoint.sh
├── Modification.md
├── README.md
└── terraform
    ├── dev
    │   ├── main.tf
    │   ├── output.tf
    │   ├── plan.txt
    │   ├── terraform.tfstate
    │   ├── terraform.tfstate.backup
    │   ├── terraform.tfvars   #define your development variable in here
    │   ├── tfplan
    │   └── variables.tf
    ├── main.tf
    ├── modules
    │   ├── ecr
    │   │   ├── main.tf         #define your ecr here
    │   │   └── variables.tf
    │   ├── ecs
    │   │   ├── autoscaling.tf
    │   │   ├── cluster.tf
    │   │   ├── iam.tf               
    │   │   ├── network.tf
    │   │   ├── service.tf
    │   │   ├── task.tf
    │   │   └── variables.tf
    │   ├── iam
    │   ├── rds
    │   │   ├── main.tf
    │   │   ├── network.tf
    │   │   ├── output.tf
    │   │   ├── secrets.tf     #defien your secrets managment
    │   │   ├── user.tf        #define your rds user configuration
    │   │   └── variables.tf
    │   ├── security
    │   │   ├── main.tf  #networking,firewall configuration
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   └── vpc
    ├── prod
    │   ├── main.tf
    │   ├── terraform.tfvars   #define your production variable in here
    │   └── variables.tf
    ├── README.md
    ├── shared                #shared module for ecs(other common modules)
    │   ├── main.tf              
    │   ├── terraform.tfvars
    │   └── variables.tf
    ├── terraform.tfstate
    └── versions.tf

```</code></pre>

## Terraform Workflow

### STEP 1
Go to the shared directory and apply Terraform to create the ECR repository first.(common for dev and prod)

### STEP 2
Push the code to GitHub to trigger the GitHub Action.

### STEP 3
Define the `terraform.tfvars` file correctly in each environment directory (e.g., dev, prod).

### STEP 4
Execute Terraform in the appropriate environment directory (dev or prod).

### STEP 5
Display the outputs. The RDS connection infomation will be generated randomly and marked as sensitive.
terraform output

```text
admin_secret_arn = "arn:aws:secretsmanager:ap-northeast-3:589140421825:secret:shippio-rds-master-credential-LjHQuw"
app_user_secret_arn = "arn:aws:secretsmanager:ap-northeast-3:589140421825:secret:shippio-rds-app-user-credential-4fitju"
rds_app_password = <sensitive>
rds_endpoint = "shippio-postgres-db.cbu2osgw4k6v.ap-northeast-3.rds.amazonaws.com:5432"
rds_master_password = <sensitive>
rds_master_username = "devmaster"
rds_psql_connect_command = <sensitive>
```

## GitHub Action CI/CD
.github/workflow/docker.yml

```yaml
name: Build and Push Docker Image to ECR

on:
  push:
    branches:
      - main

env:
  AWS_REGION: ap-northeast-3
  ECR_REPOSITORY: beer-app-repo
  IMAGE_TAG: latest

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    environment: dev

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Log in to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v2

      - name: Build Docker image
        run: |
          docker build -f docker/Dockerfile2 -t $ECR_REPOSITORY:$IMAGE_TAG .


      - name: Tag Docker image with ECR URL
        run: |
          docker tag $ECR_REPOSITORY:$IMAGE_TAG \
            ${{ steps.login-ecr.outputs.registry }}/$ECR_REPOSITORY:$IMAGE_TAG

      - name: Push Docker image to ECR
        run: |
          docker push ${{ steps.login-ecr.outputs.registry }}/$ECR_REPOSITORY:$IMAGE_TAG


```


## Docker Entrypoint

```bash
#!/bin/bash
set -e

if [ "$FLASK_ENV" = "development" ]; then
  echo "⚙️ Running in development mode"
  exec poetry run flask run --host=0.0.0.0 --port=5000
else
  echo "🚀 Running in production mode with Gunicorn"
  exec poetry run gunicorn beer_catalog.app:app --bind 0.0.0.0:5000
fi

```



## Connection 
Database configuration (planned):
Already created postgres db via terraform:
DB identifier:shippio-postgres-db
Endpoint: shippio-postgres-db.cbu2osgw4k6v.ap-northeast-3.rds.amazonaws.com
Port: 5432

Although not modified source code yet, the same approach can be applied to inject SQLAlchemy database URLs through environment variables for better separation of code and configuration.


ECS Access endpoint:
http://15.152.113.47:5000/


## Coming Soon
 Inject SQLAlchemy-compatible DATABASE_URL(base on contianer env variable,e.g. dev env use sqlite,prod env use porsgre)

 Staging environment and blue/green deployment support









