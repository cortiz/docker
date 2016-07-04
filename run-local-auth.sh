DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PIDFILE=$DIR/pid-authoring
if [ -f $PIDFILE ];
then
	echo "PID file found, is the container already running? Otherwise please remove the pid file"
else
	echo "Starting instance..."

	docker run --name CrafterAuth -d -p 80:80 \
	-v $DIR/CrafterAuth/data:/home/crafter/craftercms/data \
	-v $DIR/CrafterAuth/deployer/conf:/home/crafter/craftercms/deployer/conf \
	-v $DIR/CrafterAuth/www/:/home/crafter/craftercms/www \
	-v $DIR/CrafterAuth/www/:/home/crafter/craftercms/www \
	-v $DIR/CrafterAuth/apache2/:/etc/apache2/sites-enabled-ext/ \
	-v $DIR/CrafterAuth/mysql:/var/lib/mysql/ \
	-v $DIR/CrafterAuth/deployer/target:/home/crafter/craftercms/deployer/target \
		craftercms/authoring:snapshot>> $DIR/pid-authoring
fi
