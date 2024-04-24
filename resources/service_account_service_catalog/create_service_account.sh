#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <service_account_id> <project_id> <role>"
    exit 1
fi

# Extract input parameters
SERVICE_ACCOUNT_ID="$1"
PROJECT_ID="$2"
ROLE="$3"

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

    # Run gcloud to create the service account
    gcloud iam service-accounts create "$SERVICE_ACCOUNT_ID" \
        --description="Service account for $SERVICE_ACCOUNT_ID" \
        --display-name="$SERVICE_ACCOUNT_ID" \
        --project="$PROJECT_ID"

    # Check if service account creation was successful
    if [ $? -eq 0 ]; then
        echo "Service account $SERVICE_ACCOUNT_ID created successfully in project $PROJECT_ID."

        # Add the specified role to the service account
        gcloud projects add-iam-policy-binding "$PROJECT_ID" \
            --member="serviceAccount:$SERVICE_ACCOUNT_ID@$PROJECT_ID.iam.gserviceaccount.com" \
            --role="$ROLE" \
            --condition=None

        # Check if role binding was successful
        if [ $? -eq 0 ]; then
            echo "Role $ROLE added to service account $SERVICE_ACCOUNT_ID in project $PROJECT_ID."
        else
            echo "Failed to add role $ROLE to service account $SERVICE_ACCOUNT_ID in project $PROJECT_ID."
            exit 1
        fi
    else
        echo "Failed to create service account $SERVICE_ACCOUNT_ID in project $PROJECT_ID."
        exit 1
    fi
fi
