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

# install project dependencies
RUN poetry install --no-root

# copy project
COPY /app/ /app/

# run as non-root user
RUN adduser --disabled-password --gecos '' user && \
    chown -R user:user .
USER user

# run startup process
#ENTRYPOINT [ "/app/scripts/entrypoint.prod.sh" ]