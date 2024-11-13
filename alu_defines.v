// alu_defines.v
`ifndef ALU_DEFINES
`define ALU_DEFINES

// RISC-V Instruction Types
`define R_TYPE 7'b0110011
`define I_TYPE 7'b0000011
`define S_TYPE 7'b0100011
`define B_TYPE 7'b1100011
`define U_TYPE 7'b0000111
`define J_TYPE 7'b1101111

// ALU Operations
`define AND 4'b0000
`define OR  4'b0001
`define ADD 4'b0010
`define SUB 4'b0110
`define XOR 4'b0100
`define SLL 4'b0000
`define SRL 4'b0011
`define SRA 4'b0101

// ALU Control Function Codes
`define FUNC3_ADD  3'b000
`define FUNC3_SUB  3'b000
`define FUNC3_AND  3'b111
`define FUNC3_OR   3'b110
`define FUNC3_XOR  3'b100
`define FUNC3_SLL  3'b001
`define FUNC3_SRL  3'b101
`define FUNC3_SRA  3'b101

`endif