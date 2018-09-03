# This Dockerfile allows you to build a Flogo web docker image which comes
# preinstalled with additional activities. To add activities update the
# imports.go file and for each activity you want to have installed add the
# go get path (which you also use for flogo install). So if the URL you would
# paste is http://github.com/retgits/flogo-components/activity/trellocard
# simply add _ "github.com/retgits/flogo-components/activity/trellocard" to the
# imports.go
#
# Build a new image
# docker build . -t sniperkit/flogo:latest-contribs
#
# Run the image:
# docker run -d -p 3303:3303 --name=snk-flogoweb sniperkit/snk-flogo:latest-contribs-dev eula-accept
# docker run -d -p 3303:3303 --name=snk-flogoweb sniperkit/snk-flogo:latest-contribs-dev /bin/bash
#
FROM flogo/flogo-docker:latest as workspace
LABEL maintainer "sniperkit"

RUN \
    apk update \
        && apk add --no-cache --no-progress nano jq tree git mercurial ca-certificates \
                make cmake bash findutils gcc g++ musl-dev sqlite sqlite-dev

WORKDIR /tmp/flogo-web/build/server/local/engines/flogo-web

COPY ./cripts/entrypoint.sh /snk/scripts/entrypoint.sh

RUN chmod a+x /snk/scripts/entrypoint.sh
CMD ["/snk/scripts/entrypoint.sh"]

# FROM flogo/flogo-docker:latest as workspace
FROM flogo/flogo-docker:latest as ensurer
WORKDIR /tmp/flogo-web/build/server/local/engines/flogo-web
ADD ./imports.go /tmp/flogo-web/build/server/local/engines/flogo-web/src/flogo-web/imports.go

RUN \
    cd /tmp/flogo-web/build/server/local/engines/flogo-web \
    && flogo ensure
