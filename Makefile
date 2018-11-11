PROJECT=cpu

# Source files
SRC_FILES = src/cpu.v src/memory.v src/seven_seg_display.v src/special_registers.v src/control_unit.v cpu.qsf

# Quartus prime 18 build tools
QP_ANALYSIS_SYNTHESIS = quartus_map
QP_FITTER = quartus_fit
QP_ASSEMBLER = quartus_asm
QP_TIMING_ANALYZER = quartus_sta
QP_PROGRAMMER = quartus_pgm

# Device setting to be able to upload
DEVICE = "DE-SoC [2-1.2]"
DEVICE_NO = 2
PROG_MODE = "JTAG"
PROG_OPTS = P
OUTPUT_FILE = output_files/$(PROJECT).sof

# Options and Flags to be used for building the binary
QP_OUT = $(PROJECT) -c $(PROJECT)
QP_FLAGS = --read_settings_files=off --write_settings_files=off $(QP_OUT)

# Rules to build the project
all: $(SRC_FILES)
	$(QP_ANALYSIS_SYNTHESIS) $(QP_FLAGS)
	$(QP_FITTER) $(QP_FLAGS)
	$(QP_ASSEMBLER) $(QP_FLAGS)
	$(QP_TIMING_ANALYZER) $(QP_OUT)

# Clean the workspace
clean:
	rm -rf db/ simulation/* incremental_db/ output_files/ *.txt *.qpf *.qws src/*.bak *.rpt

# Upload the binary to the board
upload: $(OUTPUT_FILE)
	$(QP_PROGRAMMER) -c $(DEVICE) -m $(PROG_MODE) -o "$(PROG_OPTS);$(OUTPUT_FILE)@$(DEVICE_NO)"
