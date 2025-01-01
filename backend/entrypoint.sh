#!/bin/bash

echo "Waiting for postgres..."
while ! nc -z $DB_HOST $DB_PORT; do
    sleep 0.1
done
echo "PostgreSQL started"

python manage.py migrate
python manage.py collectstatic --noinput

exec gunicorn --bind 0.0.0.0:8000 kittygram_backend.wsgi:application

