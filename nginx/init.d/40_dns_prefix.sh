#!/usr/bin/env bash

if [ -z ${DISCOVERY_DNS_PREFIX+x} ]; then
    DISCOVERY_DNS_PREFIX="${SUB_DOMAIN}-"

    echo $DISCOVERY_DNS_PREFIX > /etc/container_environment/DISCOVERY_DNS_PREFIX
fi
