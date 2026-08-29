#!make

help: _header
	${info }
	@echo Opciones:
	@echo --------------------------------
	@echo guardar-vms
	@echo apagar-vms
	@echo iniciar-vms
	@echo --------------------------------

_header:
	@echo -----------------------------
	@echo Reinicio de VMs de OpenNebula
	@echo -----------------------------

guardar-vms:
	@./scripts/save-running.sh

apagar-vms:
	@./scripts/poweroff-saved.sh

iniciar-vms:
	@./scripts/resume-saved.sh
