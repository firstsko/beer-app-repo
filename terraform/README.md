# STEP 1
Go to the shared directory and apply Terraform to create the ECR repository first.

# STEP 2
Push the code to GitHub to trigger the GitHub Action.

# STEP 3
Define the `terraform.tfvars` file correctly in each environment directory (e.g., dev, prod).

# STEP 4
Execute Terraform in the appropriate environment directory (dev or prod).

# STEP 5
Display the outputs. The RDS connection infomation will be generated randomly and marked as sensitive.
terraform output