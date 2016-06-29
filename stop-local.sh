DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PIDFILE=$DIR/pid
if [ -f $PIDFILE ];
then
	echo "Stopping..."
	PID=$(<"$PIDFILE")
	docker stop $PID
	rm $PIDFILE
else
	echo "PID NOT found, use \"docker stop <container_id>\" to stop the process"
fi