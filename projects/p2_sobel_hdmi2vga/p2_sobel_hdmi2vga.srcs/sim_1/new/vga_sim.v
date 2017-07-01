`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2017 10:47:48 PM
// Design Name: 
// Module Name: vga_sim
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


module vga_sim(
    input clk,
    output [23:0] data,
    output reg hsync,
    output reg vsync,
    output vde
    );

    reg [23:0] rgb = 24'b0;
    reg [3:0] pixel_count = 4'b0;
    reg [3:0] line_count = 4'b0;
    reg newline = 1'b0;

    always @ (posedge clk) begin
        rgb <= rgb + 1'b1;
        pixel_count <= (pixel_count == 4'h7) ? 4'b0 : (pixel_count + 1'b1);
    end

    always @ (posedge clk) begin
        if (pixel_count >= 4'h6 && pixel_count < 4'h7)
            hsync <= 1'b0;
        else
            hsync <= 1'b1;
    end

    always @ (posedge clk) begin
        if (pixel_count == 4'b0)
            newline <= 1'b1;
        else
            newline <= 1'b0;
    end

    always @ (posedge newline) begin
        line_count <= (line_count == 4'h3) ? 4'b0 : (line_count + 1'b1);
    end

    always @ (posedge newline) begin
        if (line_count >= 4'h2 && line_count < 4'h3)
            vsync <= 1'b0;
        else
            vsync <= 1'b1;
    end

    assign data = rgb;
    assign vde = 1'b1;

endmodule
