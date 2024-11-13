`timescale 1us/100ns

`define R_TYPE 7'b0110011
`define I_TYPE 7'b0000011
`define S_TYPE 7'b0100011
`define B_TYPE 7'b1100011
`define U_TYPE 7'b0000111
`define J_TYPE 7'b1101111

// takes the first 7 bits of instructions from imem and redirects to the correct unit
module decode(
    instr, branch, jump, mem_read, memtoreg, mem_write, alu_src, alu_op, write_enable, immediate
    );
    input wire [31:0] instr;

    output reg branch;
    output reg jump;
    output reg mem_read;
    output reg memtoreg;
    output reg mem_write;
    output reg alu_src;
    output reg [1:0] alu_op;
    output reg [31:0 immediate;
    ]
    assign opcode = instr[6:0]

    always @(*) begin
        case(opcode)
            `R_TYPE: 
            begin
                alu_src = 0;
                memtoreg = 0;
                write_enable = 1;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b10;

                immediate = 32'b0;
                jump = 0;
            end
            `I_TYPE: 
            begin
                alu_src = 1;
                memtoreg = 1;
                write_enable = 1;
                mem_read = 1;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;

                immediate = {{20{instruction[31]}}, instruction[31:20]};
                jump = 0;
            end
            `S_TYPE: 
            begin
                alu_src = 1;
                memtoreg = 0;
                write_enable = 1;
                mem_read = 0;
                mem_write = 1;
                branch = 0;
                alu_op = 2'b00;

                jump = 0;
                immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            `B_TYPE: 
            begin
                alu_src = 0;
                memtoreg = 0;
                write_enable = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 1;
                alu_op = 2'b00;

                jump = 0;
                immediate = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            end
            `U_TYPE: 
            begin 
                alu_src = 0;
                memtoreg = 0;
                write_enable = 1;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;
                
                immediate = {instruction[31:12], 12'b0};
                jump = 0;
            end
            `J_TYPE: 
            begin 
                alu_src = 0;
                memtoreg = 0;
                write_enable = 1;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;
                
                immediate = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}; 
                jump = 1;
            end
            default: 
                alu_src = 0;
                memtoreg = 0;
                write_enable = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;
                
                immediate = 32'b0;
                jump = 0;
        endcase
    end
endmodule