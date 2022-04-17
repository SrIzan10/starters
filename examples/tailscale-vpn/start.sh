#!/bin/sh
echo "lsing stuff:"
ls /app/
echo "----------------------------------"
/app/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
until /app/tailscaled up --authkey=${TAILSCALE_AUTHKEY} --hostname=railway-app --advertise-exit-node
do
    sleep 0.1
done

echo Tailscale started
ALL_PROXY=socks5://localhost:1055/ sleep infinity
