`timescale 1ns / 1ps
`default_nettype none


module clock_divider(ClkOut,ClkIn);
//output port needs to be described as output reg
output wire [3:0] ClkOut;
input wire ClkIn; // wire can drive regs

parameter n = 25; // this can change
reg [n:0] Count;

always@(posedge ClkIn)
    Count <= Count +1;
assign ClkOut[3:0] = Count[n:n-3];

endmodule
