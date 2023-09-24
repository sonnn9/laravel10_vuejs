# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of your application to the container
COPY . .

# Expose the port your Vue.js app will run on (e.g., 8080)
EXPOSE 8080

# Define the command to run your Vue.js app
CMD ["npm", "run", "serve"]
