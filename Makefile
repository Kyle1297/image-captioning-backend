# psql
db-dump:
	pg_dump -C -h $(host) -U $(user) $(db) > dev/db_backup/db_backup.sql

db-import:
	psql -U $(user) -d $(db) < db_backup.sql

db-shell:
	psql -U $(user) -d $(db)


# docker up/down
dev-up:
	docker-compose -f dev/docker-compose.dev.yml up -d --build

dev-down:
	docker-compose -f dev/docker-compose.dev.yml down --remove-orphans

prod-up:
	docker-compose -f prod/docker-compose.yml up -d --build

prod-down:
	docker-compose -f prod/docker-compose.yml down --remove-orphans

prod-build:
	docker-compose -f prod/docker-compose.yml build


# aws ecr
ecr-login:
	aws ecr get-login-password --region $(reg) | \
	docker login --username AWS --password-stdin $(pw)

push-backend:
	docker push $(rep):backend

push-nginx:
	docker push $(rep):nginx-proxy

pull-backend:
	docker pull $(rep):backend

pull-nginx:
	docker pull $(rep):nginx-proxy


# ssh transfer and login
scp-transfer:
	scp -i $(pw) -r app scripts prod poetry.lock pyproject.toml ubuntu@3.24.64.126:/home/ubuntu/backend

ssh-login:
	ssh -i $(pw) ubuntu@3.24.64.126


# docker shells
backend-shell:
	docker exec -it backend /bin/bash

db-shell:
	docker exec -it db /bin/bash


# django
migrate:
	python manage.py migrate

makemigrations:
	python manage.py makemigrations

superuser:
	python manage.py createsuperuser

collectstatic:
	python manage.py collectstatic --no-input


# git
git-push:
	git push origin HEAD