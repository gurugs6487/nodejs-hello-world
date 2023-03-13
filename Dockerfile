FROM node:14-alpine
WORKDIR /app
COPY package*.json ./
COPY . .
EXPOSE 80
CMD ["npm", "start"]
