FROM node:20-alpine

WORKDIR /usr/src/app
ENV NODE_ENV=production

COPY app/package*.json ./
RUN apk update && apk upgrade --no-cache && \
    npm ci --omit=dev && \
    npm cache clean --force
    rm -f package.json package-lock.json

COPY app/src ./src

EXPOSE 3000

USER node
CMD ["node", "src/server.js"]
