FROM node:20-slim AS builder

WORKDIR /app

# Update npm to latest version and install TypeScript globally
RUN npm install -g npm@latest typescript

# Copy package files
COPY package*.json ./

# Install all dependencies (including dev dependencies)
RUN npm install --include=dev

# Copy source code and TypeScript config
COPY tsconfig.json ./
COPY src/ ./src/

# Build TypeScript
RUN npx tsc

# Make executables
RUN chmod +x dist/*.js

FROM node:20-slim

WORKDIR /app

# Copy package files and install production dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy built files from builder stage
COPY --from=builder /app/dist ./dist

# Keep the container running
ENTRYPOINT ["node", "dist/index.js"] 