`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2017 10:50:17 PM
// Design Name: 
// Module Name: tb_sobel_trans
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


module tb_sobel_trans(
    );
    reg clk;
    wire hsync, vsync, vde;
    wire [23:0] data;

    vga_sim U_vga_sim (
        .clk(clk),
        .data(data),
        .hsync(hsync),
        .vsync(vsync),
        .vde(vde)
    );

    wire [31:0] bram0_data_rd;
    wire [31:0] bram1_data_rd;
    wire [31:0] bram2_data_rd;

    wire [31:0] bram_addr;
    wire [31:0] bram_data_wr;

    wire bram_en;

    wire [3:0] bram0_wr_en;
    wire [3:0] bram1_wr_en;
    wire [3:0] bram2_wr_en;

    wire [23:0] final_data;
    wire final_hsync;
    wire final_vsync;
    wire final_vde;

    sobel_trans U_sobel_trans (
        .hData(data),
        .hHSync(hsync),
        .hVSync(vsync),
        .hVDE(vde),
        .pixelClk(clk),
        .bram0_data_rd(bram0_data_rd),
        .bram1_data_rd(bram1_data_rd),
        .bram2_data_rd(bram2_data_rd),
        .bram_addr(bram_addr),
        .bram_data_wr(bram_data_wr),
        .bram_en(bram_en),
        .bram0_wr_en(bram0_wr_en),
        .bram1_wr_en(bram1_wr_en),
        .bram2_wr_en(bram2_wr_en),
        .vData(final_data),
        .vHSync(final_hsync),
        .vVSync(final_vsync),
        .vVDE(final_vde)
    );

    bram_test_wrapper U_bram (
        .bram0_data_rd(bram0_data_rd),
        .bram0_wr_en(bram0_wr_en),
        .bram1_data_rd(bram1_data_rd),
        .bram1_wr_en(bram1_wr_en),
        .bram2_data_rd(bram2_data_rd),
        .bram2_wr_en(bram2_wr_en),
        .bram_addr(bram_addr),
        .bram_data_wr(bram_data_wr),
        .bram_en(bram_en),
        .clk(clk)
    );

    always
        #5  clk = !clk;

    initial begin
        clk = 0;
        #400 $finish;
    end

endmodule
