#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres...\n"

    while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
        sleep 0.1
    done

    echo "PostgreSQL started"
fi

echo "\nSetting up database..."
python manage.py flush --no-input
docker exec db bash -c "psql -U $POSTGRES_USER -d $POSTGRES_DB < db_backup.sql"
python manage.py migrate 

echo "\nCollecting static files..."
python manage.py collectstatic --no-input

echo "\nAll ready.\n"

exec "$@"