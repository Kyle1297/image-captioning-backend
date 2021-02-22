# pull base image
FROM python:3.9.1-slim

# set working directiory
WORKDIR /usr/src/app/

# enable easier debugging
ENV PYTHONBUFFERED 1

# install and setup poetry
RUN apt-get update && \
    apt-get install -y curl netcat && \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | \
    POETRY_HOME=/opt/poetry python && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false

# copy poetry.lock* in case it doesn't exist in the repo
COPY ./pyproject.toml ./poetry.lock* /usr/src/

# install project dependencies
RUN poetry install --no-root --no-dev

# copy project
COPY /app/ /usr/src/app/

# copy entrypoint file
COPY /scripts/entrypoint.prod.sh /usr/src/scripts/

# run as non-root user
RUN adduser --disabled-password --gecos '' user && \
    chown -R user:user .
USER user

# run startup process
CMD [ "/bin/bash", "-c", "chmod +x /usr/src/scripts/entrypoint.prod.sh && /usr/src/scripts/entrypoint.prod.sh" ]