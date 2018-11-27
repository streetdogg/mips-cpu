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
module cpu #(parameter WORD_SIZE=32, ADDR_WIDTH=32, OPCODE_WIDTH=3, REG_WIDTH=5)
            (input clk, rst);

    // Control Signals
    wire ld, st, beq, j, alu_en, zero, rb_wr_en;
    wire [OPCODE_WIDTH-1 : 0] alu_op, opcode;

    wire [WORD_SIZE-1 : 0] instruction, a, b, c, mem_out, alu_out, pc_out, offset;
    wire [WORD_SIZE-1-OPCODE_WIDTH : 0] mem_addr;
    wire [REG_WIDTH-1:0] ra, rb, rc;

    assign opcode = instruction[WORD_SIZE-1 : WORD_SIZE-OPCODE_WIDTH];
    assign c = (ld) ? mem_out : alu_out;
    assign rb_wr_en = ld || alu_en;
    assign mem_addr = 0;
    assign ra = instruction[WORD_SIZE-1-OPCODE_WIDTH: WORD_SIZE-OPCODE_WIDTH-REG_WIDTH];
    assign rb = instruction[WORD_SIZE-1-OPCODE_WIDTH-REG_WIDTH : WORD_SIZE-OPCODE_WIDTH-REG_WIDTH-REG_WIDTH];
    assign rc = (ld) ? ra : instruction[WORD_SIZE-1-OPCODE_WIDTH-REG_WIDTH-REG_WIDTH : WORD_SIZE-OPCODE_WIDTH-REG_WIDTH-REG_WIDTH-REG_WIDTH];
    assign offset = (instruction[WORD_SIZE-1-OPCODE_WIDTH-REG_WIDTH-REG_WIDTH]) ? {13'b111_11111_11111, instruction[WORD_SIZE-1-OPCODE_WIDTH-REG_WIDTH-REG_WIDTH: 0]} : {13'b000_00000_00000, instruction[WORD_SIZE-1-OPCODE_WIDTH-REG_WIDTH-REG_WIDTH-1: 0]};

    control_unit cu(.opcode(opcode),
                    .ld(ld),
                    .st(st),
                    .beq(beq),
                    .j(j),
                    .alu_en(alu_en),
                    .alu_op(alu_op));

    module_alu alu(.a_in(a),
                   .b_in(b),
                   .operation(alu_op),
                   .alu_en(alu_en),
                   .out(alu_out),
                   .zero(zero));

    program_counter pc(.clk(clk),
                       .rst(rst),
                       .beq(beq),
                       .zero(zero),
                       .j(j),
                       .offset(offset),
                       .pc_out(pc_out));

    instruction_memory im(.addr(pc_out),
                          .instruction(instruction));

    register_bank r_b(.ra(ra),
                      .rb(rb),
                      .rc(rc),
                      .wr(rb_wr_en),
                      .d_in(c),
                      .da_o(a),
                      .db_o(b));

    data_memory dm(.addr({3'b000, mem_addr}),
                   .d_in(a),
                   .wr(st),
                   .d_out(mem_out));

endmodule