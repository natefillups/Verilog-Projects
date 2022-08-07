`timescale 1ns / 1ps
`default_nettype none


module half_adder(S,Cout,A,B);

    input wire A,B;
    //inputs
    wire andAB, axorb;
    //declare wirenests
    output wire S, Cout;
    
    assign Cout = A&B;
    assign S = A^B;
endmodule
