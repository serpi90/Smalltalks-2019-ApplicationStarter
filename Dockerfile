FROM basmalltalk/pharo:7.0-image AS loader

WORKDIR /opt/pharo
COPY scripts/load.st .
RUN pharo Pharo.image load.st --save --quit


FROM basmalltalk/pharo:7.0

WORKDIR /app
COPY --from=loader /opt/pharo/*.image .
COPY --from=loader /opt/pharo/*.changes .
COPY --from=loader /opt/pharo/*.sources .
COPY scripts/start.sh ./

USER root

ENTRYPOINT [ "pharo", "Pharo.image", "smalltalks2019" ]
