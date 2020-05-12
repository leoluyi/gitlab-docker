#!/usr/bin/env bash

function backup_volume() {
  local VOLUME=$1
  local BACKUP_PATH=$2

  resolved_path="$(realpath --quiet "$BACKUP_PATH")" || (echo "Backup directory not found: $(dirname "${BACKUP_PATH}")"; return 1)
  BACKUP_DIR="$(dirname "${resolved_path}")"
  BACKUP_FILE="$(basename "${resolved_path}")"

  docker volume inspect "${VOLUME}" &>/dev/null || (echo "Volume not found: ${VOLUME}"; return 1)

  echo Backup volume "${VOLUME}" into "${BACKUP_FILE}"

  docker run --rm \
    --volume "${VOLUME}:/mount_data" \
    --volume "${BACKUP_DIR}:/backup" \
    ubuntu \
    tar czf "/backup/${BACKUP_FILE}" -C /mount_data .

  echo "Backup completed."
}

function restore_volume() {
  local VOLUME=$1
  local BACKUP_PATH=$2
  local resolved_path
  local BACKUP_DIR
  local BACKUP_FILE

  [ -f "${BACKUP_PATH}" ] || (echo "Backup file not found: ${BACKUP_PATH}"; return 1)
  resolved_path="$(realpath --quiet "$BACKUP_PATH")"
  BACKUP_DIR="$(dirname "${resolved_path}")"
  BACKUP_FILE="$(basename "${resolved_path}")"

  [ -f "${BACKUP_DIR}/${BACKUP_FILE}" ] || (echo "Backup file not found: ${BACKUP_DIR}/${BACKUP_FILE}"; return 1)

  echo Restore volume "${VOLUME}" from "${BACKUP_DIR}/${BACKUP_FILE}"

  docker run --rm \
    --volume "${VOLUME}:/mount_data" \
    --volume "${BACKUP_DIR}:/backup" \
    ubuntu \
    tar xzvf "/backup/${BACKUP_FILE}" -C /mount_data

  echo "Restore completed."
}
