FROM basmalltalk/pharo:7.0-image AS loader

WORKDIR /opt/pharo
COPY . /source
RUN pharo Pharo.image metacello install 'gitlocal:///source' 'BaselineOfApplicationStarterSt2019'

FROM basmalltalk/pharo:7.0

WORKDIR /app
COPY --from=loader /opt/pharo/*.image .
COPY --from=loader /opt/pharo/*.changes .
COPY --from=loader /opt/pharo/*.sources .

USER root
EXPOSE 8080
ENTRYPOINT [ "pharo", "Pharo.image", "smalltalks2019", "--port=8080" ]
