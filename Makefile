PGDB=gallery 		# TODO: take that from .env
PGUSER=postgres 	# TODO: take that from .env

DC=docker-compose -p martinade
PGEXEC=$(DC) exec database psql -U $(PGUSER)

up:
	$(DC) build
	$(DC) up -d && sleep 3
	$(MAKE) reset

reset:
	-$(PGEXEC) -c '\l' | grep $(PGDB) && $(PGEXEC) -c "DROP DATABASE $(PGDB)"
	$(PGEXEC) -c "CREATE DATABASE $(PGDB)"
	$(DC) exec gallery-backend python -c 'import model; model.migrate_database()'
	$(DC) exec kvstore redis-cli flushdb

down:
	$(DC) down --volumes

mock:
	sed -i 's!^\([^ h}]\)!http://\1!' proxy/Caddyfile
	echo "127.0.0.1 $$(\
		sed -n 's!^http://\([^ ]*\) .*!\1!p' proxy/Caddyfile | tr '\n' ' '\
	)" | sudo tee -a /etc/hosts

unmock:
	sudo sed -i '/martinade.fr/d' /etc/hosts
	sed -i 's!^http://!!' proxy/Caddyfile
