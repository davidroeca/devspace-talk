ARG USERID=1000

FROM postgres:13.1

ARG USERID

RUN usermod -u $USERID postgres
RUN groupmod -g $USERID postgres
