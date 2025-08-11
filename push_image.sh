#!/bin/bash

# Exit immediately if a command fails
set -e

# Parameters
IMAGE_NAME=$1       # Example: myusername/myapp
IMAGE_TAG=$2        # Example: dev or test

if [ -z "$IMAGE_NAME" ] || [ -z "$IMAGE_TAG" ]; then
    echo "Usage: ./push_image.sh <image_name> <tag>"
    exit 1
fi

# Login to Docker Hub (you can also use Jenkins credentials for this)
echo "Logging in to Docker Hub..."
docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"

# Tag the image
FULL_IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"
echo "Tagging image as $FULL_IMAGE"
docker tag "${IMAGE_NAME}:${IMAGE_TAG}" "$FULL_IMAGE"

# Push the image
echo "Pushing image to Docker Hub..."
docker push "$FULL_IMAGE"

echo "✅ Image pushed successfully: $FULL_IMAGE"
