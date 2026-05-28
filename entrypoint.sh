#!/bin/bash
set -e

chown -R openclaw:openclaw /data
chmod 700 /data

# Remove stale /data/.linuxbrew if it exists but is not a directory
# (e.g., broken symlink or file from a previous interrupted run)
if [ -e /data/.linuxbrew ] || [ -L /data/.linuxbrew ]; then
  if [ ! -d /data/.linuxbrew ]; then
    rm -f /data/.linuxbrew
  fi
fi

if [ ! -d /data/.linuxbrew ]; then
  cp -a /home/linuxbrew/.linuxbrew /data/.linuxbrew
fi

rm -rf /home/linuxbrew/.linuxbrew
ln -sfn /data/.linuxbrew /home/linuxbrew/.linuxbrew

exec gosu openclaw node src/server.js
