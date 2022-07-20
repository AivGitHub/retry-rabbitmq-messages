#!/usr/bin/env bash

# Collect static files
./manage.py collectstatic --noinput

# Run uwsgi server
uwsgi --ini internal/uwsgi/settings/server.ini
