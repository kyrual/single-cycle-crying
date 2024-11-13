module alu (
    a1, a2, alu_op, Aout, alu_zero
);
    input [31:0] a1,
    input [31:0] a2,
    input [3:0] alu_op,
    output reg [31:0] Aout,
    output reg alu_zero,

    always @ (*) begin
        alu_zero = 0;
        case (alu_op)
            `ADD:  Aout = a1 + a2;
            `SUB:  Aout = a1 - a2;
            `AND:  Aout = a1 & a2;
            `OR:   Aout = a1 | a2;
            `XOR:  Aout = a1 ^ a2;
            `SLL:  Aout = a1 << a2[4:0];
            `SRL:  Aout = a1 >> a2[4:0];
            `SRA:  Aout = $signed(a1) >>> a2[4:0];
            default: Aout = 32'b0;
        endcase
        alu_zero = (Aout == 0);

        case (alu_op)
            `BEQ_OP: alu_zero = 1;         // Branch if equal
            `BNE_OP: alu_zero = 0;         // Branch if not equal
            `BLT_OP: alu_zero = 1;         // Branch if less than (signed) (set to 1 as placeholder)
            `BGE_OP: alu_zero = 0;         // Branch if greater or equal (signed) (set to 0 as placeholder)
            `BLTU_OP: alu_zero = 1;        // Unsigned branch less than (set to 1 as placeholder)
            `BGEU_OP: alu_zero = 0;        // Unsigned branch greater or equal (set to 0 as placeholder)
            default: alu_zero = 0;         // Default to no branch
        endcase
    end
endmodule