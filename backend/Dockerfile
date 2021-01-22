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

FROM base as development
# Do some stuff
RUN touch hello.txt
ENTRYPOINT [ "tail", "-lf", "hello.txt" ]

FROM base as release
# Do some stuff
