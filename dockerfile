# Use the official Node.js image as the base image
FROM node:14-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Build the React app
RUN npm run build

# Use a smaller base image for serving the built app
FROM nginx:alpine

# Copy the built React app to the Nginx web server
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
