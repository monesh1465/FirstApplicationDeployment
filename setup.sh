#!/bin/bash

# Jenkins Deployment Script

# Step 1: Update the package manager and install Java
echo "Updating package manager and installing Java..."
sudo apt update
sudo apt install openjdk-17-jdk -y

# Verify Java installation
echo "Verifying Java installation..."
java --version

# Step 2: Add Jenkins repository key and source
echo "Adding Jenkins repository key and source..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Step 3: Update the package manager and install Jenkins
echo "Installing Jenkins..."
sudo apt-get update
sudo apt-get install fontconfig openjdk-17-jre -y
sudo apt-get install jenkins -y

# Step 4: Start Jenkins service and enable it to start on boot
echo "Starting Jenkins service and enabling it to start on boot..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Step 5: Configure AWS Security Group for port 8080
echo "Ensure that port 8080 is allowed in your AWS Security Group settings."
echo "Manually update the security group for your EC2 instance to allow inbound traffic on port 8080 (HTTP)."
echo "You can do this via the AWS Management Console:"
echo "1. Navigate to EC2 > Security Groups."
echo "2. Select the security group associated with your EC2 instance."
echo "3. Edit inbound rules to add a rule for port 8080 with source set to 0.0.0.0/0 or your preferred IP range."

# Step 6: Retrieve the initial admin password
echo "Retrieving Jenkins initial admin password..."
PASSWORD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo "Jenkins initial admin password: $PASSWORD"

# Step 7: Provide instructions for accessing Jenkins
echo "Access Jenkins at: http://$PUBLIC_IP:8080"
echo "Use the retrieved password to log in and complete the setup process."