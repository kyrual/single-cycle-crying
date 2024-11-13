// R   registers
//      input: rs1, rs2, rd, Rdata
//      internal: R1,R2,
//      output: R1,R2
//      control: <Rwrite>

module reg_file (
    rs1, rs2, rd, write_data, write_enable, clk, rst, read_data1, read_data2
);
    input wire clk;
    input wire rst;
    input wire write_enable;

    input wire [19:15] rs1;
    input wire [24:20] rs2;
    input wire [11:7] rd; // register destination
    input wire [31:0] write_data;

    output wire [31:0] read_data1;
    output wire [31:0] read_data2;

    reg [31:0] registers [31:0];

    // assign where rd1 and 2 address data from
    assign read_data1 = registers[rs1]; 
    assign read_data2 = registers[rs2];

    // completely empty out the registers
    integer i;

    always @ (posedge clk)
    begin
        if(rst==1'b1)
            for(i = 0; i < 32; i = i + 1)
                registers[i] = 32'h0;
        else if (write_enable == 1'b1)
            registers[rd] = write_data;
    end

endmodule