FROM node:bookworm-slim

ENV NODE_ENV=production

WORKDIR /app

# Copy package files
COPY package*.json ./

# Copy local vendor dependencies BEFORE npm install
COPY vendor/ ./vendor/

# Install dependencies
RUN npm install --omit=dev

# Copy the rest of the application
COPY . .

# Start the browser server
CMD ["node", "src/server.js"]
