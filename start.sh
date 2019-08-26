#docker-compose down; docker-compose build && docker-compose up -d --force-recreate
mkdir -p config/tunnel; docker-compose down; docker-compose up -d --force-recreate
