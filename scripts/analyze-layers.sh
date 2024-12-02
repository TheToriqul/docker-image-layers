#!/bin/bash

echo "Docker Image Layer Analysis Script"
echo "================================="

# Function to analyze image layers
analyze_image() {
    local image_name=$1
    echo "Analyzing layers for image: $image_name"
    echo
    
    echo "Layer History:"
    docker history "$image_name" --no-trunc --format "table {{.ID}}\t{{.Size}}\t{{.CreatedBy}}"
    echo
    
    echo "Layer Details:"
    docker image inspect "$image_name" --format '{{ range .RootFS.Layers }}{{ . }}{{ "\n" }}{{ end }}'
    echo
}

# Function to check shared layers
check_shared_layers() {
    echo "Checking shared layers between images..."
    docker system df -v
}

# Main execution
if [ "$1" ]; then
    analyze_image "$1"
else
    echo "Usage: $0 <image_name>"
    echo "Example: $0 ubuntu:latest"
    exit 1
fi