`timescale 1us/100ns

module cpu_tb();

    // Testbench signals
    reg clk_tb, rst_tb;

    // Instantiate the CPU
    cpu cpu_inst (
        .clk(clk_tb),
        .rst(rst_tb)
    );

    // Clock generation: 100 MHz clock (10ns period)
    always begin
        #5 clk_tb = ~clk_tb;  // Toggle clock every 5 time units for a 10 time unit period
    end

    initial begin
        // Initialize clock and reset
        clk_tb = 0;
        rst_tb = 1;

        // Deassert reset after some time to allow memory loading
        #10;
        rst_tb = 0;  // Release reset and let the CPU start executing

        // Run the simulation for some time
        #5000;

        // Display register contents for verification
        $display("PC: %h", cpu_inst.instr);                    // Program counter
        $display("Instruction: %h", cpu_inst.instr_out);       // Current instruction
        $display("Register x1: %h", cpu_inst.register_file.registers[1]);  // Checking register x1
        $display("Register x2: %h", cpu_inst.register_file.registers[2]);
        $display("ALU Result: %h", cpu_inst.alu_result);       // ALU result
        $display("Data Memory Out: %h", cpu_inst.dmem_out);    // Data memory output
        $display("Write Data to Register: %h", cpu_inst.write_data); // Data written to registers

        // End simulation
        $stop;
    end
endmodule
