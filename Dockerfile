# Use the officially supported Eclipse Temurin image for Java 17
FROM eclipse-temurin:17-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled JAR file from the target directory into the container
COPY target/*.jar app.jar

# Expose the default Eureka Server port
EXPOSE 8761

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]