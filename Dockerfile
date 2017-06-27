# Create image based on the official Node 6 image from dockerhub
FROM node:6

# Create a directory where our app will be placed
RUN mkdir -p /usr/src/app

# Change directory so that our commands run inside this new directory
WORKDIR /usr/src/app

# Copy dependency definitions
COPY package.json /usr/src/app

# Set proxy
ARG HTTP_PROXY
ARG HTTPS_PROXY
RUN npm config set proxy $HTTP_PROXY
RUN npm config set http_proxy $HTTP_PROXY
RUN npm config set https_proxy $HTTPS_PROXY

# Install dependecies
RUN npm install

# Get all the code needed to run the app
COPY . /usr/src/app

# Expose the port the app runs in
EXPOSE 4200

# Serve the app
ENV public_host 127.0.0.1
#CMD ["npm", "start"]
CMD npm start -- -host 0.0.0.0 --public ${public_host}

