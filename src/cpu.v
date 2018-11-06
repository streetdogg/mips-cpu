/*
 * Implements PC testing module
 */
module cpu #(parameter WORD_SIZE=8, ADDR_WIDTH=8)
            (input clk, reset, load_addr,
				 input [31:0] addr,
             output [13:0] data_display);

    wire [WORD_SIZE-1:0] data_out;
	 wire rst, load;

	 reg [31:0] ad = 4;
	 assign rst = ~reset;
	 assign load = ~load_addr;

    seven_seg_display data_display_high(clk, data_out[7:4], data_display[13:7]);
    seven_seg_display data_display_low (clk, data_out[3:0], data_display[6:0]);

    // module_instruction_memory iram(.clk(clk), .addr(pc_out));
    module_pc pc(.clk(clk), .reset(rst), .wr_en(load), .addr(ad), .pc_out(data_out));
endmodule