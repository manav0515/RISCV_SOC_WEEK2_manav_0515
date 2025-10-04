`timescale 1ns/1ps

module baby_soc_tb;

    reg clk;
    reg reset;
    wire [7:0] cpu_to_mem;
    wire [7:0] mem_to_cpu;
    wire [7:0] mem_to_periph;
    wire [7:0] periph_to_cpu;

    // Instantiate top module
    baby_soc uut(
        .clk(clk),
        .reset(reset),
        .cpu_to_mem(cpu_to_mem),
        .mem_to_cpu(mem_to_cpu),
        .mem_to_periph(mem_to_periph),
        .periph_to_cpu(periph_to_cpu)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns period

    // Reset generation
    initial begin
        reset = 1;
        #20; // hold reset for 20ns
        reset = 0;
    end

    // Generate waveform
    initial begin
        $dumpfile("baby_soc.vcd");
        $dumpvars(0, baby_soc_tb);
        #200; // simulation time
        $finish;
    end

endmodule
