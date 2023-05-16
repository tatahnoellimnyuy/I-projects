#!/bin/bash

# FTP server details
HOST="45.79.141.222"
USERNAME="toxic"
PASSWORD="Jesuisroot123@"

# Directory on the FTP server to upload the code to
REMOTE_DIR="~/"

# Local directory containing the PHP code to be deployed
LOCAL_DIR="./"

# FTP deployment using lftp
lftp -c "open -u $USERNAME,$PASSWORD $HOST; mirror --reverse --delete --verbose $LOCAL_DIR $REMOTE_DIR"
