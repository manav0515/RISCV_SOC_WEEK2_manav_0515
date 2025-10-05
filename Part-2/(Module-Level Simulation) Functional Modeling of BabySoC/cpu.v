// Simple 8-bit CPU
module cpu(
    input clk,
    input reset,
    output reg [7:0] data_out
);
    reg [7:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 8'b0;
        else
            counter <= counter + 1;

        // Drive output inside always block
        data_out <= counter;
    end

endmodule

