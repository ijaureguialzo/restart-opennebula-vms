# restart-opennebula-vms

Utilidades para parar y reiniciar máquinas virtuales con el CLI de OpenNebula (`onevm`).

## Flujo de uso

Los tres scripts comparten un fichero de estado: `saved-vm-ids.txt`.

| Script | Acción |
|---|---|
| `save-running.sh` | Guarda los IDs de las VMs en estado RUNNING en `saved-vm-ids.txt` |
| `poweroff-saved.sh` | Lee `saved-vm-ids.txt` y apaga cada VM |
| `resume-saved.sh` | Lee `saved-vm-ids.txt` y reinicia (resume) cada VM |

### Ejemplo

```bash
# 1. Guardar qué VMs están corriendo
./scripts/save-running.sh

# 2. Apagarlas todas
./scripts/poweroff-saved.sh

# 3. Reiniciarlas todas (cuando sea necesario)
./scripts/resume-saved.sh
```

## Requisitos

- `onevm` instalado y accesible en `$PATH`
- Permisos de administrador de OpenNebula para ejecutar `onevm`
