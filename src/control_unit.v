/*
 * Implementation of instruction decoder
 */
module module_instruction_decode #(parameter INSTRUCTION_WIDTH=32, CONTROL_SIGS=32, OPCODE=3, ADDRESS_WIDTH=32, DATA_WIDTH=32)
                                  (input clk,
                                   input [INSTRUCTION_WIDTH-1:0] instruction,
                                   output reg [ADDRESS_WIDTH-1:0] addr,
                                   output reg [DATA_WIDTH-1:0] data,
                                   output reg wr_en);
    reg [OPCODE-1:0] opcode;

    always @(posedge clk) begin
        case(opcode)
            // MOVI RX #DATA
            3'b001: begin
                // Load address
                addr <= instruction[28:24];

                // Load sign extended data
                if (instruction[23]) data <= {2'hff, instruction[23:0]};
                else data <= {2'h00, instruction[23:0]};

                // Write the data
                wr_en <= 1'b1;
            end
            default: begin
                data <= 0;
            end
        endcase
    end
endmodule
