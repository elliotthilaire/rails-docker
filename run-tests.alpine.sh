#!/bin/sh

set -ex

apk add --no-cache su-exec
apk add --no-cache postgresql

export PGUSER=postgres

su-exec $PGUSER initdb -D /tmp/pgdata
su-exec $PGUSER postgres -D /tmp/pgdata &

rake test
