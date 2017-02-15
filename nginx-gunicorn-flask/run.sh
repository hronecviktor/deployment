#!/bin/bash
NAME="mhdbot"
FLASKDIR=/home/zamr/code/mhdbot
SOCKFILE=/home/zamr/code/mhdbot/sock
LOGFILE=/var/log/mhdbot.log
USER=root
GROUP=root
NUM_WORKERS=3
PIDFILE=/var/run/gunicorn.pid
 
echo "Starting $NAME"
 
# Create the run directory if it doesn't exist
. /home/zamr/code/mhdbot/venv27/bin/activate
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR
 
# Start your gunicorn
exec gunicorn mhdbot:app -b 0.0.0.0:5000 \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user=$USER --group=$GROUP \
  --bind=unix:$SOCKFILE \
  --pythonpath /home/zamr/code/mhdbot \
  --log-file=$LOGFILE \
  --daemon  \
  --pid=$PIDFILE \
#  --certfile=/etc/letsencrypt/live/hronec.tech/cert.pem \
#  --keyfile=/etc/letsencrypt/live/hronec.tech/privkey.pem
