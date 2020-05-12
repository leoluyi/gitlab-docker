#!/usr/bin/env bash

function backup_volume() {
  local VOLUME=$1
  local BACKUP_DIR="$2"
  local BACKUP_FILE=$3

  resolved_path="$(realpath --quiet "$BACKUP_DIR")"
  BACKUP_DIR="${resolved_path:?$BACKUP_DIR}"


  [ -d "${BACKUP_DIR}" ] || (echo "Backup directory not found: ${BACKUP_DIR}"; exit 1)
  docker volume inspect "${VOLUME}" &>/dev/null || (echo "Volume not found: ${VOLUME}"; exit 1)

  echo Backup volume "${VOLUME}" into "${BACKUP_DIR}/${BACKUP_FILE}.tar.gz"

  docker run --rm \
    --volume "${VOLUME}:/mount_data" \
    --volume "${BACKUP_DIR}:/backup" \
    ubuntu \
    tar czf "/backup/${BACKUP_FILE}.tar.gz" -C /mount_data .

  echo "Backup completed."
}

function restore_volume() {
  local VOLUME=$1
  local BACKUP_DIR=$2
  local BACKUP_FILE=$3

  resolved_path="$(realpath --quiet "$BACKUP_DIR")"
  BACKUP_DIR="${resolved_path:?$BACKUP_DIR}"

  [ -d "${BACKUP_DIR}" ] || (echo "Backup directory not found: ${BACKUP_DIR}"; exit 1)

  docker run --rm \
    --volume "${VOLUME}:/mount_data" \
    --volume "${BACKUP_DIR}:/backup" \
    ubuntu \
    tar xzvf "/backup/${BACKUP_FILE}.tar.gz" -C /mount_data

  echo "Restore completed."
}
