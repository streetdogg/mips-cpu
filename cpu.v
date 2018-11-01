/*
 * Implementation of a 8 bit CPU with 4 basic instructions
 */

module cpu #(parameter WORD_SIZE=8, ADDR_WIDTH=8)
            (clk, wr_en, addr_data, addr_data_in, addr_display, data_display, data_in_display);
    input clk;
    input wr_en;
    input addr_data;
    input [WORD_SIZE-1:0] addr_data_in;
    output [13:0] addr_display;
    output [13:0] data_display;
    output [13:0] data_in_display;

    wire [WORD_SIZE-1:0] data_out;
    reg [ADDR_WIDTH-1:0] addr;

    always @(posedge clk) begin
      if (addr_data) addr <= addr;
      else addr <= addr_data_in;
    end

    // Initialize the displays
    seven_seg_display addr_display_high(clk, addr[7:4], addr_display[13:7]);
    seven_seg_display addr_display_low (clk, addr[3:0], addr_display[6:0]);

    seven_seg_display data_display_high(clk, data_out[7:4], data_display[13:7]);
    seven_seg_display data_display_low (clk, data_out[3:0], data_display[6:0]);

    seven_seg_display data_in_display_high(clk, addr_data_in[7:4], data_in_display[13:7]);
    seven_seg_display data_in_display_low (clk, addr_data_in[3:0], data_in_display[6:0]);

    memory ram(clk, wr_en, addr, addr_data_in, data_out);
endmodule