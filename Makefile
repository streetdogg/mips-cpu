PROJECT=cpu

SRC_FILES = cpu.v memory.v seven_seg_display.v cpu.qsf

QP_ANALYSIS_SYNTHESIS = quartus_map
QP_FITTER = quartus_fit
QP_ASSEMBLER = quartus_asm
QP_TIMING_ANALYZER = quartus_sta

QP_OUT = $(PROJECT) -c $(PROJECT)
QP_FLAGS = --read_settings_files=off --write_settings_files=off $(QP_OUT)

$(PROJECT): $(SRC_FILES)
	$(QP_ANALYSIS_SYNTHESIS) $(QP_FLAGS)
	$(QP_FITTER) $(QP_FLAGS)
	$(QP_ASSEMBLER) $(QP_FLAGS)
	$(QP_TIMING_ANALYZER) $(QP_OUT)

clean:
	rm -rf db/ incremental_db/ output_files/ *.txt *.qpf *.qws