/*
 * Implementation of instruction decoder
 */
module module_control_unit #(parameter INSTRUCTION_WIDTH=32, CONTROL_SIGS=32, STATUS_BITS=32, OPCODE=3, ADDRESS_WIDTH=32, DATA_WIDTH=32, REG_SELECT=5)
                            (input clk,
                            input [STATUS_BITS-1:0] status,
                            input [INSTRUCTION_WIDTH-1:0] instruction,
                            output reg [REG_SELECT-1:0] ra, rb, rc,
                            output reg [DATA_WIDTH-1:0] data,
                            output reg wr_en, sub, alu_op);
    reg [OPCODE-1:0] opcode;

    always @(posedge clk) begin
        case(opcode)
            // ADD RA + RB => RC
            3'b000: begin
                ra <= instruction[28:24];
                rb <= instruction[23:19];
                rc <= instruction[18:14];
            end

            // MOVI RX #DATA
            3'b001: begin
                // Load address
                rc <= instruction[28:24];

                // Load sign extended data
                if (instruction[23]) data <= {2'hff, instruction[23:0]};
                else data <= {2'h00, instruction[23:0]};

                // Write the data
                wr_en <= 1'b1;
            end
            default: begin
                data <= 0;
                wr_en <= 1'b0;
                sub <= 1'b0;
                alu_op <= 1'b0;
            end
        endcase
    end
endmodule
