# pull base image
FROM postgres:13.2-alpine

# copy db backup into container
COPY ./db_backup/db_backup.sql* .