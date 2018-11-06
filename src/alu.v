/*
 * Implements ALU
 */
module module_alu #(parameter BUS_WIDTH=32)
                   (input clk,
                    input [BUS_WIDTH-1:0] A, B,
                    input sub,
                    output reg [BUS_WIDTH-1:0] C,
                    output reg fg_zero);

    always @(posedge clk) begin
        // Add or Substract based on the 'sub' input
        if (sub) C <= A - B;
        else C <= A + B;

        // Set the zero flag d
        if (C == 0) fg_zero <= 1'b1;
        else fg_zero <= 1'b0;
    end
endmodule
