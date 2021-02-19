# pull base image
FROM nginx:1.19.7-alpine

# remove default configurations
RUN rm /etc/nginx/conf.d/default.conf

# add new configurations
COPY nginx.conf /etc/nginx/conf.d