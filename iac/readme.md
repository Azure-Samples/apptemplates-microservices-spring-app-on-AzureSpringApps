# Deploy PetClinic Infrastructure

1. Clone the repo
2. Create a Service Pricipal or set your AZ context

```bash
az login
az account set --subscriptionid
```

3. Update variables
4. deploy

```terraform
terraform init
terraform plan --var-file
terraform apply --var-file .\variables.tfvars --auto-approve
```
