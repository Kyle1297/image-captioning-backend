# pull base image
FROM jwilder/nginx-proxy

# update nginx configurations
COPY vhost.d/default /etc/nginx/vhost.d/default
COPY custom.conf /etc/nginx/conf.d/custom.conf