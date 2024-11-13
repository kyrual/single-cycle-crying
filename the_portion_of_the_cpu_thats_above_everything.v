`timescale 1us/100ns
`include "alu_defines.v"

// bruh ngl im just too lazy to add it to my decoder
module idk_top_stuff (
    jump, branch, zeroFlag, pc_sel
    );
    input jump, branch, zeroFlag;
    output reg [1:0] pc_sel;

    always @(*) begin
        if (jump) 
        begin
            pc_sel = 2'b10;
        end 
        else if (branch && zeroFlag) 
        begin
            pc_sel = 2'b01;
        end 
        else 
        begin
            pc_sel = 2'b00;
        end
    end
endmodule