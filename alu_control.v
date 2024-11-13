`timescale 1us/100ns

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