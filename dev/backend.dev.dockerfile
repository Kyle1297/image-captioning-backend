# pull base image
FROM python:3.9.1-slim

# set working directiory
WORKDIR /usr/src/app/

# enable easier debugging
ENV PYTHONBUFFERED 1

# install and setup packages, including poetry
RUN apt-get update && \
    apt-get install -y curl netcat docker.io && \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | \
    POETRY_HOME=/opt/poetry python && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false

# copy poetry.lock* in case it doesn't exist in the repo
COPY ./pyproject.toml ./poetry.lock* /usr/src/app/

# allow installation of dev dependencies to run tests
ARG INSTALL_DEV=false

# install project dependencies
RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then poetry install --no-root \
                                           ; else poetry install --no-root --no-dev ; fi"

# copy project
COPY /app/ /usr/src/

# copy entrypoint file
COPY /scripts/entrypoint.dev.sh /usr/src/scripts/

# run startup process
ENTRYPOINT [ "/usr/src/scripts/entrypoint.dev.sh" ]