#!/bin/bash

# Nom du volume Docker
NOM_DU_VOLUME="sae103"

# Chemin local sur l'hôte
CHEMIN_LOCAL="/work"

# Image Docker à utiliser
IMAGE_DOCKER="clock"

# Nom du conteneur Docker
NOM_DU_CONTENEUR="sae103-forever"

# Créer le volume
docker volume create $NOM_DU_VOLUME

# Lancer le conteneur en montant le volume
docker run -v $NOM_DU_VOLUME:$CHEMIN_LOCAL $IMAGE_DOCKER -tid --name $NOM_DU_CONTENEUR

# Copie des fichiers c vers dans le volume avec le conteneur sae103-forever comme cible
docker cp *c $NOM_DU_CONTENEUR:$CHEMIN_LOCAL

# Execution des traitements dans le conteneur sae103-forever
docker exec sae103-forever sh -c "php gendoc-tech.php --dir '*c' && php gendoc-user.php"

# Création du dossier où seront déplacées les documentations format PDF puis de l'archive en format tar.gz
docker exec sae103-forever sh "nom_dossier_a_archiver"
docker exec sae103-forever sh "tar czvf nom_archive.tar.gz nom_dossier_a_archiver"

# Récupération de l'archive contenant les documentations en format PDF


# Suppression du conteneur et du volume
docker rm -v sae103-forever