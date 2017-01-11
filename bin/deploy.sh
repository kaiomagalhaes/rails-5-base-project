#!/usr/bin/env bash

echo "inserting the image version in docker-compose template"
bash -c 'sed -i "s/kaiomagalhaes\/rails-base-project/kaiomagalhaes\/rails-base-project:$VERSION/" config/docker-compose.yml.template'

echo "creating projects folder if it doesn't exist"
ssh $DEPLOY_USER@$DEPLOY_HOST 'mkdir -p projects/rails-base-project/config'

echo "copying docker-compose"
scp config/docker-compose.yml.template $DEPLOY_USER@$DEPLOY_HOST:projects/rails-base-project/config/docker-compose.yml.backend

echo "pulling latest version of the code"
ssh $DEPLOY_USER@$DEPLOY_HOST "docker-compose -f projects/rails-base-project/config/docker-compose.yml.backend pull rails-base-project"

echo "creating network"
ssh $DEPLOY_USER@$DEPLOY_HOST 'if [ $(docker network ls | grep NETWORK_NAME | wc -l) -gt 0 ]; then echo "network already exists"; else docker network create NETWORK_NAME ; fi'

echo "starting the new version"
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker-compose -f projects/rails-base-project/config/docker-compose.yml.backend up -d rails-base-project'

echo "removing old and unsed images"
ssh $DEPLOY_USER@$DEPLOY_HOST "docker images --filter 'dangling=true' --format '{{.ID}}' | xargs docker rmi"

echo "success!"

exit 0
