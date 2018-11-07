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
