`timescale 1us/100ns

module mux2 (A, B, sel, Zout);
    input [31:0] A; // a is 0
    input [31:0] B; 
    input sel;
    output reg [31:0] Zout;

    always @(*) begin
        case(sel)
            1'b0: Zout = A;
            1'b1: Zout = B;
            default: Zout = 32'b0;
        endcase
    end
endmodule