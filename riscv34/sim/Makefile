# Makefile for UVM Testbench
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = VCS
FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

RTL= ../rtl/*
work= work #library name
SVTB1= ../tb/top.sv
INC = +incdir+../tb
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH= -c -do  " log -r /* ;coverage save -onexit proc_cov;run -all; exit"

help:
	@echo =============================================================================================================
	@echo "! USAGE   	--  make target                  								!"
	@echo "! clean   	=>  clean the earlier log and intermediate files.  						!"
	@echo "! sv_cmp    	=>  Create library and compile the code.           						!"
	@echo "! run_test	=>  clean, compile & run the simulation for picorv32 in batch mode.		!" 
	@echo "! regress    =>  clean, compile and run all testcases in batch mode.		    				!"
	@echo "! report     =>  To merge coverage reports for all testcases and  convert to html format.			!"
	@echo "! cov        =>  To open merged coverage report in html format.							!"
	@echo ====================================================================================================================

# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB1) 
		      
run_test: clean sv_cmp
	./simv -a vcs.log +fsdbfile+wave1.fsdb -cm_dir ./proc_cov +ntb_random_seed_automatic +UVM_TESTNAME=RISCV_Test urg -dir proc_cov.vdb -format both -report urgReport
	
report:
	urg -dir proc_cov.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress: clean sv_cmp run_test report

cov:
	firefox covhtmlreport/index.html&

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb novas* verdi*
	clear

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#
