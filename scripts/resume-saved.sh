#!/usr/bin/env bash
#
# resume-saved.sh — Reinicia (resume) las máquinas virtuales cuyos IDs
# están guardados en saved-vm-ids.txt.
#
# Uso:  ./resume-saved.sh
#
# Requisito: saved-vm-ids.txt debe existir y contener un ID por línea.
#           Las VMs deben estar en estado POWEROFF (6) o STOPPED (7).
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VM_IDS_FILE="${SCRIPT_DIR}/saved-vm-ids.txt"

if [[ ! -f "${VM_IDS_FILE}" ]]; then
    echo "ERROR: ${VM_IDS_FILE} no existe. Ejecuta primero save-running.sh" >&2
    exit 1
fi

VM_IDS=()
while IFS= read -r line; do
    # Saltar líneas vacías o de comentario
    line="$(echo "${line}" | xargs)"
    [[ -z "${line}" || "${line}" == \#* ]] && continue
    VM_IDS+=("${line}")
done < "${VM_IDS_FILE}"

if [[ ${#VM_IDS[@]} -eq 0 ]]; then
    echo "No se encontraron VMs en ${VM_IDS_FILE}."
    exit 0
fi

echo "Reiniciando ${#VM_IDS[@]} máquina(s)..."

for vm_id in "${VM_IDS[@]}"; do
    echo -n "  onevm resume ${vm_id} ... "
    if onevm resume "${vm_id}"; then
        echo "OK"
    else
        echo "FALLÓ" >&2
    fi
done

echo "Todas las VMs guardadas han sido reiniciadas."
