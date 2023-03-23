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

1) Replace the following variables in the script with your Jenkins configuration:

    * JENKINS_URL: The URL of your Jenkins server
    * CREDENTIAL_ID: The ID to use for the credentials created by this script. This can be any string that is unique within your Jenkins credential store.
    
2) Create a file named secrets.txt in the same directory as the script. The file should contain one key-value pair per line, in the format 'key=value`.

3) To run the script, you need to pass two arguments: the Jenkins API token and the username of a user with sufficient permissions to create credentials:
```bash
./Add_Credential_Jenkins.sh <USER_NAME> <API_TOKEN>
```
  The script will then read each line from secrets.txt and create a credential for each key-value pair. The credential ID will be CREDENTIAL_ID_key, and the
  username and password will be key and value respectively.
