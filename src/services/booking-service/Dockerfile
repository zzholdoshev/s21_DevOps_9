# Dockerfile for Session Service
FROM openjdk:8-jdk-alpine

# Set working directory
WORKDIR /booking_service

COPY . .

RUN chmod +x wait-for-it.sh
#EXPOSE 8083

# Build the application
RUN apk update && apk add bash \
&& apk add maven
RUN mvn -B dependency:go-offline
RUN mvn -N io.takari:maven:wrapper
RUN mvn -B package -DskipTests
# Define environment variables
ENV POSTGRES_HOST: postgres
ENV POSTGRES_PORT: 5432
ENV POSTGRES_USER : postgres
ENV POSTGRES_PASSWORD: "postgres"
ENV POSTGRES_DB: reservations_db
ENV RABBIT_MQ_HOST: rabbitmq
ENV RABBIT_MQ_PORT: 5672
ENV RABBIT_MQ_USER: guest
ENV RABBIT_MQ_PASSWORD: guest
ENV RABBIT_MQ_QUEUE_NAME: messagequeue
ENV RABBIT_MQ_EXCHANGE: messagequeue-exchange
ENV HOTEL_SERVICE_HOST: hotel_service
ENV HOTEL_SERVICE_PORT: 8082
ENV PAYMENT_SERVICE_HOST: payment_service
ENV PAYMENT_SERVICE_PORT: 8084
ENV LOYALTY_SERVICE_HOST: loyalty_service
ENV LOYALTY_SERVICE_PORT: 8085



# Run the application
ENTRYPOINT ["/bin/bash", "-c", "./wait-for-it.sh -s -t 120 postgres:5432 -- && ./wait-for-it.sh -s -t 120 rabbitmq:5672 -- && java -jar ./target/*.jar"]
