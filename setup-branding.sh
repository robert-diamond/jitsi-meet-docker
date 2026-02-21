#!/bin/bash

echo "Extracting Jitsi Meet web files..."

# Create directory
mkdir -p jitsi-meet-web

# Extract from Docker image
docker run --rm -v "$(pwd)/jitsi-meet-web:/output" jitsi/web:unstable sh -c "cp -r /usr/share/jitsi-meet/* /output/"

echo "Applying Kanvene branding..."

cd jitsi-meet-web

# Replace "Jitsi Meet" with "Kanvene" in HTML files
find . -type f -name "*.html" -exec sed -i.bak 's/Jitsi Meet/Kanvene/g' {} +

# Replace in JSON language files
find . -type f -name "*.json" -exec sed -i.bak 's/"Jitsi Meet"/"Kanvene"/g' {} +
find . -type f -name "*.json" -exec sed -i.bak 's/"title": "Jitsi Meet"/"title": "Kanvene"/g' {} +

# Replace jitsi.org links with kanvene.com
find . -type f \( -name "*.html" -o -name "*.js" \) -exec sed -i.bak 's/https:\/\/jitsi\.org/https:\/\/kanvene.com/g' {} +

# Update interface_config.js if it exists
if [ -f "interface_config.js" ]; then
    echo "Updating interface_config.js..."
    sed -i.bak "s/APP_NAME: '[^']*'/APP_NAME: 'Kanvene'/g" interface_config.js
    sed -i.bak "s/NATIVE_APP_NAME: '[^']*'/NATIVE_APP_NAME: 'Kanvene'/g" interface_config.js
    sed -i.bak "s/PROVIDER_NAME: '[^']*'/PROVIDER_NAME: 'Kanvene'/g" interface_config.js
    sed -i.bak "s/JITSI_WATERMARK_LINK: '[^']*'/JITSI_WATERMARK_LINK: 'https:\/\/kanvene.com'/g" interface_config.js
fi

# Clean up backup files
find . -name "*.bak" -delete

cd ..

echo "✓ Branding applied successfully!"
echo ""
echo "Next steps:"
echo "1. Review the changes in ./jitsi-meet-web/"
echo "2. Replace images/watermark.svg with your logo"
echo "3. Start the containers: docker-compose up -d"
