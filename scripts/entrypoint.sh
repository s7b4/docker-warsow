#! /bin/bash
set -e

# Installation de warsow
if [ ! -f "$WS_HOME/wsw_server" ]; then
	echo 'Download Warsow ...'
	: ${WARSOW_URL:="http://update.warsow.gg/mirror/warsow_201_unified.tar.gz"}
	curl -s "$WARSOW_URL" | tar xzf - --directory "$WS_HOME" --strip-components 1
fi

# Droits sur volume
chown -R "$WS_USER":"$WS_USER" "$WS_HOME"

# Démarrage
cd "$WS_HOME"
exec gosu "$WS_USER" "$WS_HOME/wsw_server.x86_64" +set fs_basepath "$WS_HOME" +set fs_usehomedir "0" "${@}"
