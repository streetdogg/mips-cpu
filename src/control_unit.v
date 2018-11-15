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
 * Module Name:     Control Unit.
 * Functional Req:  Takes in status bits and outputs control signal to the datapath.
 * Input:           opcode.
 *                  opcode: determines the type of instruction.
 * Output:          reg_wr, alu_op.
 *                  reg_wr: write enable to the Register file.
 *                  alu_op: Code for the ALU operation to be performed.
 * Parameters:      OPCODE.
 *                  OPCODE: Width of Opcode selection signals.
 */
module control_unit #(parameter OPCODE=4)
                     (input [OPCODE-1:0] opcode,
                      output reg_wr, data_wr, ld, st,
                      output [OPCODE-1:0] alu_op);

    // FYI: The CU only controls the ALU and Reg file as of now.
    assign alu_op = opcode;
    reg reg_wr_en, data_wr_en, load_inst, store_inst;

    // Decide if Reg reg_write should be allowed
    always @(opcode) begin
        case (opcode)
            0: begin
                reg_wr_en <= 1'b1;
                data_wr_en <= 1'b0;
                load_inst <= 1'b0;
                store_inst <= 1'b0;
                end
            1: begin
                reg_wr_en <= 1'b1;
                data_wr_en <= 1'b0;
                load_inst <= 1'b0;
                store_inst <= 1'b0;
                end
            2: begin
                reg_wr_en <= 1'b1;
                data_wr_en <= 1'b0;
                load_inst <= 1'b0;
                store_inst <= 1'b0;
                end
            3: begin
                reg_wr_en <= 1'b1;
                data_wr_en <= 1'b0;
                load_inst <= 1'b0;
                store_inst <= 1'b0;
                end
            4: begin
                reg_wr_en <= 1'b0;
                data_wr_en <= 1'b0;
                load_inst <= 1'b1;
                store_inst <= 1'b0;
                end
            5: begin
                reg_wr_en <= 1'b0;
                data_wr_en <= 1'b1;
                load_inst <= 1'b0;
                store_inst <= 1'b1;
                end
            default: begin
                reg_wr_en <= 1'b0;
                data_wr_en <= 1'b0;
                load_inst <= 1'b0;
                store_inst <= 1'b0;
            end
        endcase
    end

    assign ld = load_inst;
    assign st = store_inst;
    assign reg_wr = reg_wr_en;
    assign data_wr = data_wr_en;

endmodule