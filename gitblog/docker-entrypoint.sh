#!/bin/sh
# set -ex
# user="${APACHE_RUN_USER:-www-data}"
# group="${APACHE_RUN_GROUP:-www-data}"
user='www-data'
group='www-data'
if ! [ -e index.php ]; then
    echo >&2 "GitBlog not found in $PWD - copying now..."
    if [ "$(ls -A)" ]; then
        echo >&2 "WARNING: $PWD is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi
    tar --create \
        --file - \
        --one-file-system \
        --directory /usr/src/gitblog-${GITBLOG_VERSION} \
        --owner "$user" --group "$group" \
        . | tar --extract --file -
    echo >&2 "Complete! GitBlog has been successfully copied to $PWD"
fi
exec "$@"