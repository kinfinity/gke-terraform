FROM node:20-alpine
ARG APP_NAME

# Create a non-root user to run the application
RUN addgroup -g 1001 -S appuser && \
    adduser -u 1001 -S appuser -G appuser

WORKDIR /app
COPY /${APP_NAME}/package*.json ./

# Install dependencies
RUN npm install --quiet

COPY /${APP_NAME} .

# Build the Next.js application
RUN npm run build
EXPOSE 3000

# Set user as default
USER appuser

# Run Application
CMD ["npm", "start"]
