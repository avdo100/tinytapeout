

module program_counter (
    input  wire       clk,
    input  wire       reset,
    input  wire [3:0] pc_inc,
    input  wire [3:0] pc_load,
    input  wire [3:0] pc,
    output reg  [3:0] bus
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bus <= 0;
        end else if (pc_load) begin
            bus <= pc;
        end else if (pc_inc) begin
            bus <= bus + 1;
        end
    end
endmodule
