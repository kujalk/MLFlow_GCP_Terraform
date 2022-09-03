Pre-PreRequisites
--------------------
[A] In Local machine
- Install docker (To build images and pull)
- Install "Gcloud" CLI tools
- Install Terraform

[B] In GCP
- Make sure you have a separate project for this purpose (If needed, create budget alert to track the expenses)
- Create a Service account -> Assign "Owner" primitive role to this account -> Download the JSON key
- Enable the following API
	- Cloud SQL
	- Secret Manager
	- Cloud Run
	

Method
--------
- Open terraform.tfvars and fill the values accordingly
	keyfile - Absolute path to the Service Account key file 
	mlflow_tracking_username - username for mlflow
	mlflow_tracking_password - password for mlflow

- gcloud auth login 
- gcloud auth configure-docker

- terraform init
- terraform plan
- terraform apply -auto-approve
- To destroy the resources -> terraform destroy -auto-approve


Note
-----
- Terraform will output the "Cloud run" service url in the output
- Totally it will take 15-20 min to create the resources (More time for Cloud SQL) and 3-5 minutes to destroy the resources
- Cloud SQL DB instance name must be set different each time, because, for 1 week we cannot use the same name
- If you get "failed to delete database" error -> Wait for another 15 min and delete the resources
