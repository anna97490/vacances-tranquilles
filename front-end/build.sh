#!/bin/bash

IMAGE_NAME=vacances-tranquilles/front-end
IMAGE_TAG_CURRENT=0.0.0

# Nettoyer et installer les dépendances
echo "### Installation des dépendances Angular"
npm install

# Construire le projet Angular
echo "### Construction du projet Angular"
npm run build --prod

# Construire l'image Docker
echo "### Build new image ${IMAGE_NAME}:${IMAGE_TAG_CURRENT}"
docker build --no-cache --tag ${IMAGE_NAME}:${IMAGE_TAG_CURRENT} .


