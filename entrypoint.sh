#!/bin/bash
set -e
rm -f /tagfoto/tmp/pids/server.pid
exec "$@"
