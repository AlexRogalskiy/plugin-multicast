ARG BUILD_FROM
FROM ${BUILD_FROM}

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

ARG MDNS_REPEATER_VERSION
RUN \
    apk add --no-cache --virtual .build-deps \
        build-base \
    \
    && git clone -b ${MDNS_REPEATER_VERSION} --depth 1 \
        https://github.com/kennylevinsen/mdns-repeater /usr/src/mdns \
    && cd /usr/src/mdns \
    && gcc -O3 -o /usr/bin/mdns-repeater \
        mdns-repeater.c -DHGVERSION="\"${MDNS_REPEATER_VERSION}\"" \
    && apk del .build-deps \
    && rm -rf \
        /usr/src/mdns

COPY rootfs /