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
`define BEQ   3'b000  // Branch if equal
`define BNE   3'b001  // Branch if not equal
`define BLT   3'b100  // Branch if less than
`define BGE   3'b101  // Branch if greater or equal
`define BLTU  3'b110  // Branch if Less Than (unsigned)
`define BGEU  3'b111  // Branch if Greater or Equal (unsigned)

`define BEQ_OP   4'b0001  // Branch if equal
`define BNE_OP   4'b0010  // Branch if not equal
`define BLT_OP   4'b0011  // Branch if less than (signed)
`define BGE_OP   4'b0100  // Branch if greater or equal (signed)
`define BLTU_OP  4'b0101  // Branch if less than (unsigned)
`define BGEU_OP  4'b0110  // Branch if greater or equal (unsigned)

// decode ops
`define R_TYPE_ALU_OP 4'b0010
`define I_TYPE_ALU_OP 4'b0000
`define S_TYPE_ALU_OP 4'b0001
`define BRANCH_ALU_OP 4'b0011
`define U_TYPE_ALU_OP 4'b0100
`define J_TYPE_ALU_OP 4'b0101

`endif