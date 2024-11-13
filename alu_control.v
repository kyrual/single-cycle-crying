// The inputs are the ALUOp and funct fields. Only the
// entries for which the ALU control is asserted are shown. Some don’t-care entries have been added. For example, the ALUOp does not use the
// encoding 11, so the truth table can contain entries 1X and X1, rather than 10 and 01. While we show all 10 bits of funct fields, note that the only
// bits with different values for the four R-format instructions are bits 30, 14, 13, and 12. Thus, we only need these four funct field bits as input for
// ALU control instead of all 10.

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
        // WHAT DO THE 4 BIT OUTPUTTED OPCODES MEAN WHY DIDNT THE BOOK SPECIFY
        // GAHHFHEFHSOPIFHSEPOFS EPFHSFPISHEFP OSE FSOIEFH
            12'b00_xxxxxxx_xxx : Aout = 4'b0010; 
            12'bx1_xxxxxxx_xxx : Aout = 4'b0110;
            12'b1x_0000000_000 : Aout = 4'b0010;
            12'b1x_0100000_000 : Aout = 4'b0110;
            12'b1x_0000000_111 : Aout = 4'b0000;
            12'b1x_0000000_110 : Aout = 4'b0001;
            default: Aout = 4'bxxxx;
        endcase
    end
endmodule