#!/bin/sh
registration_url="https://github.com/${GITHUB_OWNER}"

if [ -n "${GITHUB_REPOSITORY}" ]; then
    registration_url="${registration_url}/${GITHUB_REPOSITORY}"
fi

if [ -z "${RUNNER_NAME}" ]; then
    RUNNER_NAME=$(hostname)
fi

./config.sh \
    --name "${RUNNER_NAME}" \
    --token "${RUNNER_TOKEN}" \
    --url "${registration_url}" \
    --work "${RUNNER_WORKDIR}" \
    --labels "${RUNNER_LABELS}" \
    --unattended \
    --replace

trap 'exit 130' INT
trap 'exit 143' TERM

./run.sh "$*" &

wait $!
