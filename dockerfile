# Stage 1: Build Stage
FROM node:20-alpine as build
WORKDIR /app
COPY package.json package-lock.json ./
# Install dependencies
RUN npm install
# Copy source code
COPY . .
# Run build command (if needed, for Node.js this is often just a copy)
# RUN npm run build 

# Stage 2: Production Stage (Smaller base image)
FROM node:20-alpine
WORKDIR /app
# Copy built artifacts/dependencies from the build stage
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/server.js .

EXPOSE 3000
CMD ["node", "server.js"]
