FROM tiangolo/uvicorn-gunicorn:python3.8-alpine3.10

WORKDIR /app/

RUN apk add --update --no-cache curl
RUN mkdir static

# Install Poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | POETRY_HOME=/opt/poetry python && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false

# Copy poetry.lock* in case it doesn't exist in the repo
COPY ./pyproject.toml ./poetry.lock* /app/

RUN poetry install --no-root --no-dev

COPY . /app
ENV PYTHONPATH=/app

RUN python manage.py collectstatic

CMD python manage.py migrate && gunicorn backend.asgi:application -b 0.0.0.0:8000 -k uvicorn.workers.UvicornWorker