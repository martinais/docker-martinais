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

mock:
	echo "127.0.0.1 $$(\
		sed -n 's!^http://\([^ ]*\) .*!\1!p' proxy/Caddyfile | tr '\n' ' '\
	)" | sudo tee -a /etc/hosts

unmock:
	sudo sed -i '/martinade.fr/d' /etc/hosts
