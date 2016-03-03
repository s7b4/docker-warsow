# docker-warsow

## Configuration

Créez un fichier qui contient les valeurs à surcharger dans la configuration serveur de warsow, et liez le au conteneur avec un volume `(-v)` en remplacement du fichier `/etc/warsow/default.cfg`.

## Exemple de docker-compose

### `docker-compose.yml`

    worker:
      image: s7b4/warsow
      ports:
        - "44400:44400/udp"
        - "44444:44444"
      volumes:
        - ./custom.cfg:/etc/warsow/default.cfg:ro
