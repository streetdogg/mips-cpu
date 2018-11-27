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
 * Input:           a_in, b_in, operation, alu_en.
 *                  a_in: Operand 1.
 *                  b_in: Operand 2.
 *                  operation:  Operation to be performed by the CPU
 *                              ADD: 0x00.
 *                              SUB: 0x01.
 *                              AND: 0x02.
 *                              OR:  0x03.
 *                  alu_en: Outputs result if TRUE else outputs 0.
 * Output:          out, zero.
 *                  out:  Output of the computation.
 *                  zero: Zero Flag, set if the diff of operands is zero.
 * Parameters:      BUS_WIDTH, OPCODE.
 *                  BUS_WIDTH: Width of result.
 *                  OPCODE: Width of Opcode selection signals.
 */
module module_alu #(parameter BUS_WIDTH=32, OPCODE=3)
                   (input  [BUS_WIDTH-1:0] a_in, b_in,
                    input  [OPCODE-1:0] operation,
                    input  alu_en,
                    output [BUS_WIDTH-1:0] out,
                    output zero);

    // Constants for improving readibility
    parameter ADD = 3'b000;
    parameter SUB = 3'b001;
    parameter AND = 3'b011;
    parameter OR  = 3'b010;

    reg [BUS_WIDTH-1:0] result = 0;

    always @(operation or a_in or b_in) begin
        case (operation)
            ADD:     result <= a_in + b_in;
            SUB:     result <= a_in - b_in;
            AND:     result <= a_in & b_in;
            OR:      result <= a_in | b_in;
            default: result <= 0;
        endcase
    end

    assign out  = (alu_en == 1'b1) ? result : 0;
    assign zero = (result == 0) ? 1'b0 : 1'b1;

endmodule
