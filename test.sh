curl 'http://gallery.martinade.fr/api/signin' \
  -H 'Content-Type: application/json' \
  -H 'Accept: */*' \
  -d "{\"name\":\"croc\",\"email\":\"tristan@tic.sh\"}"

curl 'http://gallery.martinade.fr/api/login' \
  -H 'Content-Type: application/json' \
  -H 'Accept: */*' \
  --data-raw '{"name":"croc"}'

pin=$(docker-compose -p martinade exec kvstore redis-cli --raw keys '*' | tail -n 1 | tr -d '\r')

TOKEN=$(curl -s 'http://gallery.martinade.fr/api/token' \
  -H 'Content-Type: application/json' \
  -H 'Accept: */*' \
  --data-raw "{\"code\":\"$pin\"}" | jq '.access_token' | tr -d '"')

curl 'http://gallery.martinade.fr/api/albums' \
  -sw "\n%{http_code}\n\n" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  -H 'Accept: */*'

curl 'http://gallery.martinade.fr/api/albums' \
  -sw "\n%{http_code}\n\n" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  -H 'Accept: */*' \
  --data-raw '{"name":"test"}'

curl 'http://gallery.martinade.fr/api/albums' \
  -sw "\n%{http_code}\n\n" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  -H 'Accept: */*'

curl 'http://gallery.martinade.fr/api/albums/test/pics' \
  -sw "\n%{http_code}\n\n" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  -H 'Accept: */*'

curl 'http://gallery.martinade.fr/api/albums' \
  -sw "\n%{http_code}\n\n" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  -H 'Accept: */*'
