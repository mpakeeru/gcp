# Module to create a Service Account and Roles in Google Cloud Platform (GCP)
This module creates a service account and assign a single role at project level and assigns multiple roles at organization level. You must have appropriate IAM permissions to create service accounts and project permissions.

The module requires following variables as input.
|Variable              |Data Type         |Description                             |
|----------------------|------------------|----------------------------------------|
|service_account_name  | string           |Service account name                    |
|project_id            | string           |Project name                            |
|project_role          | string           |Project role name                       |
|organization_roles    | map(list(string))|List of Organizaiton Roles              |
|user_email            | string           |User company email address              |
|org_id                | string           |GCP Organization ID                     |
|environment           | string           |Environment p-production np-non prod    |

The email for the service accounts are available from the project outputs.

# Usage Examples
The examples directory contains examples of use. 



