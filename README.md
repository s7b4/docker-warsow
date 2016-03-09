# docker-warsow

## Configuration

Créez un fichier qui contient les valeurs à surcharger dans la configuration serveur de warsow, et liez le au conteneur avec un volume `(-v)` en remplacement du fichier `/etc/warsow/default.cfg`.

## Exemple avec docker-compose

### `docker-compose.yml`

    worker:
      image: s7b4/warsow
      ports:
        - "44400:44400/udp"
        - "44444:44444"
      volumes:
        - ./custom.cfg:/etc/warsow/default.cfg:ro

### `custom.cfg`

	set sv_hostname "Dockerized warsow server"

	set sv_maxclients "8"
	set sv_skilllevel "1"

	set sv_iplimit "8"

	set g_gametype "dm"
	set g_teams_maxplayers "8"