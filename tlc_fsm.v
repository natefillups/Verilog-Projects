`timescale 1ns / 1ps

`define sec1     50000000
`define sec3    150000000
`define sec15   750000000
`define sec30  1500000000

module tlc_fsm(
    output reg [2:0] state,
    output reg RstCount,
    output reg [1:0] highwaySignal, farmSignal,
    input wire [31-1:0] Count,
    input wire Clk, Rst
);
    
    parameter s0 = 3'b000, 
    s1 = 3'b001, 
    s2 = 3'b010, 
    s3 = 3'b011, 
    s4 = 3'b100, 
    s5 = 3'b101;

    parameter green = 2'b11, 
    yellow = 2'b10, 
    red = 2'b00;
    
    reg [2:0] nextState;

    always@ (state)
        case (state)
            s0: 
            begin
                if (Count == `sec1) 
                    begin
                        highwaySignal = red; 
                        farmSignal = red;
                        RstCount = 0;
                        nextState = s1;
                    end
                else
                    begin
                        highwaySignal = red; 
                        farmSignal = red;
                        RstCount = 1;
                        nextState = s0;
                    end
            end
            s1: begin
                if(Count == `sec30 && farmSignal)	
                    begin
                        highwaySignal = green; 
                        farmSignal = red;       
                        RstCount = 0;
                        nextState = s2;
                    end
                else
                    begin
                        highwaySignal = green; 
                        farmSignal = red;
                        RstCount = + 1;
                        nextState = s1;
                    end
            end
           s2: begin
                if(Count == `sec3)	 
                    begin
                        highwaySignal = yellow; 
                        farmSignal = red;  
                        RstCount = 0;
                        nextState = s3;
                    end
                else
                    begin
                        highwaySignal = yellow; 
                        farmSignal = red;
                        RstCount = 1;
                        nextState = s2;
                    end
            end
            s3: 
            begin
                if(Count == `sec1)	
                    begin
                        highwaySignal = red;
                        farmSignal = red;  
                        RstCount = 0;
                        nextState = s4;
                    end
                else
                    begin
                        highwaySignal = red;
                        farmSignal = red;
                        RstCount = 1;
                        nextState = s3;
                    end
            end
            s4: 
            begin
                if(Count == `sec3 && (!farmSignal || Count >= `sec15))	
                    begin
                        highwaySignal = red;
                        farmSignal = green;  
                        RstCount = 0;
                        nextState = s5;
                    end
                else
                    begin
                        highwaySignal = red;
                        farmSignal = green;
                        RstCount = 1;
                        nextState = s4;
                    end
            end
            s5: 
            begin
                if(Count == `sec3)	
                    begin
                        highwaySignal = red;
                        farmSignal = yellow;  
                        RstCount = 0;
                        nextState = s0;
                    end
                else
                    begin
                        highwaySignal = red;
                        farmSignal = yellow;
                        RstCount = 1;
                        nextState = s5;
                    end
            end
        endcase
    always@ (posedge Clk)
        if(Rst)
            state <= s0;
        else
            state <= nextState;
    
    
endmodule