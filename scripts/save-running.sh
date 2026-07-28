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

# onevm list devuelve una tabla con columnas: ID NAME STATE CPU RAM
# State "running" corresponde a estado 1 (RUNNING).
# Filtramos solo las VMs que están corriendo y extraemos el ID (primera columna).
onevm list | awk 'NR>1 && $4=="running" {print $1}' > "${VM_IDS_FILE}"

echo "IDs guardados en ${VM_IDS_FILE}:"
cat "${VM_IDS_FILE}"
