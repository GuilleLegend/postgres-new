FROM node:${NODE_VERSION}

WORKDIR /app

COPY package*.json ./

RUN npm cache clean --force && \
    npm install -g npm@latest && \
    npm ci

COPY . .

ENV NIXPACKS_PATH /app/node_modules/.bin:$NIXPACKS_PATH

CMD ["npm", "start"]
