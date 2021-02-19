# pull base image
FROM python:3.9.1-slim

# set working directiory
WORKDIR /app/

# enable easier debugging and prevent creation of .pcy files
ENV PYTHONBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# install and setup poetry
RUN apt-get update && \
    apt-get install -y curl netcat && \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | POETRY_HOME=/opt/poetry python && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false

# copy poetry.lock* in case it doesn't exist in the repo
COPY ./pyproject.toml ./poetry.lock* /app/

# allow installation of dev dependencies to run tests
ARG INSTALL_DEV=false

# install project dependencies
RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then poetry install --no-root ; else poetry install --no-root --no-dev ; fi"

# copy project
COPY /app/ /app/

# run as non-root user
RUN adduser --disabled-password --gecos '' user
USER user

# run startup process
ENTRYPOINT [ "/app/app/scripts/entrypoint.dev.sh" ]