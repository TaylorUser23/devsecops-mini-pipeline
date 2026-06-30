FROM node:20-alpine

WORKDIR /usr/src/app
ENV NODE_ENV=production

COPY app/package*.json ./
RUN npm install --omit=dev

COPY app/src ./src

EXPOSE 3000

USER node
CMD ["node", "src/server.js"]
