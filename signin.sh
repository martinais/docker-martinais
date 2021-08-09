curl -s http://gallery.martinade.fr/api/signin -X POST \
  -H 'Content-Type: application/json' \
  -d "{\"name\":\"$1\",\"email\":\"$2\"}"
