// ALU
//      input: a1, a2
//      internal: Aout
//      out: Aout, zero
//      control: <ALUop>

`define AND 4'b0000
`define OR 4'b0001
`define add 4'b0010
`define sub 4'b0110

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
            `AND: Aout = a1 & a2;
            `OR: Aout = a1 | a2;
            `add: Aout = a1 + a2;w
            `sub: Aout = a1 - a2; 
            default: Aout = 32'b0;
        endcase
        zeroFlag = (out == 0);
    end
endmodule