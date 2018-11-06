/*
 * Implements Status Register
 * bit 0: Zero Flag
 */
module module_sr #(parameter WORD_SIZE=32)
                  (input clk, reset, zero_fg,
                   output [WORD_SIZE-1:0] sr_out);

    // Declare the Program counter
    reg [WORD_SIZE-1:0] sr;

    // On every clock cycle increment the PC
    // if an address is provided then load that,
    // On reset make PC point to the 0th location.
    always @(posedge clk) begin
        if (zero_fg) sr[0] <= 1'b1;
        else sr <= 0;
    end

    assign sr_out = sr;
endmodule

/*
 * Implements Program Counter
 */
module module_pc #(parameter WORD_SIZE=32)
                  (input clk, reset, wr_en,
                   input [WORD_SIZE-1:0] addr,
                   output [WORD_SIZE-1:0] pc_out);

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

    assign pc_out = pc;
endmodule