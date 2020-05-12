#!/usr/bin/env bash
set -e

source base.sh
BACKUP_DIR="$(pwd)/backup_data"
DOCKER_COMPOSE_PREFIX="gitlab-docker"

backup_volume ${DOCKER_COMPOSE_PREFIX}_gitlab_config "${BACKUP_DIR}" gitlab_config
backup_volume ${DOCKER_COMPOSE_PREFIX}_gitlab_logs "${BACKUP_DIR}" gitlab_logs
backup_volume ${DOCKER_COMPOSE_PREFIX}_gitlab_data "${BACKUP_DIR}" gitlab_data
