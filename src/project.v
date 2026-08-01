/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module cpu (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    assign uio_out = 0;
    assign uio_oe  = 0;

    wire reset = ~rst_n;
    wire start = uio_in[0];
    wire [3:0] bus;
    wire [3:0] pc;
    wire [3:0] pc_inc;
    wire [3:0] pc_load;
    wire [7:0] instruction;
    wire [2:0] opcode;
    wire [2:0]  alu;
    wire [1:0] destination; 
    wire [1:0] r1;
    wire [1:0] r2;
    wire [7:0] num;
    wire [7:0] r1_data;
    wire [7:0] r1_data;
    wire [7:0] ram;
    wire [7:0] result;
    wire load_a;
    wire load_b;
    wire register;
    wire memory;
    wire zero;

    program_counter pc (
        .clk(clk),
        .reset(reset),
        .pc_inc(pc_inc),
        .pc_load(pc_load),
        .target_pc(target_pc),
        .bus(bus)
    );

    instruction_memory mem (
        .bus(bus),
        .instruction(instruction)
    );

    instruction_decoder decoder (
        .instruction(instruction),
        .opcode(opcode),
        .destination(destination),
        .r1(r1),
        .r2(r2),
        .num(num),
        .target_pc(target_pc)
    );

    register_file register (
        .clk(clk),
        .reset(reset),
        .write_enable(register),
        .destination(destination),
        .r1(r1),
        .r2(r2),
        .write_data(result),
        .r1_data(r1_data),
        .r2_data(r2_data)
    );

    
    data_memory rom (
        .clk(clk),
        .write_enable(memory),
        .address(r2_data),
        .write_data(r1_data), 
        .read_data(ram)
    );

    controller control (
        .clk(clk),
        .reset(reset),
        .start(start),
        .opcode_in(opcode),
        .zero(zero),
        .load_a(load_a),
        .load_b(load_b),
        .register(register),
        .memory(memory),
        .pc_inc(pc_inc),
        .pc_load(pc_load),
        .alu(alu)
    );

    datapath datap (
        .clk(clk),
        .reset(reset),
        .load_a(load_a),
        .load_b(load_b),
        .write_enable(register),
        .alu(alu),
        .data_in_a(r1_data),
        .data_in_b(r2_data),
        .num(num),
        .ram(ram),
        .result(result),
        .zero(zero)
    );

    assign uo_out = result;

    wire _unused = &{ena, ui_in, uio_in[7:1], 1'b0};

endmodule
