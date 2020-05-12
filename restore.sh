#!/usr/bin/env bash
set -e

source base.sh
BACKUP_DIR="$(pwd)/backup_data"

restore_volume gitlab_gitlab_config "${BACKUP_DIR}" gitlab_config.tar.gz
restore_volume gitlab_gitlab_logs "${BACKUP_DIR}" gitlab_logs.tar.gz
restore_volume gitlab_gitlab_data "${BACKUP_DIR}" gitlab_data.tar.gz
