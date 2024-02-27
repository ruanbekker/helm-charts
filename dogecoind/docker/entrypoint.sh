#!/usr/bin/env bash
# credit: https://github.com/chrisrun
set -e

if [ -n "${RPCUSER}" ]; then
   PARAMS="$PARAMS --rpcuser=${RPCUSER}"
fi
if [ -n "${RPCPASSWORD}" ]; then
   PARAMS="$PARAMS --rpcpassword=${RPCPASSWORD}"
fi
if [ -n "${DATADIR}" ]; then
   PARAMS="$PARAMS --datadir=${DATADIR}"
fi
if [ -n "${CONF}" ]; then
   PARAMS="$PARAMS --conf=${CONF}"
fi

PARAMS="$PARAMS $@"
exec dogecoind $PARAMS