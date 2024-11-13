`timescale 1us/100ns

`define SLLI 2'b00 
`define SRLI 2'b01
`define SRAI 2'b10 //SEXT

module barrel_shifter (
    IData, SAmt, SType, Odata
);
    input wire [31:0] IData;
    input wire [4:0] SAmt;
    input wire [1:0] SType;
    output reg [31:0] Odata;

    always @(*) begin 
        case(SType)
            `SLLI: Odata = IData << SAmt;
            `SRLI: Odata = IData >> SAmt; 
            `SRAI: Odata = $signed(IData) >>> SAmt; 
            default: Odata = IData; 
        endcase
    end
endmodule