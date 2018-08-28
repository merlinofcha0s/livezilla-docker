#!/bin/bash
set -o errexit -o nounset -o pipefail


if [ "${INSTALL_MODE}" = "false" ]; then
	sed 's,{{DB_HOST}},'"${DB_HOST}"',g' -i /var/www/html/_config/config.php
	sed 's,{{DB_DATABASE}},'"${DB_DATABASE}"',g' -i /var/www/html/_config/config.php
	sed 's,{{DB_USERNAME}},'"${DB_USERNAME}"',g' -i /var/www/html/_config/config.php
	sed 's,{{DB_PASSWORD}},'"${DB_PASSWORD}"',g' -i /var/www/html/_config/config.php
	sed 's,{{DB_PREFIX}},'"${DB_PREFIX}"',g' -i /var/www/html/_config/config.php
	sed 's,{{LIVEZILLA_ID}},'"${LIVEZILLA_ID}"',g' -i /var/www/html/_config/config.php
	sed 's,{{LIVEZILLA_PR_CR}},'"${LIVEZILLA_PR_CR}"',g' -i /var/www/html/_config/config.php
	
	rm -rf /var/www/html/install
else
	rm -rf /var/www/html/_config/config.php
fi


start_system() {
  /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
}

start_system

exit 0
