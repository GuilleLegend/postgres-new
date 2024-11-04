FROM node:${NODE_VERSION}

WORKDIR /app

COPY package*.json ./

# Instala wget y curl si los necesitas
RUN apt-get update && \
    apt-get install -y wget curl && \
    rm -rf /var/lib/apt/lists/*

# Intenta instalar las dependencias normales
RUN npm cache clean --force && \
    npm install -g npm@latest && \
    npm ci

# Si falla la instalación anterior, intenta instalar manualmente @std/tar
RUN if [ $? -ne 0 ]; then \
    echo "Fallo al instalar dependencias. Intentando instalar @std/tar manualmente"; \
    npm install https://github.com/jsr/std__tar/archive/v0.1.1.tar.gz; \
    fi

COPY . .

ENV NIXPACKS_PATH /app/node_modules/.bin:$NIXPACKS_PATH

CMD ["npm", "start"]
