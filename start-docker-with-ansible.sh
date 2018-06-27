#!/bin/bash

set -e

ANSIBLE_PLAYBOOK="${1}"
ANSIBLE_HOST="${2:-localhost}"
ANSIBLE_USER="${3:-$USER}"
ANSIBLE_KEY="${4:-$HOME/.ssh/id_rsa}"


if [ -z "$ANSIBLE_PLAYBOOK" ]
then
docker run \
  -ti \
  --rm \
  -w /ansible-oracle/ \
  -e ANSIBLE_PLAYBOOK=${ANSIBLE_PLAYBOOK} \
  -e ANSIBLE_HOST=${ANSIBLE_HOST} \
  -e ANSIBLE_USER=${ANSIBLE_USER} \
  -e ANSIBLE_KEY=${ANSIBLE_KEY} \
  -v $(realpath "$(dirname "$0")"):/ansible-oracle \
  -v $HOME:$HOME:ro -v /etc/passwd:/etc/passwd:ro \
  -u $(id -u) \
  teamidefix/ansible bash
else
docker run \
  --rm \
  -w /ansible-oracle/ \
  -e ANSIBLE_PLAYBOOK=${ANSIBLE_PLAYBOOK} \
  -e ANSIBLE_HOST=${ANSIBLE_HOST} \
  -e ANSIBLE_USER=${ANSIBLE_USER} \
  -e ANSIBLE_KEY=${ANSIBLE_KEY} \
  -v $(realpath "$(dirname "$0")"):/ansible-oracle \
  -v $HOME:$HOME:ro -v /etc/passwd:/etc/passwd:ro \
  -u $(id -u) \
  teamidefix/ansible bash run-playbook-inside-docker.sh "$ANSIBLE_PLAYBOOK"
fi
