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

pull-backend:
	docker pull $(rep):backend


# ssh transfer and login
scp-transfer:
	scp -i $(pw) -r app scripts prod poetry.lock pyproject.toml ec2-user@3.25.23.208:/home/ec2-user/backend

ssh-login:
	ssh -i $(pw) ec2-user@3.25.23.208


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


# ecs
create-task-definition:
	aws ecs register-task-definition --cli-input-json file://./prod/ecs/task_definition.json

create-service:
	aws ecs create-service --cli-input-json file://ecs_service.json

ssm-secrets:
	aws ssm get-parameters-by-path --path $(SECRET_PATH) --query "Parameters[*].{name:Name,valueFrom:ARN}"| \
	jq --arg replace $(SECRET_PATH) 'walk(if type == "object" and has("name") then .name |= gsub($replace;"") else . end)'