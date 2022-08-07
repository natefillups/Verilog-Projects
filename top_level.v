`timescale 1ns / 1ps
`default_nettype none

module top_level(LEDs, SWs, BTNs, FastClk);
    output wire [3:0] LEDs;
    input wire [1:0] SWs;
    input wire [1:0] BTNs;
    input wire FastClk;
    
    wire [3:0] Clocks;
    reg SlowClk;
    
    always@(*)
        case(SWs)
            2'b00: SlowClk = Clocks[0];
            2'b01: SlowClk = Clocks[1];
            2'b10: SlowClk = Clocks[2];
            2'b11: SlowClk = Clocks[3];
        endcase
    up_counter UCI(LEDs[2:0], LEDs[3], BTNs[0], SlowClk, BTNs[1]);
    
    clock_divider clk_div0(.ClkOut(Clocks), .ClkIn(FastClk));
            
endmodule
