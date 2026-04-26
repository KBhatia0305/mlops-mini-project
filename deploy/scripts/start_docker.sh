#!/bin/bash
# Login to AWS ECR
aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 825765400473.dkr.ecr.ap-southeast-2.amazonaws.com

# Pull the latest image
docker pull 825765400473.dkr.ecr.ap-southeast-2.amazonaws.com/krishna_ecr:latest

# Check if the container 'campusx-app' is running
if [ "$(docker ps -q -f name=krishna-app3)" ]; then
    # Stop the running container
    docker stop krishna-app3
fi

# Check if the container 'campusx-app' exists (stopped or running)
if [ "$(docker ps -aq -f name=krishna-app3)" ]; then
    # Remove the container if it exists
    docker rm krishna-app3
fi

# Run a new container
docker run -d -p 80:5000 --name krishna-app3 -e DAGSHUB_PAT=11cbae983d8ee9955e72237e5a6019f8ebd8796b 825765400473.dkr.ecr.ap-southeast-2.amazonaws.com/krishna_ecr:latest