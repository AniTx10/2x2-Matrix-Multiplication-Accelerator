
# Variables
RTL = $(wildcard rtl/*.sv)
TB = tb/tb_matrix_multiply.sv
TOP = tb_matrix_multiply
TOP_RTL = matrix_multiply_2x2
OUT = sim.vvp
VCD = dump.vcd

# Default target is sim
all: sim

# Lint with Verilator
lint:
	verilator --lint-only -Wall -sv $(RTL) --top-module $(TOP_RTL)

# Compile with iverilog
$(OUT): $(RTL) $(TB)
	iverilog -g2012 -o $(OUT) $(RTL) $(TB)

# Run simulation
sim: $(OUT)
	vvp $(OUT)

# Open GTKWave for debugging
waves: $(VCD)
	gtkwave $(VCD)

# Remove generated artifacts
clean:
	rm -rf $(OUT) $(VCD) obj_dir/

.PHONY: all lint sim waves clean