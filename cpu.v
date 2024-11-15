`timescale 1us/100ns

module cpu(
    clk, rst
);
    input wire clk, rst;

    // raw and decoded instructions
    wire [31:0] instr; // pc to imem
    wire [31:0] instr_out; // imem to rf

    wire [31:0] rd_out1; // connect rf rd1 to alu
    wire [31:0] rd_out2; // connect rf rd2 to alu_mux
    wire [31:0] imm_out; // haha from imm to alu_mux
    wire [31:0] amux_out; 


    wire [3:0] aluc_out; // send alu_c to alu
    wire [31:0] alu_result; // send data to dmem
    wire [31:0] dmem_out;

    wire [31:0] write_data; // send write data to rf

    wire zeroFlag;
    // connects the decoder to literally everything else lol
    wire [3:0] aluop;
    wire regwrite, alusrc, memwrite, memtoreg, memread, branch;

    // pc shenanigans 
    wire [1:0] pc_sel;
    reg [31:0] next_pc;
    wire [31:0] addsum;
    wire [31:0] cont;
    wire [31:0] pc_out;

    always @(*) 
    begin
        case (pc_sel)
            2'b00: next_pc = instr + 32'd4;    
            2'b01: addsum = instr + imm_out;
            2'b10: cont = rd_out1;    
            default: next_pc = instr + 32'd4;   
        endcase
    end
    mux2 pc_next(
        .A(next_pc),
        .B(addsum),
        .sel(branch && zeroFlag),
        .Zout(pc_out)
    );

    dff pc(
        .d(pc_out),
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
        .alu_op(aluop), 
        .Aout(alu_result), 
        .alu_zero(zeroFlag), 
    );

    mux2 alu_mux(
        .A(rd_out2), 
        .B(imm_out), 
        .sel(alusrc), 
        .Zout(amux_out)
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
        .mem_read(memread), 
        .memtoreg(memtoreg), 
        .mem_write(memwrite), 
        .alu_src(alusrc), 
        .alu_op(aluop), 
        .write_enable(regwrite), 
        .immediate(imm_out)
    );


endmodule