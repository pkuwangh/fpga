`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2017 02:34:11 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input [3:0] sw,
    input [3:0] btn,
    output [3:0] led
    );
    
    reg [31:0] count;
    reg [4:0] period;
    reg [4:0] button_state;
    
    assign led = sw & {4{count[period]}};
    // counter
    always @ (posedge(clk)) begin
        count <= count + 1;
        period <= btn[0]? 5'b11000 : period;
        if (btn[0])
            period <= 5'b11000;
        else if (btn[1] && !button_state[1])
            period <= period + 1'b1;
        else if (btn[2] && !button_state[2])
            period <= period - 1'b1;
        else 
            period <= period;
        button_state <= btn;
    end
    
endmodule
