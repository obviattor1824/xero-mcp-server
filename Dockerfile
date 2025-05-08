FROM node:20-slim

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Make the entry point executable
RUN chmod +x dist/index.js

# Set the entry point
ENTRYPOINT ["node", "dist/index.js"] 