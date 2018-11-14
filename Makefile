# Copyright © 2018 Piyush Itankar <pitankar@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the “Software”), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
# OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

PROJECT=cpu

# Source files
SRC_FILES = src/*.v cpu.qsf

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
