# Dockerfile for Session Service
FROM openjdk:8-jdk-alpine

# Set working directory
WORKDIR /loyalty_service


COPY . .
RUN chmod +x wait-for-it.sh
#EXPOSE 8085
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
ENV POSTGRES_DB: balances_db

# Run the application
ENTRYPOINT ["/bin/bash", "-c", "./wait-for-it.sh -s -t 120 postgres:5432 -- && ./wait-for-it.sh -s -t 120 rabbitmq:5672 -- && java -jar ./target/*.jar"]

