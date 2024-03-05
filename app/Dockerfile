FROM node:20-alpine
ARG APP_NAME

WORKDIR /app
COPY /${APP_NAME}/package*.json ./

# Install dependencies
RUN npm install

COPY /${APP_NAME} .

# Build the Next.js application
RUN npm run build
EXPOSE 3000

# Run Application
CMD ["npm", "start"]
