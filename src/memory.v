/*
 * Implementation of Data memory module
 */
module module_data_memory #(parameter WORD_SIZE=32, ADDRESS_BITS=32, MEMORY=1024)
                           (input wr_en,
                            input [ADDRESS_BITS-1:0] addr,
                            input [WORD_SIZE-1:0] data_in,
                            output reg [WORD_SIZE-1:0] data_out);

    // Actual Memory declaration
    reg [WORD_SIZE-1:0] mem [MEMORY - 1 : 0];

    // Write to memory if WR_EN is TRUE
    always @(addr) begin
      if (wr_en) mem[addr] <= data_in;
      else data_out <= mem[addr];
    end
endmodule

/*
 * Implementation of Instruction memory module
 */
module module_instruction_memory #(parameter ADDRESS_BITS=32, MEMORY=1024, WORD_SIZE=32)
                                  (input [ADDRESS_BITS-1:0] addr,
                                   input prog,
                                   input [WORD_SIZE-1:0] code,
                                   output reg [WORD_SIZE-1:0] instruction);

    // Create the memory
    reg [WORD_SIZE-1:0] instruction_memory [0:MEMORY-1];

    // Write the instruction to output or save an incoming port.
    always @(addr) begin
        case (addr)
            0: instruction <= 32'b001_00000_00000_00000_00000000000001;
            4: instruction <= 32'b001_00001_00000_00000_00000000000001;
            8: instruction <= 32'b000_00010_00000_00001_00000000000000;
            default: instruction <= 32'b000_00010_00000_00001_00000000000000;
        endcase

        // TODO: Enable this and remove the case above once we are able to program the iRAM
        // if (prog) instruction_memory[addr] <= code;
        // else instruction <= instruction_memory[addr];
    end
endmodule

/*
 * Implementation of Register bank
 */
module module_register_bank #(parameter REGISTER_COUNT=32, REGISTER_WIDTH=32, ADDRESS_BITS=5)
                             (input clk,
                              input [ADDRESS_BITS-1:0] ra, rb, rc,
                              input wr_en,
                              input [REGISTER_WIDTH-1:0] data_in,
                              output reg [REGISTER_WIDTH-1:0] ro1, ro2);

    // Create a Register Bank
    reg [REGISTER_WIDTH-1:0] reg_file [0:REGISTER_COUNT-1];

    always @(posedge clk) begin
        // Output the content of the selected registers
        ro1 <= reg_file[rb];
        ro2 <= reg_file[rc];

        // Last register is always Zero!
        reg_file[REGISTER_COUNT-1] <= 0;

        // Load in the appropriate register when wr_en is true
        if (wr_en) reg_file[ra] <= data_in;
    end
endmodule