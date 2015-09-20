# docker plex

## build

     docker build -t plex-media-server .

## run 

Allow localhost and 192.168.168.0/24 server setup:

     PLEX_ALLOWED_NET="192.168.168.0\/255.255.255.0 127.0.0.1\/255.255.255.255" ./run_plex.sh
