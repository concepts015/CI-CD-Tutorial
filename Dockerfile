FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json /app
RUN npm install
COPY . .
RUN npm run build

FROM node:18-alpine AS runner
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./dist
RUN npm install
EXPOSE 8080
CMD ["node", "dist/index.js"]