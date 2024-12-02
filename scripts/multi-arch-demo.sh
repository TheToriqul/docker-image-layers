#!/bin/bash

echo "Multi-Architecture Support Demo"
echo "=============================="

# Enable experimental features
export DOCKER_CLI_EXPERIMENTAL=enabled

# Function to inspect manifest
inspect_manifest() {
    local image_name=$1
    echo "Inspecting manifest for: $image_name"
    docker manifest inspect "$image_name" | grep -E "architecture|os"
}

# Function to demonstrate platform support
show_platform_support() {
    local image_name=$1
    echo "Running image on different platforms:"
    
    # Try AMD64
    echo "AMD64:"
    docker run --rm --platform linux/amd64 "$image_name" uname -m
    
    # Try ARM64
    echo "ARM64:"
    docker run --rm --platform linux/arm64 "$image_name" uname -m 2>/dev/null || echo "Platform not supported"
}

# Main execution
if [ "$1" ]; then
    inspect_manifest "$1"
    show_platform_support "$1"
else
    echo "Usage: $0 <image_name>"
    echo "Example: $0 golang:latest"
    exit 1
fi