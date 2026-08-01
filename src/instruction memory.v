module instruction_memory (
    input  wire [3:0] bus,
    output reg  [7:0] instruction
);
    always @(*) begin
        case (bus)
            
         default: instruction = 0;
        
        endcase
    end
endmodule  



