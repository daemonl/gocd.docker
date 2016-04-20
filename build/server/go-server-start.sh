#!/bin/bash
set -ue

/bin/cp -va /go-addons/. /var/lib/go-server/addons/
chown -R go:go /var/lib/go-server/addons/

# Setup auto registration for agents.
AGENT_KEY="${AGENT_KEY:-123456789abcdef}"
[[ -n "$AGENT_KEY" ]] && sed -i -e 's/agentAutoRegisterKey="[^"]*" *//' -e 's#\(<server\)\(.*artifactsdir.*\)#\1 agentAutoRegisterKey="'$AGENT_KEY'"\2#' /etc/go/cruise-config.xml

chown -R go:go /var/lib/go-server /var/log/go-server /etc/go /go-addons /var/go

/bin/su - go -c /usr/share/go-server/server.sh
