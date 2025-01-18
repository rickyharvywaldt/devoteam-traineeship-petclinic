FROM maven:3.6.3-jdk-11-slim AS build

WORKDIR /app

COPY pom.xml .
COPY src/ ./src/

RUN mvn clean package -DskipTests

FROM --platform=linux/amd64 tomcat:9.0.91-jdk11-temurin-jammy

COPY --from=build /app/target/petclinic.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
