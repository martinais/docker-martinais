CMD=docker-compose -p martinade

build:
	$(CMD) build

debug:
	$(CMD) up

up:
	$(CMD) up -d

down:
	$(CMD) down

prod:
	sed 's!^http://!!' proxy/Caddyfile
