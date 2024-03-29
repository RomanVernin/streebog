SHELL := /bin/bash

PWD = $(shell pwd)

INCDIR_PREFIX =-incdir
LIB_FLAG = -v

include streebog.mk
include simfiles.mk

	
clean:
	rm -rf $(PWD)/xcelium.d
	rm -rf $(PWD)/.simvision
	rm -rf $(PWD)/waves.shm
	rm -rf $(PWD)/qverilog.log
	rm -rf $(PWD)/work
	rm -rf $(PWD)/modelsim.ini
	rm -rf $(PWD)/vsim.wlf
	rm -rf $(PWD)/transcript
	rm -rf xrun.history
	rm -rf xrun.key
	rm -rf xrun.log
		

run_questa_gui : 
ifdef precalc
	vsim -do "do questa_do/streebog_precalc.do"
else
	vsim -do "do questa_do/streebog.do"
endif

run_questa_console :
ifdef precalc
	qverilog -define PRECALC -f questa_do/streebog_precalc.f
else
	qverilog -f questa_do/streebog.f
endif

xrun_streebog_tests:
	xrun \
	-64bit \
	-v93 \
	-sv \
	-timescale 1ns/10ps -notimingchecks \
	-access +rwc \
	-disable_sem2009 \
	-gui \
	-defineall AES128 \
	$(INCDIR) \
	$(streebog_FILES) \
	$(TESTBENCH_FILES)

run_tcl:	
	srun --x11 vivado -mode tcl -source viv.tcl -log reports/vivado.log -tempDir data/tmp -journal reports/vivado.jou
