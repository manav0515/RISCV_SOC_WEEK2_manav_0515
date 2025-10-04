// Simple 8-bit Memory
module memory(
    input clk,
    input reset,
    input [7:0] data_in,
    output reg [7:0] data_out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            data_out <= 8'b0;
        else
            data_out <= data_in + 1; // simple operation for demonstration
    end
endmodule
