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
 * Module Name:     Program Counter.
 * Functional Req:  Increaments by 4 on each clock.
 *                  cycle and outputs the number thus produced.
 * Input:           Clock, Reset.
 *                  Clock: Increaments on rising edge of the clock.
 *                  Reset: Synchronously resets back to 0x00 if
 *                         Reset is Logic High.
 * Output:          Instruction Address.
 * Parameters:      WORD_SIZE.
 *                  WORD_SIZE: Width of the Program Counter.
 */
module program_counter #(parameter WORD_SIZE=32)
                        (input clk,
                         input rst,
                         output [WORD_SIZE-1:0] pc_out);

    // Declare the Program counter
    reg [WORD_SIZE-1:0] pc_reg;

    // On every clock cycle increment the PC
    // if an address is provided then load that,
    // On reset make PC point to the 0th location.
    always @(posedge clk) begin
        if (rst) pc_reg <= 0;
        else pc_reg <= pc_reg + 1;
    end

    assign pc_out = pc_reg;
endmodule
