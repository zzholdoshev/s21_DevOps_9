#!/bin/bash


# Get all images that start with "services-"
images=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep "^services-")

# Loop through each image
for image in $images; do
    # Extract the name after "services-"
    # Create the new name by appending "_service"
		new_name="$(echo "${image}" | cut -d'-' -f2 | cut -d':' -f1)_service"

    # Tag the image
    echo "Tagging $image as $new_name..."
    docker tag "$image" "maelysje/$new_name"
    
    # Push the new image to Docker Hub
    echo "Pushing $new_name to Docker Hub..."
    docker push "maelysje/$new_name"
done

echo "All images have been pushed."
