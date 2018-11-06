/*
 * Implements Program Counter
 */
module module_pc #(parameter WORD_SIZE=32)
                  (input clk, reset, wr_en,
                   input [WORD_SIZE-1:0] addr,
                   output reg [WORD_SIZE-1:0] pc_out);

    // Declare the Program counter
    reg [WORD_SIZE-1:0] pc;

    // On every clock cycle increment the PC
    // if an address is provided then load that,
    // On reset make PC point to the 0th location.
    always @(posedge clk) begin
        if (reset) pc <= 0;
        else if (wr_en) pc <= addr;
        else pc <= pc + 4;
    end
endmodule