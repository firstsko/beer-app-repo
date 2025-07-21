#!/bin/bash
set -e

if [ "$FLASK_ENV" = "development" ]; then
  echo "⚙️ Running in development mode"
  echo "shit2"
  exec poetry run flask --app beer_catalog.app run --host=0.0.0.0 --port=5000
else
  echo "🚀 Running in production mode with Gunicorn"
  exec poetry run gunicorn beer_catalog.app:app --bind 0.0.0.0:5000
fi

