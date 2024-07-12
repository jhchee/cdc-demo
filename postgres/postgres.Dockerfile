FROM postgres:15.6-alpine AS build

ENV PG_PARTMAN_VERSION=v4.7.3
ENV WAL2JSON_VERSION=wal2json_2_6

# Install the packages which will be required to get everything to compile
RUN set -ex \
    # Get some basic deps required to download the extensions and name them fetch-deps so we can delete them later
    && apk add --no-cache --virtual .fetch-deps \
        ca-certificates openssl tar \
    # Get the dependencies
    && apk add --no-cache --virtual .build-deps \
        autoconf automake g++ clang15 llvm15 libtool libxml2-dev make perl

# Download pg_partman
RUN wget -O pg_partman.tar.gz "https://github.com/pgpartman/pg_partman/archive/$PG_PARTMAN_VERSION.tar.gz" \
    # Create a folder to put the src files in
    && mkdir -p /usr/src/pg_partman \
    # Extract the src files
    && tar \
        --extract \
        --file pg_partman.tar.gz \
        --directory /usr/src/pg_partman \
        --strip-components 1 \
    && rm pg_partman.tar.gz \
    && cd /usr/src/pg_partman \
    && make && make install \
    && rm -rf /usr/src/pg_partman

RUN wget -O wal2json.tar.gz "https://github.com/eulerto/wal2json/archive/refs/tags/$WAL2JSON_VERSION.tar.gz" \
    # Create a folder to put the src files in
    && mkdir -p /usr/src/wal2json \
    # Extract the src files
    && tar \
        --extract \
        --file wal2json.tar.gz \
        --directory /usr/src/wal2json \
        --strip-components 1 \
    && rm wal2json.tar.gz && cd /usr/src/wal2json \
    && make && make install \
    && rm -rf /usr/src/wal2json

# Delete the dependencies for downloading and building the extensions, we no longer need them
RUN apk del .fetch-deps .build-deps

# Copy the init script
# The Docker Postgres initd script will run anything
# in the directory /docker-entrypoint-initdb.d
COPY initdb.sh /docker-entrypoint-initdb.d/initdb.sh