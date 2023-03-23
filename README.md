# Jenkins Credential Creator Script
This is a Bash script that creates Jenkins credentials using key-value pairs from an input file. The credentials are created as "Username with password" type
credentials in the Jenkins credential store. The script will use curl to send a POST request to the Jenkins API to create each credential. The API token and username
will be passed to curl using HTTP Basic authentication.

# Prerequisites
Before using this script, you need to have the following:

1) A Jenkins server running and accessible via HTTP(S)
2) A user account on the Jenkins server with sufficient permissions to create credentials
3) An API token for the user account

# Usage

1) Create a file named secrets.txt in your local. The file should contain one key-value pair per line, in the format 'key=value`.Replace the following variables with your secrets file location:
   * SECRETS_FILE_PATH: Replace the following variables with your secrets file location.
    
2) The script requires four command-line arguments:
```bash
./create_jenkins_credentials.sh <USER_NAME> <API_TOKEN> <JENKINS_URL> <CREDENTIAL_ID>
```
Where:

* USER_NAME: The username of a Jenkins user with permission to create credentials.
* API_TOKEN: The API token of the Jenkins user.
* JENKINS_URL: The URL of the Jenkins instance.
* CREDENTIAL_ID: An identifier for the credentials that will be created. This identifier will be used as a prefix for the ID of each individual credential.

The script will then read each line from secrets.txt and create a credential for each key-value pair. The credential ID will be CREDENTIAL_ID_key, and the
username and password will be key and value respectively.
