`timescale 1us/100ns

module decode_tb;

    // Inputs
    reg [31:0] instr;

    // Outputs
    wire branch;
    wire jump;
    wire mem_read;
    wire memtoreg;
    wire mem_write;
    wire alu_src;
    wire [1:0] alu_op;
    wire write_enable;
    wire [31:0] immediate;

    // Instantiate the decode module
    decode uut (
        .instr(instr),
        .branch(branch),
        .jump(jump),
        .mem_read(mem_read),
        .memtoreg(memtoreg),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .alu_op(alu_op),
        .write_enable(write_enable),
        .immediate(immediate)
    );

    // Test procedure
    initial begin
        // R-Type Instruction Test
        instr = 32'b0000000_00010_00001_000_00011_0110011; // example R-type instruction
        #10;
        $display("R-Type: branch=%b, jump=%b, mem_read=%b, memtoreg=%b, mem_write=%b, alu_src=%b, alu_op=%b, write_enable=%b, immediate=%h",
                 branch, jump, mem_read, memtoreg, mem_write, alu_src, alu_op, write_enable, immediate);

        // I-Type Instruction Test
        instr = 32'b000000000100_00001_010_00010_0000011; // example I-type instruction
        #10;
        $display("I-Type: branch=%b, jump=%b, mem_read=%b, memtoreg=%b, mem_write=%b, alu_src=%b, alu_op=%b, write_enable=%b, immediate=%h",
                 branch, jump, mem_read, memtoreg, mem_write, alu_src, alu_op, write_enable, immediate);

        // S-Type Instruction Test
        instr = 32'b0000000_00011_00010_010_00100_0100011; // example S-type instruction
        #10;
        $display("S-Type: branch=%b, jump=%b, mem_read=%b, memtoreg=%b, mem_write=%b, alu_src=%b, alu_op=%b, write_enable=%b, immediate=%h",
                 branch, jump, mem_read, memtoreg, mem_write, alu_src, alu_op, write_enable, immediate);

        // B-Type Instruction Test
        instr = 32'b0000000_00010_00001_000_00011_1100011; // example B-type instruction
        #10;
        $display("B-Type: branch=%b, jump=%b, mem_read=%b, memtoreg=%b, mem_write=%b, alu_src=%b, alu_op=%b, write_enable=%b, immediate=%h",
                 branch, jump, mem_read, memtoreg, mem_write, alu_src, alu_op, write_enable, immediate);

        // U-Type Instruction Test
        instr = 32'b00000000000000000001_00000_0000111; // example U-type instruction
        #10;
        $display("U-Type: branch=%b, jump=%b, mem_read=%b, memtoreg=%b, mem_write=%b, alu_src=%b, alu_op=%b, write_enable=%b, immediate=%h",
                 branch, jump, mem_read, memtoreg, mem_write, alu_src, alu_op, write_enable, immediate);

        // J-Type Instruction Test
        instr = 32'b00000000000000000001_00000_1101111; // example J-type instruction
        #10;
        $display("J-Type: branch=%b, jump=%b, mem_read=%b, memtoreg=%b, mem_write=%b, alu_src=%b, alu_op=%b, write_enable=%b, immediate=%h",
                 branch, jump, mem_read, memtoreg, mem_write, alu_src, alu_op, write_enable, immediate);

        $finish;
    end
endmodule