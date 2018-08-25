#!/bin/bash
set -o errexit -o nounset -o pipefail

sed 's,{{DB_HOST}},'"${DB_HOST}"',g' -i /var/www/html/_config/config.php
sed 's,{{DB_DATABASE}},'"${DB_DATABASE}"',g' -i /var/www/html/_config/config.php
sed 's,{{DB_USERNAME}},'"${DB_USERNAME}"',g' -i /var/www/html/_config/config.php
sed 's,{{DB_PASSWORD}},'"${DB_PASSWORD}"',g' -i /var/www/html/_config/config.php

start_system() {
  /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
}

start_system

exit 0
