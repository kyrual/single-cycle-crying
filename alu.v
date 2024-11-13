`timescale 1us/100ns
`include "alu_defines.v"
// ALU
//      input: a1, a2
//      internal: Aout
//      out: Aout, zero
//      control: <ALUop>

module alu (
    a1, a2, zeroFlag, ALU_control, Aout
);
    input [31:0] a1;
    input [31:0] a2;
    input [3:0] ALU_control;

    output reg zeroFlag; 
    output reg [31:0] Aout;

    always @ (*)
    begin
        case (ALU_control)
            `ADD:    Aout = a1 + a2;          // ADD operation
            `SUB:    Aout = a1 - a2;          // SUB operation
            `AND:    Aout = a1 & a2;          // AND operation
            `OR:     Aout = a1 | a2;          // OR operation
            `XOR:    Aout = a1 ^ a2;          // XOR operation
            `SLL:    Aout = a1 << a2[4:0];    // Shift Left Logical
            `SRL:    Aout = a1 >> a2[4:0];    // Shift Right Logical
            `SRA:    Aout = $signed(a1) >>> a2[4:0];  // Shift Right Arithmetic
            default: Aout = 32'b0;            // Default: return zero if no match
        endcase
        zeroFlag = (Aout == 0);
    end
endmodule