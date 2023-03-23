#!/bin/bash

# This script reads key-value pairs from a file and creates a Jenkins credential

# Replace the following variables with your secrets file location.
SECRETS_FILE_PATH="./secrets.txt"

# Check if the API token, username, Jenkins URL, and credential ID were passed as command-line arguments
if [ $# -ne 4 ]; then
  echo "Usage: $0 <USER_NAME> <API_TOKEN> <JENKINS_URL> <CREDENTIAL_ID>"
  exit 1
fi

# Assign the command-line arguments to variables
USER_NAME="$1"
API_TOKEN="$2"
JENKINS_URL="$3"
CREDENTIAL_ID="$4"

# Check if the file containing key-value pairs exists and is readable
if [ ! -r "$SECRETS_FILE_PATH" ]; then
  echo "File '$SECRETS_FILE_PATH' not found or not readable."
  exit 1
fi

# Read each line from the input file and create a credential for each key-value pair
while read line; do
  key=$(echo $line | cut -d'=' -f1)
  value=$(echo $line | cut -d'=' -f2)  

  # Construct the JSON payload for the credential
  payload="{
    \"\": \"1\",
    \"credentials\": {
      \"scope\": \"GLOBAL\",
      \"id\": \"${CREDENTIAL_ID}_${key}\",
      \"username\": \"${key}\",
      \"password\": \"${value}\",
      \"description\": \"${key} secret\",
      \"stapler-class\": \"com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl\"
    }
  }"

  # Use curl to send a POST request to the Jenkins API to create the credential
  curl -s -X POST -u "${USER_NAME}:${API_TOKEN}" "${JENKINS_URL}/credentials/store/system/domain/_/createCredentials" \
    --data-urlencode "json=${payload}" \
    --header "Content-Type:application/x-www-form-urlencoded" \
    --fail >/dev/null 2>&1 # redirect curl output to null to avoid cluttering the terminal

  # Check if the credential was created successfully
  if [ $? -eq 0 ]; then
    echo "Credential '${key}' created successfully."
  else
    echo "Failed to create credential '${key}'."
  fi
done < $SECRETS_FILE_PATH
