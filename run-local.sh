DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PIDFILE=$DIR/pid
if [ -f $PIDFILE ];
then
	echo "PID file found, is the container already running? Otherwise please remove the pid file"
else
	echo "Starting instance..."
	docker run --name CrafterDev -d -p 8080:8080 \
	-v $DIR/crafter/data:/home/crafter/craftercms/data \
	-v $DIR/crafter/deployer/conf:/home/crafter/craftercms/deployer/conf \
	-v $DIR/crafter/deployer/target:/home/crafter/craftercms/deployer/target \
		craftercms/local >> $DIR/pid
fi
