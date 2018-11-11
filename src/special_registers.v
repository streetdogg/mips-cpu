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
                  (input clk,
                   input reset,
                   output [WORD_SIZE-1:0] pc);

    // Declare the Program counter
    reg [WORD_SIZE-1:0] pc_reg;

    // On every clock cycle increment the PC
    // if an address is provided then load that,
    // On reset make PC point to the 0th location.
    always @(posedge clk) begin
        if (reset) pc_reg <= 0;
        else pc_reg <= pc_reg + 4;
    end

    assign pc = pc_reg;
endmodule

/*
 * Sign extender for immediate values
 */
module module_sign_extend #(parameter IN_WIDTH=24, OUT_WIDTH=32)
                           (input [IN_WIDTH-1:0] in,
                            output [OUT_WIDTH-1:0] out);

    assign out = (in[IN_WIDTH-1]) ? {2'hff, in} : {2'h00, in};

endmodule