FROM eclipse-temurin:21  
WORKDIR /app  
COPY target/devsecops-demo-1.0.0-SNAPSHOT.jar app.jar  
RUN jar tf app.jar | grep dexter || true
EXPOSE 8080  
#ENTRYPOINT ["java", "-jar", "app.jar"]  
ENTRYPOINT ["java", "-cp", "app.jar", "com.steady.App"]