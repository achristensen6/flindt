#!/bin/bash
#
# Init script
#
###########################################################

# Create .env for flindt backend
cat <<EOT > "/app/backend/.env"
SOCIAL_AUTH_GOOGLE_PLUS_KEY=$FLINDT_SOCIAL_AUTH_GOOGLE_PLUS_KEY
CORS_ORIGIN_WHITELIST=$FLINDT_CORS_ORIGIN_WHITELIST
ALLOWED_HOSTS=localhost,127.0.0.1
DATABASE_URL=mysql://${FLINDT_DB_USER}:${FLINDT_DB_PASS}@${FLINDT_DB_HOST}/${FLINDT_DB_NAME}
FRONTEND_HOSTNAME=$FLINDT_FRONTEND_HOSTNAME
DEBUG=$FLINDT_DEBUG
EOT

# Run Flindt migrate tasks
python /app/backend/manage.py migrate
python /app/backend/manage.py collectstatic

# Start supervisor
/usr/bin/supervisord -c /etc/supervisord.conf
