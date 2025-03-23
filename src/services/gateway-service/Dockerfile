# Dockerfile for Session Service
FROM openjdk:8-jdk-alpine

# Set working directory
WORKDIR /gateway_service

COPY . .
RUN chmod +x wait-for-it.sh

# Build the application
RUN apk update && apk add bash \
&& apk add maven
RUN mvn -B dependency:go-offline
RUN mvn -N io.takari:maven:wrapper
RUN mvn -B package -DskipTests
# Define environment variables
ENV SESSION_SERVICE_HOST=session_service
ENV SESSION_SERVICE_PORT=8081
ENV HOTEL_SERVICE_HOST=hotel_service
ENV HOTEL_SERVICE_PORT=8082
ENV BOOKING_SERVICE_HOST=booking_service
ENV BOOKING_SERVICE_PORT=8083
ENV PAYMENT_SERVICE_HOST=payment_service
ENV PAYMENT_SERVICE_PORT=8084
ENV LOYALTY_SERVICE_HOST=loyalty_service
ENV LOYALTY_SERVICE_PORT=8085
ENV REPORT_SERVICE_HOST=report_service
ENV REPORT_SERVICE_PORT=8086

# Run the application
ENTRYPOINT ["/bin/bash", "-c", "./wait-for-it.sh -s -t 120 postgres:5432 -- && ./wait-for-it.sh -s -t 120 rabbitmq:5672 -- && java -jar ./target/*.jar"]

