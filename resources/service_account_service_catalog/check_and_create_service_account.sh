#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <service_account_id> <project_id>"
    exit 1
fi

# Extract input parameters
SERVICE_ACCOUNT_ID="$1"
PROJECT_ID="$2"

# Check if the provided project ID is valid
gcloud projects describe "$PROJECT_ID" &> /dev/null
if [ $? -ne 0 ]; then
    echo "Invalid project ID: $PROJECT_ID"
    exit 1
fi

# Check if the service account already exists
gcloud iam service-accounts describe "$SERVICE_ACCOUNT_ID@$PROJECT_ID.iam.gserviceaccount.com" --project "$PROJECT_ID" &> /dev/null

if [ $? -eq 0 ]; then
    echo "Service account $SERVICE_ACCOUNT_ID already exists in project $PROJECT_ID."
else
    echo "Service account $SERVICE_ACCOUNT_ID does not exist in project $PROJECT_ID. Creating..."

    # Run Terraform to create the service account
    #cd terraform_directory # replace with the directory containing your Terraform configuration

    # Run Terraform init (if not already initialized)
    terraform init

    # Run Terraform apply to create the service account
    terraform apply \
        -var="project_id=$PROJECT_ID" \
        -var="service_account_id=$SERVICE_ACCOUNT_ID" \
        -auto-approve

    # Check if Terraform apply was successful
    if [ $? -eq 0 ]; then
        echo "Service account $SERVICE_ACCOUNT_ID created successfully in project $PROJECT_ID."
    else
        echo "Failed to create service account $SERVICE_ACCOUNT_ID in project $PROJECT_ID."
        exit 1
    fi
fi
