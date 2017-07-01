`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2017 09:02:12 PM
// Design Name: 
// Module Name: sobel_kernel
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


module sobel_kernel(
    input clk,
    input [1:0] mode,
    input [23:0] p00,
    input [23:0] p01,
    input [23:0] p02,
    input [23:0] p10,
    input [23:0] p11,
    input [23:0] p12,
    input [23:0] p20,
    input [23:0] p21,
    input [23:0] p22,
    output [23:0] o11
    );

    reg signed [10:0] gx_r_e1, gx_g_e1, gx_b_e1;
    reg signed [10:0] gy_r_e1, gy_g_e1, gy_b_e1;

    always @ (posedge clk) begin
        gx_r_e1 <= ( ( p02[23:16] - p00[23:16]) +
                     ((p12[23:16] - p10[23:16])<<1) +
                     ( p22[23:16] - p20[23:16]) );
        gx_g_e1 <= ( ( p02[15:8] - p00[15:8]) +
                     ((p12[15:8] - p10[15:8])<<1) +
                     ( p22[15:8] - p20[15:8]) );
        gx_b_e1 <= ( ( p02[7:0] - p00[7:0]) +
                     ((p12[7:0] - p10[7:0])<<1) +
                     ( p22[7:0] - p20[7:0]) );

        gy_r_e1 <= ( ( p20[23:16] - p00[23:16]) +
                     ((p21[23:16] - p01[23:16])<<1) +
                     ( p22[23:16] - p02[23:16]) );
        gy_g_e1 <= ( ( p20[15:8] - p00[15:8]) +
                     ((p21[15:8] - p01[15:8])<<1) +
                     ( p22[15:8] - p02[15:8]) );
        gy_b_e1 <= ( ( p20[7:0] - p00[7:0]) +
                     ((p21[7:0] - p01[7:0])<<1) +
                     ( p22[7:0] - p02[7:0]) );
    end

    wire [10:0] abs_gx_r_e1, abs_gx_g_e1, abs_gx_b_e1;
    wire [10:0] abs_gy_r_e1, abs_gy_g_e1, abs_gy_b_e1;
    assign abs_gx_r_e1 = gx_r_e1[10]? ~gx_r_e1+1 : gx_r_e1;
    assign abs_gx_g_e1 = gx_g_e1[10]? ~gx_g_e1+1 : gx_g_e1;
    assign abs_gx_b_e1 = gx_b_e1[10]? ~gx_b_e1+1 : gx_b_e1;
    assign abs_gy_r_e1 = gy_r_e1[10]? ~gy_r_e1+1 : gy_r_e1;
    assign abs_gy_g_e1 = gy_g_e1[10]? ~gy_g_e1+1 : gy_g_e1;
    assign abs_gy_b_e1 = gy_b_e1[10]? ~gy_b_e1+1 : gy_b_e1;

    wire [10:0] grad_r_e1, grad_g_e1, grad_b_e1;
    assign grad_r_e1 = abs_gx_r_e1 + abs_gy_r_e1;
    assign grad_g_e1 = abs_gx_g_e1 + abs_gy_g_e1;
    assign grad_b_e1 = abs_gx_b_e1 + abs_gy_b_e1;

    reg [7:0] grad_r_e2, grad_g_e2, grad_b_e2;
    always @ (posedge clk) begin
        grad_r_e2 <= (|grad_r_e1[10:8])? 8'hFF : grad_r_e1[7:0];
        grad_g_e2 <= (|grad_g_e1[10:8])? 8'hFF : grad_g_e1[7:0];
        grad_b_e2 <= (|grad_b_e1[10:8])? 8'hFF : grad_b_e1[7:0];
    end

    reg [7:0] grad_r_e3, grad_g_e3, grad_b_e3;
    always @ (posedge clk) begin
        case (mode)
            2'b01: begin
                grad_r_e3 <= (grad_r_e2>>2) + (grad_g_e2>>2) + (grad_b_e2>>2);
                grad_g_e3 <= (grad_r_e2>>2) + (grad_g_e2>>2) + (grad_b_e2>>2);
                grad_b_e3 <= (grad_r_e2>>2) + (grad_g_e2>>2) + (grad_b_e2>>2);
            end
            2'b10: begin
                grad_r_e3 <= grad_r_e2 | grad_g_e2 | grad_b_e2;
                grad_g_e3 <= grad_r_e2 | grad_g_e2 | grad_b_e2;
                grad_b_e3 <= grad_r_e2 | grad_g_e2 | grad_b_e2;
                end
            default: begin
                grad_r_e3 <= grad_r_e2;
                grad_g_e3 <= grad_g_e2;
                grad_b_e3 <= grad_b_e2;
            end
        endcase
    end

    assign o11 = {grad_r_e3, grad_g_e3, grad_b_e3};

endmodule
