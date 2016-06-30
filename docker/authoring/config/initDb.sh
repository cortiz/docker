#!/bin/bash

VOLUME_HOME="/var/lib/mysql"
if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    mysqld --initialize-insecure > /dev/stdout
    echo "=> Done!"
    service mysql start
    sleep 20
    mysql < /home/crafter/craftercms/craftercms.sql
    service mysql stop
else
    echo "=> Using an existing volume of MySQL"
    rm $VOLUME_HOME/mysqld_safe.pid
fi
exec supervisord -c /etc/supervisor/supervisord.conf
