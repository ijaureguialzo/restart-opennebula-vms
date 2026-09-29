#!/usr/bin/env bash
#
# save-running.sh — Guarda los IDs de las máquinas virtuales que están
# actualmente en estado RUNNING en el fichero saved-vm-ids.txt.
#
# Uso:  ./save-running.sh
#
# Salida: saved-vm-ids.txt  (un ID por línea, sin espacios en blanco)
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VM_IDS_FILE="${SCRIPT_DIR}/saved-vm-ids.txt"

if ! command -v jq &>/dev/null; then
    echo "ERROR: 'jq' no está instalado. Instálalo e inténtalo de nuevo." >&2
    exit 1
fi

onevm list --json | jq -r '.VM_POOL.VM[] | select(.STATE == "3" and .LCM_STATE == "3") | .ID' > "${VM_IDS_FILE}"

echo "IDs guardados en ${VM_IDS_FILE}:"
cat "${VM_IDS_FILE}"
