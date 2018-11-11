/*
 * Implementation of instruction decoder
 */
module module_control_unit #(parameter OPCODE=3)
                            (input [OPCODE-1:0] opcode,
                             output reg reg_wr_en, alu_op, imm_op);

    always @(opcode) begin
        case(opcode)
            // ADD RA + RB => RC
            3'b000: begin
                 reg_wr_en <= 1'b1;
                 alu_op <= 1'b0;
                 imm_op <= 1'b0;
            end
            // MOVI RX #DATA
            3'b001: begin
                imm_op <= 1'b1;
            end
            default: begin
                reg_wr_en <= 1'b0;
            end
        endcase
    end
endmodule