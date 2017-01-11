#!/usr/bin/env bash

echo "inserting the image version in docker-compose template"
bash -c 'sed -i "s/DOCKERHUB_COMPANY_NAME\/PROJECT_NAME/DOCKERHUB_COMPANY_NAME\/PROJECT_NAME:$VERSION/" config/docker-compose.yml.template'

echo "creating projects folder if it doesn't exist"
ssh $DEPLOY_USER@$DEPLOY_HOST 'mkdir -p projects/PROJECT_NAME/config'

echo "copying docker-compose"
scp config/docker-compose.yml.template $DEPLOY_USER@$DEPLOY_HOST:projects/PROJECT_NAME/config/docker-compose.yml.backend

echo "copying env file"
scp .env $DEPLOY_USER@$DEPLOY_HOST:projects/PROJECT_NAME/config/.env

echo "pulling latest version of the code"
ssh $DEPLOY_USER@$DEPLOY_HOST "docker-compose -f projects/PROJECT_NAME/config/docker-compose.yml.backend pull PROJECT_NAME"

echo "creating network if needed"
ssh $DEPLOY_USER@$DEPLOY_HOST 'if [ $(docker network ls | grep NETWORK_NAME | wc -l) -gt 0 ]; then echo "network already exists"; else docker network create NETWORK_NAME ; fi'

echo "creating db network if needed"
ssh $DEPLOY_USER@$DEPLOY_HOST 'if [ $(docker ps -a | grep PROJECT_NAME-db | wc -l) -gt 0 ]; then echo "db already exists"; else docker-compose -f projects/PROJECT_NAME/config/docker-compose.yml.backend up -d PROJECT_NAME-db ; fi'

echo "starting the new version"
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker-compose -f projects/PROJECT_NAME/config/docker-compose.yml.backend up -d PROJECT_NAME'

echo "removing old and unsed images"
ssh $DEPLOY_USER@$DEPLOY_HOST "docker images --filter 'dangling=true' --format '{{.ID}}' | xargs docker rmi"

echo "success!"

exit 0
