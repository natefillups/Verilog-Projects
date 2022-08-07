`timescale 1ns / 1ps
`default_nettype none

module up_counter(Count, Carry2, En, Clk, Rst);

    output reg [2:0] Count; // using behavioral so use regs with outputs
    output wire Carry2;
    
    // input wire nest
    input wire En, Clk, Rst;
    
    wire [2:0] Carry, Sum;
    Threebit_counter UC1(Sum,Carry2,Count,En);
    // implie always rest
    always@(posedge Clk or posedge Rst)
        if(Rst)
            Count <= 0;
        else
            Count <= Sum;
endmodule

module Threebit_counter(Sum, Carry2, Count, En);
    // declare variables
    input wire En;
    input  wire [2:0] Count;
    output wire [2:0] Sum;
    output wire Carry2;
    wire [2:0] Carry;
    
    //module half_adder(S,Cout,A,B);
    
    half_adder add0(Sum[0],Carry[0],En, Count[0]);
    half_adder add1(Sum[1],Carry[1],Carry[0], Count[1]);
    half_adder add2(Sum[2],Carry[2],Carry[1],Count[2]);
    
    assign Carry2 = Carry[2];

endmodule
