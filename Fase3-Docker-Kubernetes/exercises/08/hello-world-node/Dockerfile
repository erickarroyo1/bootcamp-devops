# From Image node
FROM node:alpine3.16
# Working Directory
WORKDIR /app
# Copy index and package json into docker.
COPY ./index.html /app/
COPY ./server.js /app/
COPY ./package.json /app/
COPY ./.eslintrc.js /app/
# Installing dependencies using package.json for node app
RUN npm install
# Expose por 3000
EXPOSE 3000
# Run js into docker when docker run
CMD [ "node", "server.js" ]
