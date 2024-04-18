#!/bin/bash

# Check if correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <project_id> <service_account_id>"
    exit 1
fi

# Assigning arguments to variables
export project_id="$1"
export service_account_id="$2"


# Specify the path to the local state file
state_file_path="./remote_state.json"

# Using jq to search for the combination of project ID and service account ID in the JSON file
result=$(jq --arg project_id "$project_id" --arg service_account_id "$service_account_id" \
    '.resources[] | select(.type == "google_service_account") | .instances[] | select(.attributes.project == $project_id and .attributes.account_id == $service_account_id) | true' $state_file_path)

# Checking if the result is not null
if [ ! -z "$result" ]; then
    echo "Service account '$service_account_id' exists in project '$project_id'."
else
    echo "Service account '$service_account_id' does not exist in project '$project_id'."
fi
