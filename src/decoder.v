module instruction_decoder (
    input  wire [7:0] instruction,
    output wire [2:0] opcode,
    output wire [1:0] destination,
    output wire [1:0] r1,
    output wire [1:0] r2,
    output wire [7:0] num,
    output wire [3:0] pc
);
    assign opcode    = instruction[7:5];
    assign destination   = instruction[4:3];
    assign r1  = instruction[2:1];
    assign r2  = {0, instruction[0]}; 
    assign num = {0, instruction[3:0]}; 
    assign pc = instruction[3:0];
endmodule
