# Étape 1 : Utiliser une image Java officielle comme base
FROM openjdk:17-jdk-slim

# Étape 2 : Créer un répertoire pour l'application
WORKDIR /app

# Étape 3 : Copier le fichier JAR généré par votre projet
COPY target/vacances-tranquilles-0.0.1-SNAPSHOT.jar app.jar

# Étape 4 : Exposer le port sur lequel votre application écoute
EXPOSE 8082

# Étape 5 : Définir la commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
