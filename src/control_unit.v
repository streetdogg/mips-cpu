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
 * Output:          ld, st, beq, j, alu_en.
 *                  ld:     TRUE if the instruuction requires loading into register from memory.
 *                  st:     TRUE is a register value is to be stored into the data memory.
 *                  beq:    TRUE if give instruction is 'Branch if Equal'
 *                  j:      TRUE if instruction is unconditional jump.
 *                  alu_en: TRUE if alu operation is needed.
 *                  alu_op: ALU operation to be performed.
 * Parameters:      OPCODE.
 *                  OPCODE: Width of Opcode selection signals.
 */
module control_unit #(parameter OPCODE=3)
                     (input [OPCODE-1:0] opcode,
                      output ld, st, beq, j, alu_en,
                      output [OPCODE-1:0] alu_op);

    // Constants for improving readibility
    parameter ADD = 3'b000;
    parameter SUB = 3'b001;
    parameter AND = 3'b011;
    parameter OR  = 3'b010;
    parameter LD  = 3'b111;
    parameter ST  = 3'b101;
    parameter BEQ = 3'b110;
    parameter J   = 3'b100;

    // alu_operation is same as opcode.
    assign alu_op = opcode;

    // control signals in order => ld, st, beq, j, alu_en
    reg [4:0] control_sig;

    // Decide if Reg reg_write should be allowed
    always @(opcode) begin
        case (opcode)
            ADD:     control_sig <= 5'b00001;
            SUB:     control_sig <= 5'b00001;
            AND:     control_sig <= 5'b00001;
            OR:      control_sig <= 5'b00001;
            LD:      control_sig <= 5'b10000;
            ST:      control_sig <= 5'b01000;
            BEQ:     control_sig <= 5'b00100;
            J:       control_sig <= 5'b00010;
            default: control_sig <= 5'b00000;
        endcase
    end

    assign ld      = control_sig[4];
    assign st      = control_sig[3];
    assign beq     = control_sig[2];
    assign j       = control_sig[1];
    assign alu_en  = control_sig[0];

endmodule