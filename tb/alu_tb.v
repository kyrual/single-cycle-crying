`timescale 1us/100ns

module alu_tb;

    // Inputs to the ALU
    reg [31:0] a1;
    reg [31:0] a2;
    reg [3:0] ALU_control;

    // Outputs from the ALU
    wire [31:0] Aout;
    wire zeroFlag;

    // Instantiate the ALU module
    alu uut (
        .a1(a1),
        .a2(a2),
        .ALU_control(ALU_control),
        .Aout(Aout),
        .zeroFlag(zeroFlag)
    );

    // Test procedure
    initial begin
        // AND operation test
        ALU_control = 4'b0000;  // AND
        a1 = 32'hA5A5A5A5;
        a2 = 32'h5A5A5A5A;
        #10;
        $display("AND Test: Aout = %h, Expected = %h, zeroFlag = %b", Aout, (a1 & a2), zeroFlag);

        // OR operation test
        ALU_control = 4'b0001;  // OR
        a1 = 32'hA5A5A5A5;
        a2 = 32'h5A5A5A5A;
        #10;
        $display("OR Test: Aout = %h, Expected = %h, zeroFlag = %b", Aout, (a1 | a2), zeroFlag);

        // ADD operation test
        ALU_control = 4'b0010;  // ADD
        a1 = 32'h00000015;
        a2 = 32'h0000001A;
        #10;
        $display("ADD Test: Aout = %h, Expected = %h, zeroFlag = %b", Aout, (a1 + a2), zeroFlag);

        // SUBTRACT operation test
        ALU_control = 4'b0110;  // SUBTRACT
        a1 = 32'h0000001A;
        a2 = 32'h0000001A;
        #10;
        $display("SUB Test: Aout = %h, Expected = %h, zeroFlag = %b", Aout, (a1 - a2), zeroFlag);

        // Check zero flag when result is zero
        a1 = 32'h00000015;
        a2 = 32'h00000015;
        #10;
        $display("Zero Flag Test: Aout = %h, Expected = 00000000, zeroFlag = %b", Aout, zeroFlag);

        // Finish simulation
        $finish;
    end
endmodule