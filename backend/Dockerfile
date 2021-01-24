ARG USERID=1000

FROM python:3.8.7-slim-buster as base

# Lock down pip and poetry versions
RUN pip install pip==20.3.3
RUN pip install poetry==1.1.4

ARG USERID

RUN useradd -u $USERID -m appuser
USER appuser
RUN mkdir /home/appuser/src

WORKDIR /home/appuser/src

COPY --chown=appuser:appuser pyproject.toml .
COPY --chown=appuser:appuser poetry.lock .
COPY --chown=appuser:appuser poetry.toml .

RUN poetry install

COPY --chown=appuser:appuser app ./app
COPY --chown=appuser:appuser run.py .
COPY --chown=appuser:appuser migrations ./migrations

FROM base as development

ENTRYPOINT [ "poetry", "run" ]
CMD [ "flask", "run" ]

FROM base as release
# Do some stuff
