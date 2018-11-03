/*
 * Implements a simple memory block
 */

module memory #(parameter WORD_SIZE=8, ADDR_WIDTH=8) (clk, wr_en, addr, data_in, data_out);
	input clk;
	input wr_en;
	input [WORD_SIZE-1:0]  data_in;
	input [ADDR_WIDTH-1:0] addr;
	output reg [WORD_SIZE-1:0]  data_out;

	// Actual Memory declaration
	reg [WORD_SIZE-1:0] mem [2**ADDR_WIDTH - 1 : 0];

	// Write to memory if WR_EN is TRUE
	always @(posedge clk) begin
	  if (wr_en) data_out <= mem[addr];
	  else mem[addr] <= data_in;
	end

endmodule
