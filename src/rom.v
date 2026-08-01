module data_memory (
    input  wire       clk,
    input  wire       write_enable,
    input  wire [3:0] address,
    input  wire [7:0] write_data,
    output wire [7:0] read_data
);
    reg [7:0] ram [0:15];

    always @(posedge clk) begin
        if (write_enable) begin
            ram[address] <= write_data;
        end
    end

    assign read_data = ram[address];
endmodule
