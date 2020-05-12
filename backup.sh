#!/usr/bin/env bash
set -e

source base.sh
BACKUP_DIR="$(pwd)/backup_data"
DOCKER_COMPOSE_PREFIX="gitlab-docker"

backup_volume ${DOCKER_COMPOSE_PREFIX}_gitlab_config "${BACKUP_DIR}"/gitlab_config.tar.gz
backup_volume ${DOCKER_COMPOSE_PREFIX}_gitlab_logs "${BACKUP_DIR}"/gitlab_logs.tar.gz
backup_volume ${DOCKER_COMPOSE_PREFIX}_gitlab_data "${BACKUP_DIR}"/gitlab_data.tar.gz
