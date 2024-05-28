#!/usr/bin/env bash
set -e

function usage {
    echo "usage: entrypoint.sh [--server|--help]"
}

function rotate_pdf {
    su -c "bundle exec ruby rotate.rb" $USER
}

if [ "$1" != "" ]; then
    case $1 in
        -r | --rotate )   rotate_pdf
                          exit
                          ;;
        -h | --help )     usage
                          exit
                          ;;
    esac
    shift
fi

exec "$@"

