`timescale 1ns / 1ps


module memory(
    input clk,
    input [15:0] address,
    input [15:0] data,
    input write_enable,
    input read_enable,
    output [15:0] read_data
);

    reg [15:0] ram [255:0];
    wire [7:0] ram_address = address[8:1];
    
    initial begin
        for (integer i = 0; i < 256; i=i+1)
            ram[i] = 16'd0;
    end
    
    always @(posedge clk) begin
        if (wrtie_enable)
            ram[ram_address] = data;
    end
    
    if (read_enable)
        assign read_data = ram[ram_address];
    else
        assign read_data = 16'd0;
    

endmodule