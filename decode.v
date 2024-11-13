`timescale 1us/100ns
`include "alu_defines.v"

// Takes the first 7 bits of instructions from imem and redirects to the correct unit
module decode(
    instr, branch, pc_sel, jump, mem_read, memtoreg, mem_write, alu_src, alu_op, write_enable, immediate
);
    input wire [31:0] instr;

    output reg branch;
    output reg [1:0] pc_sel;
    output reg jump;
    output reg mem_read;
    output reg memtoreg;
    output reg mem_write;
    output reg alu_src;
    output reg write_enable;
    output reg [3:0] alu_op;   // Now a 4-bit alu_op
    output reg [31:0] immediate;

    wire [6:0] opcode;
    assign opcode = instr[6:0];

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
                pc_sel = 2'b00;
                
                case ({instr[31:25], instr[14:12]})
                    10'b0000000_000: alu_op = `ADD;  // ADD
                    10'b0100000_000: alu_op = `SUB;  // SUB
                    10'b0000000_111: alu_op = `AND;  // AND
                    10'b0000000_110: alu_op = `OR;   // OR
                    // ... other R-type operations
                    default: alu_op = `UNKNOWN;
                endcase

                immediate = 32'b0;
            end

            `I_TYPE: 
            begin
                alu_src = 1;
                memtoreg = 1;
                write_enable = 1;
                mem_read = 1;
                mem_write = 0;
                branch = 0;
                pc_sel = 2'b00;

                case(instr[14:12])
                    3'b000: alu_op = `ADD;  // ADDI
                    3'b111: alu_op = `AND;  // ANDI
                    3'b110: alu_op = `OR;   // ORI
                    // ... other I-type instructions
                    default: alu_op = `UNKNOWN;
                endcase

                immediate = {{20{instr[31]}}, instr[31:20]};
            end

            `B_TYPE: 
            begin
                alu_src = 0;
                memtoreg = 0;
                write_enable = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 1;
                pc_sel = 2'b00;
                alu_op = `SUB;
                pc_sel = 2'b01;

                immediate = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            end

            `S_TYPE: 
            begin
                alu_src = 1;
                memtoreg = 0;
                write_enable = 0;
                mem_read = 0;
                mem_write = 1;
                branch = 0;
                pc_sel = 2'b00;
                
                alu_op = `ADD;  // For S-type instructions (store), typically use ADD

                immediate = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            end

            `J_TYPE: 
            begin
                alu_src = 0;
                memtoreg = 0;
                write_enable = 1;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                pc_sel = 2'b10;

                alu_op = `ADD;  // Generally use ADD for address calculation in jumps

                case(instr[14:12])
                    `BEQ: alu_op = `BEQ_OP;  // Set unique op codes for each branch type
                    `BNE: alu_op = `BNE_OP;
                    `BLT: alu_op = `BLT_OP;
                    `BGE: alu_op = `BGE_OP;
                    `BLTU: alu_op = `BLTU_OP;
                    `BGEU: alu_op = `BGEU_OP;
                    default: alu_op = `UNKNOWN;
                endcase
                
                immediate = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
            end

            default: 
            begin
                alu_src = 0;
                memtoreg = 0;
                write_enable = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                pc_sel = 2'b00;
                jump = 0;
                alu_op = `UNKNOWN;
                immediate = 32'b0;
            end
        endcase
    end
endmodule