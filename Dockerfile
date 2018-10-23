FROM java:8
RUN mkdir /urlaub
WORKDIR /urlaub
RUN wget https://github.com/synyx/urlaubsverwaltung/releases/download/urlaubsverwaltung-2.28.0/urlaubsverwaltung-2.28.0.jar
ADD application.properties application.properties
EXPOSE 8080
CMD java -jar urlaubsverwaltung-2.28.0.jar