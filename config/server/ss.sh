#!/bin/bash
# description: shadowsocks server

# Source function library.
. $CONFIG_PATH/.config.env

start() {
    ssserver -c $CONFIG_PATH/server/ss.json &
}

stop() {
    pkill -f "ssserver -c $CONFIG_PATH/server/ss.json"
}

status() {
    STATUS=$(lsof -i -P -n | grep ssserver); [ -z "$STATUS" ] && \
    echo "Server ssserver is not started. The network port $SS_SERVER_PORT may already be in use. Change port parameter server_port in ../server/ss.json and restart server" || 
    echo "Server ssserver is running:"; lsof -i -P -n | grep ssserver
}

case "$1" in 
    start)
       start
       ;;
    stop)
       stop
       ;;
    restart)
       stop
       start
       ;;
    status)
       status
       ;;
    *)
       echo "Usage: $0 {start|stop|status|restart}"
esac

exit 0 
