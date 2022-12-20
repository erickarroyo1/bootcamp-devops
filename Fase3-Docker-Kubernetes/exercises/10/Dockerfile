FROM node:16-alpine
WORKDIR /app
LABEL project="docker-bootcamp-devops"
LABEL owner="Erick"
COPY ./ /app/
RUN npm install
EXPOSE 4000
CMD ["npm","start"]