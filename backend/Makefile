PG_DB=gallery 		# TODO: take that from .env
PG_USER=postgres 	# TODO: take that from .env

DOCKER=docker-compose -p dev-backend
PG_EXEC=$(DOCKER) exec database psql -U $(PG_USER)

up:
	$(DOCKER) build
	$(DOCKER) up -d && sleep 3
	$(PG_EXEC) -c '\l' | grep $(PG_DB) || $(PG_EXEC) -c "CREATE DATABASE $(PG_DB)"

down:
	$(DOCKER) down --volumes

shell:
	$(DOCKER) exec backend bash

logs:
	$(DOCKER) logs -f

psql:
	$(PG_EXEC) -d $(PG_DB)
