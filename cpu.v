`timescale 1us/100ns

module cpu(
    clk, rst
);
    // raw and decoded instructions
    wire [31:0] instr; // pc to imem
    wire [31:0] instr_out; // imem to rf

    wire [31:0] rd_out1; // connect rf rd1 to alu
    wire [31:0] rd_out2; // connect rf rd2 to alu_mux
    wire [31:0] imm_out; // haha from imm to alu_mux
    wire [31:0] amux_out; 


    wire [31:0] aluc_out; // send alu_c to alu
    wire [31:0] alu_result; // send data to dmem
    wire [31:0] dmem_out;

    wire [31:0] write_data; // send write data to rf

    wire zeroFlag;
    // connects the decoder to literally everything else lol
    wire regwrite, alusrc, memwrite, aluop, memtoreg, memread, branch, jump;

    // pc shenanigans 
    wire [1:0] pc_sel;
    reg [31:0] next_pc;

    always @(*) 
    begin
        case (pc_sel)
            2'b00: next_pc = instr + 32'd4;    
            2'b01: next_pc = instr + imm_out;
            2'b10: next_pc = rd_out1;    
            default: next_pc = instr + 32'd4;   
        endcase
    end

    dff pc(
        .d(next_pc),
        .clk(clk),
        .rst(rst),
        .q(instr)
    );

    memory2c instruction_memory(
        .data_out(instr_out),
        .data_in(32'b0),
        .addr(instr),
        .enable(1'b1),
        .wr(1'b0),
        .createdump(1'b0),
        .clk(clk),
        .rst(rst)
    );

    reg_file register_file(
        .rs1(instr_out[19:15]),
        .rs2(instr_out[24:20]),
        .rd(instr_out[11:7]),
        .write_data(write_data),
        .write_enable(regwrite),
        .clk(clk),
        .rst(rst),
        .read_data1(rd_out1),
        .read_data2(rd_out2)
    );

    alu alu(
        .a1(rd_out1),
        .a2(amux_out),
        .zeroFlag(zeroFlag),
        .ALU_control(aluc_out),
        Aout(alu_result)
    );

    mux2 alu_mux(
        .A(rd_out2), 
        .B(imm_out), 
        .sel(alusrc), 
        .Zout(amux_out)
    );

    alu_control alu_control(
        .ALU_op(aluop),
        .func7(instr_out[30]),
        .func3(instr_out[14:12]),
        .Aout(aluc_out) 
    );

    memory2c data_memory(
        .data_out(dmem_out),
        .data_in(rd_out1),
        .addr(alu_result),
        .enable(memread | memwrite),
        .wr(memwrite),
        .createdump(1'b0),
        .clk(clk),
        .rst(rst)
    );

    mux2 dmem_mux( 
        .A(alu_result), // a is 0, so switch the order (visually)
        .B(dmem_out), 
        .sel(memtoreg), 
        .Zout(write_data)
    );

    decode decoder(
        .instr(instr_out), 
        .branch(branch),
        .jump(jump),
        .mem_read(memread), 
        .memtoreg(memtoreg), 
        .mem_write(memwrite), 
        .alu_src(alusrc), 
        .alu_op(aluop), 
        .write_enable(regwrite), 
        .immediate(imm_out)
    );

    idk_top_stuff additional_decoder(
        .jump(jump),
        .branch(branch),
        .zeroFlag(zeroFlag),
        .pc_sel(pc_sel)
    );
endmodule

