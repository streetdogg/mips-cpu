/*
 * Implements PC testing module
 */
module cpu #(parameter WORD_SIZE=32, ADDR_WIDTH=32, OPCODE_WIDTH=3, REG_WIDTH=5)
            (input clk, rst);

    /*
     * This implementation shall check the working of PC, register file and ALU
     * Based on REG and IMM instructions.
     */

    // Wires to connect blocks together
    wire [WORD_SIZE-1:0] pc_to_iram, alu_result, reg_o_a, reg_o_b, sav_to_reg, inst;
    wire [REG_WIDTH-1:0] reg_a, reg_b, reg_c;
    wire [WORD_SIZE-OPCODE_WIDTH-REG_WIDTH-1:0] imm_data;
    wire alu_op, reg_wr_en, imm_op, reset;

    assign sav_to_reg = imm_op ? imm_data : alu_result;
    assign reg_a = inst[28:24];
    assign reg_b = inst[23:19];
    assign reg_c = inst[18:14];

    assign reset = ~rst;

    // Program Counter
    module_pc program_counter(.clk(clk),
                              .reset(reset),
                              .pc(pc_to_iram));

    // Instruction memory
    module_instruction_memory iram(.addr(pc_to_iram),
                                   .instruction(inst));

    // Control Unit
    module_control_unit cu(.opcode(inst[31:29]),
                           .reg_wr_en(reg_wr_en),
                           .alu_op(alu_op),
                           .imm_op(imm_op));

    // Sign extend
    module_sign_extend se(.in(inst[23:0]),
                          .out(imm_data));

    // General Purpose Registers
    module_register_bank gpr(.clk(clk),
                             .ra(reg_a),
                             .rb(reg_b),
                             .rc(reg_c),
                             .wr_en(reg_wr_en),
                             .data_in(sav_to_reg),
                             .ro1(reg_o_a),
                             .ro2(reg_o_b));
    // ALU
    module_alu alu(.clk(clk),
                   .A(reg_o_a),
                   .B(reg_o_b),
                   .sub(alu_op),
                   .C(alu_result));
endmodule