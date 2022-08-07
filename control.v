`timescale 1ns / 1ps


module control(
    input [2:0] operation,
    input reset,
    output reg [1:0] reg_dst, mem_to_reg, alu_op,
    output reg jump, branch, mem_read, write, alu_src, reg_write, sign_or_zero
);

    `include "parameter.vh"
    
    always @* begin
        if (reset) begin
            reg_dst = 2'b00;
            mem_to_reg = 2'b00;
            alu_op = 2'b00;
            jump = 1'b0;
            branch = 1'b0;
            mem_read = 1'b0;
            write = 1'b0;
            alu_src = 1'b0;
            reg_write = 1'b0;
            sign_or_zero = 1'b0;
        end
    end
endmodule
