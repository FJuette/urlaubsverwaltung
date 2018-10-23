# Urlaubsverwaltung Container

Docker Container für **synyx Urlaubsverwaltung** (https://github.com/synyx/urlaubsverwaltung) mit Active Directory Konfiguration. 

Das verwendete JAR-Paket stammt direkt von Github (link siehe *Dockerfile*) und wurde für die Verwendung im Container nicht verändert.

# Run

Der fertige Container steht unter https://hub.docker.com/r/fjuette/urlaubsverwaltung/ bereit.
Es wird empfohlen die Anwendung z. B. über *docker-compose* in Kombination mit einer MariaDB und allen dafür nötigen Umgebungsvariablen zu starten.

Die beiliegende *docker-compose.yaml* bietet dafür eine gute Basis und kann ohne weitere Anpassugen verwendet werden.

## Konfiguration

Aktuell wird die hinterlegte *application.properties* in den Container eingebunden, welche Platzhalter für bestimmte Konfigurationsabschnitte bietet. 
Eine vollständige Liste aller Konfigurationsparameter für die Urlaubsverwaltung bietet der Abschnitt [Umgebungsvariablen](#Umgebungsvariablen).

## Überschreiben der Konfiguration

Für die eigene Konfiguration können die Werte der hinterlegten *docker-compose.yaml* mittels einer docker-compose.override.yaml in teilen überschrieben werden, z. B.:

```yaml
version: '3.4'

services:
   urlaubsverwaltung:
     environment: 
       AUTHENTICATION: activeDirectory
       UV_SECURITY_FILTER_MEMEBEROF: 
       AD_DOMAIN: example.de
       AD_URL: ldap://ad-example.de/
       SYNC_USER_SEARCH_BASE: OU=Example,OU=Mitarbeiter,DC=example,DC=de
       SNYC_USER_DN: CN=ad-sync,OU=Example,OU=xyz,DC=example,DC=de
       SYNC_PASSWORD: secret
volumes:
  db-data:
```

### Umgebungsvariablen (ENVs)

Liste aller verfügbaren ENVs, welche entsprechende Platzhalter in der *application.properties* haben:

```yaml
MYSQL_DB_HOST: db # FQDN vom Datenbankserver oder Name vom Container der Datenbank  
MYSQL_DB_NAME: urlaubsverwaltung # Name der Datenbank
MYSQL_DB_USER: urlaubsverwaltung # MySQL Benutzer
MYSQL_DB_PASSWORD: password # Passwort des Nutzers
AUTHENTICATION: activeDirectory # Art des Authentifizierungsproviders (default, activeDirectory, ldap [vgl. https://github.com/synyx/urlaubsverwaltung#authentifizierung])
UV_SECURITY_FILTER_MEMEBEROF: # Optional: Filter, welche Nutzer beachtet werden
AD_DOMAIN: # Name der Domain, z. B. example.de
AD_URL: # URL zum Active Directory, z. B. ldap://ad-example.de/
SYNC_USER_SEARCH_BASE: # Pfad, welche Nutzer synchronisiert werden, z. B. OU=Example,OU=Mitarbeiter,DC=example,DC=de
SNYC_USER_DN: # Nutzer, welcher zum Synchronisieren verwendet werden kann, z. B. CN=ad-sync,OU=Example,OU=xyz,DC=example,DC=de
SYNC_PASSWORD: # Passwort für den Sync Nutzer
```

# Entwicklung

## Build vom Container

1. Anpassen der *Dockerfile* (z. B. Version, welche über wget geladen wird aktualiseren) und/oder der *application.properties*
2. Optionaler lokaler build und ggf. push des Containers

```shell
docker build -t fjuette/urlaubsverwaltung .
docker push fjuette/urlaubsverwaltung
```

## Weitere ENV

Bisher sind die ENV nur für die Verwendung mittel AD vorbereitet, weitere können jedoch einfach in der *application.properties* ergänzt werden. 
Weitere ENVs bitte über eine Issue oder ein Pull request anfragen/hinzufügen.