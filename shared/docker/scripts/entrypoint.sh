#!/bin/sh

set -x
set -e

echo "entrypoint: $1"

export PATH="$PATH:$GOPATH/bin"

case "$1" in

  'backup')
    rm -fR /snk/backup/*
    cp -Rf /tmp/flogo-web /snk/backup
    exec /bin/bash $@
    ;;

  'flogo-svc')
    # /snk/scripts/entrypoint.sh flogo-svc
    go get -u github.com/FiloSottile/gvt
    cd $GOPATH/src/github.com/TIBCOSoftware
    #Please create directory if it is not exist
    git clone --recursive --depth=1 https://github.com/TIBCOSoftware/flogo-services.git
    # Restore dependencies
    cd flogo-services/flow-store
    gvt restore
    cd ../flow-state
    gvt restore
    # gvt fetch all dependencies and put it into vendor directory

    # Both state and flow service now are compilable go project
    # Build those 2 services
    cd flogo-services/flow-store
    go test ./...
    go install ./...
    cd flogo-services/flow-state
    go test ./...
    go install ./...

    # start services
    # cd $GOPATH/bin
    fgstore -p 9090 -addr localhost:6379
    fgstate -p 9190 -addr localhost:6379
    ;;

  'mashling-dev')
    cd $GOPATH/src/github.com/TIBCOSoftware
    git clone --recursive --depth=1 https://github.com/TIBCOSoftware/mashling.git
    git clone --recursive --depth=1 https://github.com/TIBCOSoftware/mashling-recipes.git
    cd mashling
    pwd
    ls -l
    exec /bin/bash $@
    ;;

  'front-dev')
    go get -u github.com/FiloSottile/gvt

    cd cd /tmp/flogo-web/build/server/local/engines/flogo-web
    pwd
    flogo ensure
    exec /tmp/flogo-web/docker-start.sh eula-accept
    ;;

  'bash')
    echo "- Golang version: "
    go version

    echo "- Node version: "
    node --version

    echo "- Redis-Server version: "
    redis-server --version
    # updatedb

    # print envs
    # http://how-to.wikia.com/wiki/How_to_set,_print,_or_list_environment_variables

    exec /bin/bash
    ;;

  *)
    exec /tmp/flogo-web/docker-start.sh eula-accept
    ;;
esac