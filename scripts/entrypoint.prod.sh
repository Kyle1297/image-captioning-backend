#!/bin/bash

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres...\n"

    while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
        sleep 0.1
    done

    echo "PostgreSQL started"
fi

echo "\nSetting up database...\n"
python manage.py migrate

exec "$@"