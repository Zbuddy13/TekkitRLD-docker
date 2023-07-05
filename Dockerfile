FROM eclipse-temurin:8-jdk-alpine

#Sets up the workspace
VOLUME ["/data"]
WORKDIR /

#Updates the container and installs dependencies
RUN apk update
RUN apk add --no-cache zip unzip wget bash curl

#Exposes the server port, the rcon port, and copies scripts
EXPOSE 25565/tcp
EXPOSE 25575/tcp
COPY prep.sh .

#Sets default java arguments
ENV JAVA_ARGS="-Xms1024m -Xmx4096m"
ENV RCON_PASS="changeme"

#Sets permissions for scripts and runs prep.sh
RUN chmod +x prep.sh
CMD ["./prep.sh"]
