`timescale 1us/100ns

module dff ( // honorary pc
    input wire [31:0] d,
    input wire clk,
    input wire rst,
    output reg [31:0] q
);
    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
            q <= 32'b0;
        else 
            q <= d;
    end
endmodule

