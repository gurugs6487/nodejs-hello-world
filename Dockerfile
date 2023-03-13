FROM node:14-alpine
COPY package*.json /usr/src/app
RUN npm install
COPY . /usr/src/app
EXPOSE 80
CMD [ "node", "index.js" ]
