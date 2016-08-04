#! /bin/bash
set -e

# Utils
sed_escape() {
	echo "\"$@\"" | sed 's/[\/&]/\\&/g'
}

# Installation de warsow
if [ ! -f "$WS_HOME/wsw_server" ]; then
	echo 'Download Warsow ...'
	: ${WARSOW_URL:="http://update.warsow.gg/mirror/warsow_21_unified.tar.gz"}
	curl -s "$WARSOW_URL" | tar xzf - --directory "$WS_HOME" --strip-components 1
fi

# Configuration
: ${LOAD_CONFIG:="default"}
if [ ! -f "/etc/warsow/$LOAD_CONFIG.cfg" ]; then
	echo >&2 "error: missing file: /etc/warsow/$LOAD_CONFIG.cfg"
	exit 1
fi

# Options de jeu
grep -e "^set .* \".*\"" /etc/warsow/$LOAD_CONFIG.cfg | while read config_line;
do
	CONFIG_KEY=$(echo $config_line | sed -r 's/set (\w+) "(.*)"/\1/');
	CONFIG_VALUE=$(echo $config_line | sed -r 's/set (\w+) "(.*)"/\2/');
	sed -i "s/\(set $CONFIG_KEY \).*/\1$(sed_escape "$CONFIG_VALUE")/" $WS_HOME/basewsw/dedicated_autoexec.cfg
done;

# Droits sur volume
chown -R "$WS_USER":"$WS_USER" "$WS_HOME"

# Arch (from warsow)
ARCH=$(uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc/ -e s/sparc64/sparc/ -e s/arm.*/arm/ -e s/sa110/arm/ -e s/alpha/axp/)

# Démarrage
exec gosu "$WS_USER" "$WS_HOME/wsw_server.$ARCH" +set fs_basepath "$WS_HOME" +set fs_usehomedir "0" "${@}"
