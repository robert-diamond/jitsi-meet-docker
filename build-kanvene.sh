#!/bin/bash

# Build Kanvene-branded Jitsi image
docker build -f Dockerfile.kanvene \
  -t kanvene/jitsi-web:latest \
  -t kanvene/jitsi-web:v1.0 \
  .

if [ $? -eq 0 ]; then
  echo "✓ Build successful!"
  echo ""
  echo "Built images:"
  docker images | grep kanvene/jitsi-web
  echo ""
  echo "Next steps:"
  echo "1. Test locally: docker run -it -p 8080:80 kanvene/jitsi-web:latest"
  echo "2. Push to Docker Hub: docker push kanvene/jitsi-web:latest"
  echo "3. Deploy to Coolify with custom image URI"
else
  echo "✗ Build failed!"
  exit 1
fi
