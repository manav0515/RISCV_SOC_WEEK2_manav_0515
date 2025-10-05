`timescale 1ns/1ps

module baby_soc(
    input clk,
    input reset,
    output [7:0] cpu_to_mem,
    output [7:0] mem_to_cpu,
    output [7:0] mem_to_periph,
    output [7:0] periph_to_cpu
);

    wire [7:0] cpu_out;
    wire [7:0] mem_out;
    wire [7:0] periph_out;

    // Instantiate CPU
    cpu CPU1(
        .clk(clk),
        .reset(reset),
        .data_out(cpu_out)
    );

    // Instantiate Memory
    memory MEM1(
        .clk(clk),
        .reset(reset),
        .data_in(cpu_out),
        .data_out(mem_out)
    );

    // Instantiate Peripheral
    peripheral PER1(
        .clk(clk),
        .reset(reset),
        .data_in(mem_out),
        .data_out(periph_out)
    );

    assign cpu_to_mem = cpu_out;
    assign mem_to_cpu = mem_out;
    assign mem_to_periph = mem_out;
    assign periph_to_cpu = periph_out;

endmodule
