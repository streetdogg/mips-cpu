/* Copyright © 2018 Piyush Itankar <pitankar@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the “Software”), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
 * OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/*
 * Module Name:     CPU.
 * Functional Req:  Takes in Clock and Reset and executes every instruction in its memory.
 * Input:           clk, rst.
 *                  clk: System clock.
 *                  rst: Reset.
 *                  instruction: WORD at the given address.
 * Parameters:      WORD_SIZE, ADDR_WIDTH, OPCODE_WIDTH, REG_WIDTH.
 *                  WORD_SIZE: Size of the WORD processor can handle.
 *                  ADDR_WIDTH: Address signal width.
 *                  OPCODE_WIDTH: Opcode signal width.
 *                  REG_WIDTH: Register addressing signal width.
 */
module cpu #(parameter WORD_SIZE=32, ADDR_WIDTH=32, OPCODE_WIDTH=4, REG_WIDTH=5)
            (input clk, rst);

        // Wires to connect the modules
        wire reset, reg_wr, data_wr, e, l, g, z, ld, st;
        wire [WORD_SIZE-1:0] pc_iram_addr, iram_inst, ra_o, rb_o, alu_in, reg_save_data, alu_out, dram_out;
        wire [OPCODE_WIDTH-1:0] opcode, operation;
        wire [REG_WIDTH-1:0] ra, rb, rc;
        wire [17:0] imm_data;

        assign opcode   = iram_inst[31:28];
        assign ra       = iram_inst[27:23];
        assign rb       = (st) ? iram_inst[27:23] : iram_inst[22:18];
        assign rc       = (st) ? iram_inst[22:18] : iram_inst[17:13];
        assign imm_data = iram_inst[17:0];

        // If hooked to FPGA a reset is active low.
        assign reset = ~rst;
        assign reg_save_data = (ld) ? dram_out : alu_out;
        assign alu_in = (ld || st) ? imm_data : rb_o;

        // PC
        program_counter pc (.clk(clk),
                            .rst(reset),
                            .pc_out(pc_iram_addr));
        // IRAM
        instruction_memory iram (.addr(pc_iram_addr),
                                 .instruction(iram_inst));

        // REG FILE
        register_bank gpr (.ra(ra),
                           .rb(rb),
                           .rc(rc),
                           .wr(reg_wr),
                           .d_in(reg_save_data),
                           .da_o(ra_o),
                           .db_o(rb_o));

        // ALU
        module_alu  alu (.a_in(ra_o),
                         .b_in(alu_in),
                         .operation(operation),
                         .out(alu_out),
                         .z(z),
                         .g(g),
                         .l(l),
                         .e(e));

        // CU
        control_unit cu (.opcode(opcode),
                         .reg_wr(reg_wr),
                         .data_wr(data_wr),
                         .ld(ld),
                         .st(st),
                         .alu_op(operation));

        // DRAM
        data_memory dram (.addr(alu_out),
                          .d_in(rb_o),
                          .wr(data_wr),
                          .d_out(dram_out));
endmodule