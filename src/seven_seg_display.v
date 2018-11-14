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
 * Implements the &-Segement Display logic
 */
module seven_seg_display(clk, num, seven_seg_display);
	input  clk;
	input  [3:0] num;
	output reg [6:0] seven_seg_display;

	always @(posedge clk) begin
		case(num)
			4'b0000: seven_seg_display <= 7'b1000000; //0
			4'b0001: seven_seg_display <= 7'b1111001; //1
			4'b0010: seven_seg_display <= 7'b0100100; //2
			4'b0011: seven_seg_display <= 7'b0110000; //3
			4'b0100: seven_seg_display <= 7'b0011001; //4
			4'b0101: seven_seg_display <= 7'b0010010; //5
			4'b0110: seven_seg_display <= 7'b0000010; //6
			4'b0111: seven_seg_display <= 7'b1111000; //7
			4'b1000: seven_seg_display <= 7'b0000000; //8
			4'b1001: seven_seg_display <= 7'b0011000; //9
			4'b1010: seven_seg_display <= 7'b0001000; //A
			4'b1011: seven_seg_display <= 7'b0000011; //b
			4'b1100: seven_seg_display <= 7'b0100111; //c
			4'b1101: seven_seg_display <= 7'b0100001; //d
			4'b1110: seven_seg_display <= 7'b0000110; //E
			4'b1111: seven_seg_display <= 7'b0001110; //F
		endcase
	end
endmodule
