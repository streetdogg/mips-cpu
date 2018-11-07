/*
 * Implements PC testing module
 */
module cpu #(parameter WORD_SIZE=8, ADDR_WIDTH=8)
            (input clk, reset, load_addr,
				 input [31:0] addr,
             output [13:0] data_display);

    wire [WORD_SIZE-1:0] data_out, instruction, data, alu_data, imm_data, ro1, ro2, status;
    wire rst, load, ra, rb, rc, alu_op, wr_en, sub_en, zero;

    reg [31:0] ad = 4;
    assign rst = ~reset;
    assign load = ~load_addr;

    seven_seg_display data_display_high(clk, data_out[7:4], data_display[13:7]);
    seven_seg_display data_display_low (clk, data_out[3:0], data_display[6:0]);

    // choose between ALU operation and immediate value
    assign data = (alu_op) ? alu_data : imm_data;

    // Program counter
    module_pc pc(.clk(clk),
                 .reset(rst),
                 .wr_en(load),
                 .addr(ad),
                 .pc_out(data_out));

    // IRAM: stores all instructions
    module_instruction_memory iram(.clk(clk),
                                   .addr(data_out),
                                   .instruction(instruction));

    // Program counter
    module_sr sr(.clk(clk),
                 .reset(rst),
                 .zero_fg(zero),
                 .sr_out(status));

    // Register file
    module_register_bank gpr(.clk(clk),
                             .ra(ra),
                             .rb(rb),
                             .rc(rc),
                             .wr_en(wr_en),
                             .data_in(data),
                             .ro1(ro1),
                             .ro2(ro2));

    // ALU module
    module_alu alu(.clk(clk),
                   .A(ro1),
                   .B(ro2),
                   .sub(sub_en),
                   .C(alu_data),
                   .fg_zero(zero));

    // Control Unit
    module_control_unit cu(.clk(clk),
                           .status(status),
                           .instruction(instruction),
                           .ra(ra),
                           .rb(rb),
                           .rc(rc),
                           .data(imm_data),
                           .wr_en(wr_en),
                           .sub(sub_en),
                           .alu_op(alu_op));

endmodule