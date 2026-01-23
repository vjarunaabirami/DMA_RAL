# ------------------------ Tool Setup ------------------------
QUESTA := /home/share/questa.csh
SHELL  := /bin/csh

.ONESHELL:
.SILENT:

TOP = top
TB  = testbench.sv

UVM_INC = +incdir+/tools/mentor/questasim_10.6c/questasim/uvm-1.1d/../verilog_src/uvm-1.1d/src

# ------------------------ Default ------------------------
all:
	make clean
	make compile_cov
	make simulate_cov
	make report

# ------------------------ Compile with Coverage ------------------------
compile_cov:
	source $(QUESTA)
	vlib work
	vmap work work
	vlog -sv +define+UVM_NO_DPI +acc +cover +fcover \
	$(TB) $(UVM_INC)

# ------------------------ Simulate with Coverage ------------------------
simulate_cov:
	source $(QUESTA)
	vsim -c $(TOP) \
	+UVM_TESTNAME=dma_regression_test \
	+UVM_VERBOSITY=UVM_MEDIUM \
	-coverage \
	-l simulation.log \
	-do "coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"

# ------------------------ Coverage Report ------------------------
report:
	source $(QUESTA)
	vcover report -html coverage.ucdb -htmldir covReport -details

# ------------------------ View Coverage ------------------------
view:
	firefox ./covReport/index.html &

# ------------------------ Clean ------------------------
clean:
	rm -rf work transcript coverage.ucdb covReport simulation.log
	clear

