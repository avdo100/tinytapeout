module datapath (
    input  wire       clk,
    input  wire       reset,
    input  wire       load_a,
    input  wire       load_b,
    input  wire       write_enable, 
    input  wire [2:0] alu,
    input  wire [7:0] data_in_a,
    input  wire [7:0] data_in_b,
    input  wire [7:0] num,
    input  wire [7:0] ram,
    output reg  [7:0] result,
    output wire       zero
);
    reg [7:0] reg_a;
    reg [7:0] reg_b;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_a <= 8'b0;
            reg_b <= 8'b0;
        end else begin
            if (load_a) reg_a <= data_in_a;
            if (load_b) reg_b <= data_in_b;
        end
    end

 
always @(*) begin
    case (alu)
        000: result = reg_a + reg_b;      
        001: result = reg_a - reg_b;      
        010: result = ram;      
        100: result = num;          
        110: result = reg_a & reg_b;      
        111: result = reg_a | reg_b;      
        default: result = 0;
    endcase
end
    assign zero = (reg_a == 0); 

endmodule

