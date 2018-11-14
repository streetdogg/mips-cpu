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
 * Module Name:     ALU.
 * Functional Req:  Performs Arithematic and Logical Operations
 *                  and ouputs result and status flags.
 * Input:           a_in, b_in, operation.
 *                  a_in: Operand 1.
 *                  b_in: Operand 2.
 *                  operation:  Operation to be performed by the CPU
 *                              ADD: 0x00.
 *                              SUB: 0x01.
 *                              AND: 0x02.
 *                              OR:  0x03.
 * Output:          out, z, g, l, e.
 *                  out: Output of the computation.
 *                  z: Zero Flag, set if the diff of operands is zero.
 *                  g: Greater than Flag, set if a_in > b_in
 *                  l: Less than Flag, set if a_in < b_in
 *                  e: Equal Flag, set if a_in == b_in
 * Parameters:      BUS_WIDTH, OPCODE.
 *                  BUS_WIDTH: Width of result.
 *                  OPCODE: Width of Opcode selection signals.
 */
module module_alu #(parameter BUS_WIDTH=32, OPCODE=4)
                   (input  [BUS_WIDTH-1:0] a_in, b_in,
                    input  [OPCODE-1:0] operation,
                    output [BUS_WIDTH-1:0] out,
                    output z, g, l, e);

    reg [BUS_WIDTH-1:0] result;

    always @(operation) begin
        case (operation)
            // ADD
            2'h00: result <= a_in + b_in;

            // SUB
            2'h01: result <= a_in - b_in;

            // AND
            2'h02: result <= a_in & b_in;

            // OR
            2'h03: result <= a_in | b_in;

            // Meta Stable
            default: result <= 0;
        endcase
    end

    assign out = result;

    assign e = (a_in == b_in) ? 1'b1 : 1'b0;
    assign l = (a_in < b_in)  ? 1'b1 : 1'b0;
    assign g = (a_in > b_in)  ? 1'b1 : 1'b0;
    assign z = (a_in - b_in)  ? 1'b0 : 1'b1;

endmodule
