module controller (
    input  wire       clk,
    input  wire       reset,
    input  wire       start,
    input  wire [2:0] opcode_in,
    input  wire       zero,
    output reg        load_a,
    output reg        load_b,
    output reg        register,
    output reg        memory,
    output reg        pc_inc,
    output reg        pc_load,
    output reg  [2:0] alu
);
    localparam STATE_IDLE  = 00;
    localparam STATE_FETCH = 01;
    localparam STATE_EXEC  = 10;

    reg [1:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) state <= STATE_IDLE;
        else       state <= next_state;
    end

    always @(*) begin
        load_a       = 0;
        load_b       = 0;
        register      = 0;
        memory       = 0;
        pc_inc       = 0;
        pc_load      = 0;
        alu       = opcode_in;
        next_state   = state;

        case (state)
            STATE_IDLE: begin
                if (start) next_state = STATE_FETCH;
            end

            STATE_FETCH: begin
                load_a = 1'b1;
                load_b = 1'b1;
                next_state = STATE_EXEC;
            end
STATE_EXEC: begin
    case (opcode_in)
        000: register = 1; 
        001: register = 1; 
        010: register = 1; 
        011: memory = 1; 
        100: register = 1; 
        101: if (zero) pc_load = 1; 
        110: register = 1; 
        111: register = 1; 
        default: ; 
    endcase
    pc_inc = ~pc_load; 
    next_state = STATE_FETCH;
end
          
        endcase
    end
endmodule


