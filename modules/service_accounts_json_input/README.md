# Module to create multiple Service Accounts in Google Cloud Platform (GCP)
This module creates multiple service accounts based on a JSON file input. The module can create multiple service accounts across multiple projects. You must have appropriate IAM permissions to create service accounts and project permissions.

The module requires JSON file path as input variable. The JSON file should have the following elements.


'''json
[
    {
    "project_id":"YOURPROJECTID",
    "names":["YOUR-SERVICE-ACCOUNT-ID"],
    "display_name":"Display name for your service account",
    "description" :"Description",
    "descriptions":["Add multiple descriptions"],
    "project_roles":["Roles"]
    },
    {
    "project_id":"YOURPROJECTID",
    "names":["YOUR-SERVICE-ACCOUNT-ID2"],
    "display_name":"Display name for your service account",
    "description" :"Description",
    "descriptions":["Add multiple descriptions"],
    "project_roles":["Roles"]
    }
]
'''
JSON data tyes are as follows
    project_id    = string
    names = list(string)
    display_name  = string
    description   = string
    descriptions = list(string)
    project_roles         = list(string)

The email for the service accounts are available from the project outputs.

# Usage Examples
The examples directory contains examples of use. 

# Using a Specific Version for Terraform module
The module uses public terraform module to create service accounts. The current version is pinned to 4.2.2. This is required to ensure backward compatibility. Anytime you change the version ensure your code don't break.

