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
 * Output:          wr, alu_op.
 *                  wr: Write enable to the Register file.
 *                  alu_op: Code for the ALU operation to be performed.
 * Parameters:      OPCODE.
 *                  OPCODE: Width of Opcode selection signals.
 */
module control_unit #(parameter OPCODE=4)
                     (input [OPCODE-1:0] opcode,
                      output wr,
                      output [OPCODE-1:0] alu_op);

    // FYI: The CU only controls the ALU and Reg file as of now.
    assign alu_op = opcode;
    reg wr_en;

    // Decide if Reg write should be allowed
    always @(opcode) begin
        case (opcode)
            2'h00: wr_en <= 1'b1;
            2'h01: wr_en <= 1'b1;
            2'h02: wr_en <= 1'b1;
            2'h03: wr_en <= 1'b1;
            default: wr_en <= 1'b0;
        endcase
    end

    assign wr = wr_en;

endmodule