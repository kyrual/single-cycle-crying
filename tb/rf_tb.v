`timescale 1ns/1ps

module reg_file_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg write_enable;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg [31:0] write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    // Instantiate the register file
    reg_file uut (
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test procedure
    initial begin
        // Reset the register file
        rst = 1;
        write_enable = 0;
        #10;
        rst = 0;
        
        // Test 1: Write to register 5, then read from it
        rd = 5;
        write_data = 32'hABCD1234;
        write_enable = 1;
        #10;
        write_enable = 0;

        rs1 = 5;
        #10;
        $display("Test 1 - Write/Read from register 5: read_data1 = %h (expected AB CD 12 34)", read_data1);

        // Test 2: Write to another register and read from both registers
        rd = 10;
        write_data = 32'h12345678;
        write_enable = 1;
        #10;
        write_enable = 0;

        rs1 = 5;
        rs2 = 10;
        #10;
        $display("Test 2 - Read from register 5 and 10: read_data1 = %h (expected ABCD1234), read_data2 = %h (expected 12345678)", read_data1, read_data2);

        // Test 3: Reset and check if registers are cleared
        rst = 1;
        #10;
        rst = 0;
        
        rs1 = 5;
        rs2 = 10;
        #10;
        $display("Test 3 - After reset: read_data1 = %h (expected 00000000), read_data2 = %h (expected 00000000)", read_data1, read_data2);

        // End the simulation
        $stop;
    end

endmodule