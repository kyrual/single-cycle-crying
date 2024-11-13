`timescale 1us/100ns
`include "alu_defines.v"

module alu_control (
    ALU_op, func7, func3, Aout
);
    input [1:0] ALU_op;
    input [31:25] func7;
    input [14:12] func3;
    
    output reg [3:0] Aout;

    always @ (*)
    begin
        case({ALU_op, func7, func3})
        // GAHHFHEFHSOPIFHSEPOFS EPFHSFPISHEFP OSE FSOIEFH
            // ALU_op = 00 (I-type instructions)
            12'b00_???????_000 : Aout = `ADD;  // ADDI
            12'b00_???????_111 : Aout = `AND;  // ANDI
            12'b00_???????_110 : Aout = `OR;   // ORI

            // ALU_op = 01 (Branch instructions, typically subtraction)
            12'b01_???????_000 : Aout = `SUB;  // SUB (BEQ, BNE)

            // ALU_op = 10 (R-type instructions)
            12'b10_0000000_000 : Aout = `ADD;  // ADD
            12'b10_0100000_000 : Aout = `SUB;  // SUB
            12'b10_0000000_111 : Aout = `AND;  // AND
            12'b10_0000000_110 : Aout = `OR;   // OR
            12'b10_0000000_100 : Aout = `XOR;  // XOR
            12'b10_0000000_001 : Aout = `SLL;  // SLL
            12'b10_0000000_101 : Aout = `SRL;  // SRL
            12'b10_0100000_101 : Aout = `SRA;  // SRA

        endcase
    end
endmodule