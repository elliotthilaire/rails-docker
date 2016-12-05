#!/bin/sh

set -ex

apk add --no-cache postgresql
apk add --no-cache su-exec

su-exec postgres initdb -D /tmp/pgdata
su-exec postgres postgres -D /tmp/pgdata &

export PGUSER=postgres

rake test
