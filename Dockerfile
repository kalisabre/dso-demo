FROM maven:3.6-jdk-8 AS build
WORKDIR /app
COPY .  .
RUN mvn package -DskipTests

FROM openjdk:18-alpine AS run
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /run/demo.jar

# Set user
ARG USER=devops
ENV HOME /home/$USER
RUN adduser -D $USER && chown $USER:$USER /run/demo.jar 

EXPOSE 8080
CMD java  -jar /run/demo.jar