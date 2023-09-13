#!/bin/bash

# Create a shared group if it doesn't exist
if ! grep -q "^airflowgroup:" /etc/group; then
    sudo groupadd airflowgroup
fi

# Add the current user to the shared group
sudo usermod -aG airflowgroup $(whoami)

# Set the ownership to UID 50000 and the shared group
sudo chown -R 50000:airflowgroup /var/opt/airflow/

# Set the permissions to allow both the owner (UID 50000) and the group members to read, write, and execute
# Directories
sudo find /var/opt/airflow/ -type d -exec chmod 775 {} \;
# Files
sudo find /var/opt/airflow/ -type f -exec chmod 664 {} \;

echo "Permissions set successfully. You might need to re-login for group changes to take effect."

