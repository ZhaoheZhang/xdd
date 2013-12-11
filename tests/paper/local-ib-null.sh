#!/bin/bash

# load configuration defaults
source ./config.sh

# set option variables
XNIOPT="-xni ib"  # use XNI InfiniBand
IBDEVICEOPT="-ibdevice ${IBDEVICE}"
TARGETOPT="-targets 1 null"  # reads/writes are no-ops
E2EOPT="-e2e dest localhost:${E2EPORT},${E2ETHREADS}"
BYTESOPT="-bytes ${BYTES}"
REQSIZEOPT="-reqsize ${REQSIZE}"

# start destination side in background
${XDD} \
    ${XNIOPT} \
    ${IBDEVICEOPT} \
    ${TARGETOPT} \
    -op write -e2e isdest \
    ${E2EOPT} \
    ${BYTESOPT} \
    ${REQSIZEOPT} \
    &

# wait for destination side to start
sleep 3

# start source side
${XDD} \
    ${XNIOPT} \
    ${IBDEVICEOPT} \
    ${TARGETOPT} \
    -op read -e2e issrc \
    ${E2EOPT} \
    ${BYTESOPT} \
    ${REQSIZEOPT}

