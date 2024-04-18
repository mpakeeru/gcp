
# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <service_account_id> <project_id>"
    exit 1
fi

# Extract input parameters
SERVICE_ACCOUNT_ID="$1"
PROJECT_ID="$2"

# Run gcloud command to list all service accounts in the specified project and grep for the specified service account ID
gcloud iam service-accounts list --project "$PROJECT_ID" --format="value(email)" | grep -q "$SERVICE_ACCOUNT_ID"

# Check the exit status of the previous command
if [ $? -eq 0 ]; then
    echo "Service account $SERVICE_ACCOUNT_ID exists in project $PROJECT_ID."
else
    echo "Service account $SERVICE_ACCOUNT_ID does not exist in project $PROJECT_ID."
fi
