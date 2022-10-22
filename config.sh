# Deploy domain
# Default: localhost
# export TIMETRACKER_DOMAIN=tt.localhost
# export TIMETRACKER_HOST=tt.localhost

# Debug mode
# Default: false
export DEBUG=true

# Use Traefik reverse proxy
# Default: false
export USE_TRAEFIK=true

# Enable https support
# Default: false
# export USE_HTTPS=false

# Enable monitorning tools - prometheus, grafana, etc
# Default: false
# export USE_MONITORING=true

# Deploy user on remote host
# Default: docker-deploy
# export DEPLOY_USER=docker-deploy

# Gitlab registry user.
# Used for access to docker images in private docker repository.
# export REGISTRY_USER=docker-deploy

# Deploy token for login to gitlab docker registry
# Can be created on page:
# https://git.startext.dev/-/profile/personal_access_tokens
# with scopes: api, read_api, read_repository, read_registry
# export REGISTRY_TOKEN=82yvKg3pSXggw7X6jEyZ

# Project name (provided by gitlab CI/CD)
# Default: TimeTracker
# export CI_PROJECT_NAME=TimeTracker

# Postgres expose port
# Default: 127.0.0.1:5432
# export POSTGRES_PORT=127.0.0.1:5432

# Postgres password for user postgres
# export POSTGRES_PASSWORD=no-password-specified-NoFluIdAdjed

# Sori expose ports (tomcat, frontend, etc)
# export AUTHSERVICE_PORT=8082
# export TOMCAT_PORT=8080

# Traefik ports

# Traefik HTTP port
# Default: 80
# export TRAEFIK_HTTP_PORT=80

# Traefik HTTPS port
# Default: 443
# export TRAEFIK_HTTPS_PORT=443

# Traefik management port
# Default: 1081
# export TRAEFIK_MANAGE_PORT=1081

# Letsencrypt mode
# Default: 0
# export LETSENCRYPT=0
