`timescale 1us/100ns

// PC program counter
//      input: next PC
//      output: PC
//      control: read and update (implicit)

module pc (
    D, clk, rst, Q
    );

    input wire [31:0] D; // pc_in
    input wire clk;
    input wire rst; 
    output wire [31:0] Q; // pc_out

    dff dff(
        .d(D)
        .clk(clk)
        .rst(rst)
        .q(Q)
    )
endmodule