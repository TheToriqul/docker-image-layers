# Docker Image Layer Architecture Command Reference Guide

### Project content table
- [Section 1: Project Setup](#section-1-project-setup)
- [Section 2: Core Project Workflow](#section-2-core-project-workflow)
- [Section 3: Advanced Operations](#section-3-advanced-operations)
- [Section 4: Production Guide](#section-4-production-guide)

> **Author**: [Md Toriqul Islam](https://linkedin.com/in/thetoriqul)  
> **Description**: Comprehensive command reference for Docker image layer management  
> **Learning Focus**: Docker architecture, layer optimization, and multi-platform deployment  
> **Note**: This is a reference guide. Do not execute commands without understanding their implications.

## Section 1: Project Setup

### Initial Setup
```bash
# Clone the repository
git clone https://github.com/TheToriqul/docker-image-layers.git
cd docker-image-layers

# Set up environment
cp .env.example .env

# Make scripts executable
chmod +x scripts/*.sh

# Start demo containers
docker-compose up -d
```

## Section 2: Core Project Workflow

### Layer Analysis Script Usage
```bash
# Run layer analysis for Ubuntu
./scripts/analyze-layers.sh ubuntu:latest

# Run layer analysis for Alpine
./scripts/analyze-layers.sh alpine:latest

# Verify script output
docker history ubuntu:latest
```

### Multi-Architecture Demo
```bash
# Run multi-architecture demonstration
./scripts/multi-arch-demo.sh golang:latest

# Verify platform support
docker run --rm --platform linux/amd64 golang:latest uname -m
```

### Docker Compose Operations
```bash
# Start all demo containers
docker-compose up -d

# Check container status
docker-compose ps

# Access Ubuntu container
docker-compose exec demo-ubuntu bash

# Access Alpine container
docker-compose exec demo-alpine sh

# Stop all containers
docker-compose down
```

## Section 3: Advanced Operations

### Layer Management
```bash
# Enable experimental features
export DOCKER_CLI_EXPERIMENTAL=enabled

# Inspect manifest list
docker manifest inspect golang \
    --verbose

# Create manifest list
docker manifest create \
    myimage:latest \
    myimage-amd64:latest \
    myimage-arm64:latest

# Push manifest list
docker manifest push myimage:latest
```

### Storage Analysis
```bash
# View detailed storage information
docker system df -v

# Check image layers
docker history ubuntu:latest --no-trunc

# Analyze shared layers
docker system df --format "{{.Type}}: {{.Size}}"
```

## Section 4: Production Guide

### Security Configuration
```bash
# Enable content trust
export DOCKER_CONTENT_TRUST=1

# Verify image signatures
docker trust inspect myimage:latest

# Pull verified images
docker pull myimage:latest
```

### Cleanup Operations
```bash
# Remove demo containers
docker-compose down --rmi all

# Clean up unused images
docker image prune -a

# Remove all unused objects
docker system prune -a --volumes
```

### Monitoring
```bash
# Monitor container resources
docker stats

# View build cache usage
docker builder prune --filter until=24h

# Check system storage
docker system df -v
```

## Learning Notes

1. Use `analyze-layers.sh` to understand layer composition
2. `multi-arch-demo.sh` demonstrates cross-platform capabilities
3. Docker Compose simplifies multi-container testing
4. Layer sharing reduces storage usage
5. Regular cleanup maintains system efficiency

---

> 💡 **Best Practice**: Always use version-controlled scripts for consistent analysis

> ⚠️ **Warning**: Clean up operations can affect multiple containers and images

> 📝 **Note**: Some commands require root privileges or experimental features