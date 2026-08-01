module register_file (
    input  wire       clk,
    input  wire       reset,
    input  wire       write_enable,
    input  wire [1:0] destination,
    input  wire [1:0] r1,
    input  wire [1:0] r2,
    input  wire [7:0] write_data,
    output wire [7:0] r1_data,
    output wire [7:0] r2_data
);
    reg [7:0] registers [0:3];
    integer a;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (a = 0; a < 4; a = a + 1) begin
                registers[a] <= 0;
            end
        end else if (write_enable) begin
            registers[destination] <= write_data;
        end
    end
    assign r1_data = registers[r1];
    assign r2_data = registers[r2];
endmodule
