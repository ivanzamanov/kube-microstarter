FROM openjdk:8-jre-slim

ARG ARTIFACT=${project.build.finalName}.jar
WORKDIR /opt/app
ADD /maven/$ARTIFACT /opt/app/$ARTIFACT

ENV ARTIFACT=$ARTIFACT

ENV JAVA_OPTS=-Xmx256m

CMD java $JAVA_OPTS -jar /opt/app/$ARTIFACT
