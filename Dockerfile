# Use Debian-based image (Stabler for Strapi/Sharp than Alpine)
FROM node:18-slim

# Install system dependencies for Sharp/Image processing
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    autoconf \
    automake \
    zlib1g-dev \
    libpng-dev \
    libvips-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set production environment
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

# Create app directory
WORKDIR /opt/app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies (using 'npm install' to ensure Linux binaries for Sharp)
RUN npm install -g node-gyp
RUN npm config set fetch-retry-maxtimeout 600000 -g
RUN npm install --only=production

# Copy the rest of the application code
COPY . .

# Build the Admin Panel
RUN npm run build

# Expose the port
EXPOSE 1337

# Start the application
CMD ["npm", "run", "start"]