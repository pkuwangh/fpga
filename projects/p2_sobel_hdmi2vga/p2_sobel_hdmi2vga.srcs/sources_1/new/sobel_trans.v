`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Hao Wang
// 
// Create Date: 06/28/2017 09:04:18 PM
// Design Name: 
// Module Name: sobel_trans
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


module sobel_trans(
    // input from hdmi module
    input [3:0] buttons,
    input [23:0] hData,
    input hHSync,
    input hVSync,
    input hVDE,
    input pixelClk,
    // input from block RAMs
    input [31:0] bram0_data_rd,
    input [31:0] bram1_data_rd,
    input [31:0] bram2_data_rd,
    // output to block RAMs
    output [31:0] bram_addr,
    output [31:0] bram_data_wr,
    output bram_en,
    output reg [3:0] bram0_wr_en,
    output reg [3:0] bram1_wr_en,
    output reg [3:0] bram2_wr_en,
    // output to vga module
    output [23:0] vData,
    output vHSync,
    output vVSync,
    output vVDE,
    output areset
    );
    
    reg [26:0] data_e1;             // flop the data input from HDMI module
    reg [26:0] data_e2;
    reg [26:0] data_e3;
    reg [26:0] data_e4;
    reg [26:0] data_e5;

    reg [26:0] middle_data_p1;
    reg [26:0] middle_data_p2;
    reg [26:0] middle_data_p3;
    reg [26:0] bottom_data_p1;
    reg [26:0] bottom_data_p2;
    reg [26:0] bottom_data_p3;

    reg [31:0] counter = 32'b0;     // served as the address input
    reg [1:0] top_line = 2'b00;     // switch between 3 buffers
    reg [1:0] top_line_l1 = 2'b00;

    reg [1:0] mode = 2'b00;
    assign areset = buttons[0];
    always @ (posedge pixelClk) begin
        if (buttons[0])
            mode <= 2'b00;
        else if (buttons[1])
            mode <= 2'b01;
        else if (buttons[2])
            mode <= 2'b10;
        else if (buttons[3])
            mode <= 2'b11;
        else
            mode <= mode;
    end

    // update write pointer and address
    always @ (posedge pixelClk) begin
        if (buttons[0]) begin
            counter <= 32'b0;
            top_line <= 2'b00;
            top_line_l1 <= 2'b00;
            data_e1 <= 27'b0;
        end
        else begin
            if (data_e1[26] & ~hHSync) begin
                // start a new line
                counter <= 32'b0;
                top_line <= (top_line == 2'b10) ? 2'b00 : (top_line + 1'b1);
            end
            else begin
                counter <= counter + 4'h4;
            end
            top_line_l1 <= top_line;
            data_e1 <= {hHSync, hVSync, hVDE, hData};
            data_e2 <= data_e1;
            data_e3 <= data_e2;
            data_e4 <= data_e3;
            data_e5 <= data_e4;
        end
    end
    // output address to block RAM
    assign bram_addr = counter;
    // write data to block RAM
    assign bram_data_wr = {5'b0, data_e1};
    // read enable
    assign bram_en = 1'b1;
    // read/wrtie enable into block RAM
    always @ (*) begin
        case (top_line)
            2'b00: begin
                {bram0_wr_en, bram1_wr_en, bram2_wr_en} = {4'hF, 4'h0, 4'h0};
            end
            2'b01: begin
                {bram0_wr_en, bram1_wr_en, bram2_wr_en} = {4'h0, 4'hF, 4'h0};
            end
            2'b10: begin
                {bram0_wr_en, bram1_wr_en, bram2_wr_en} = {4'h0, 4'h0, 4'hF};
            end
            default: begin
                {bram0_wr_en, bram1_wr_en, bram2_wr_en} = 12'b0;
            end
        endcase
    end
    // flop output data from block ram
    always @ (posedge pixelClk) begin
        case (top_line_l1)
            2'b00: begin
                middle_data_p1 <= bram1_data_rd[26:0];
                bottom_data_p1 <= bram2_data_rd[26:0];
            end
            2'b01: begin
                middle_data_p1 <= bram2_data_rd[26:0];
                bottom_data_p1 <= bram0_data_rd[26:0];
            end
            2'b10: begin
                middle_data_p1 <= bram0_data_rd[26:0];
                bottom_data_p1 <= bram1_data_rd[26:0];
            end
            default: begin
                middle_data_p1 <= 32'b0;
                bottom_data_p1 <= 32'b0;
            end
        endcase
        middle_data_p2 <= middle_data_p1;
        bottom_data_p2 <= bottom_data_p1;
        middle_data_p3 <= middle_data_p2;
        bottom_data_p3 <= bottom_data_p2;
    end
    // output to VGA
    //assign {vHSync, vVSync, vVDE, vData} = middle_data_p2;
    //assign {vHSync, vVSync, vVDE, vData} = {data_e2[26:24], middle_data_p2[23:0]};
    //assign {vHSync, vVSync, vVDE, vData} = data_e4;

    wire [23:0] final;
    sobel_kernel Sobel_Conv(
        .clk(pixelClk),
        .mode(mode),
        .p00(data_e2),
        .p01(data_e3),
        .p02(data_e4),
        .p10(middle_data_p1),
        .p11(middle_data_p2),
        .p12(middle_data_p3),
        .p20(bottom_data_p1),
        .p21(bottom_data_p2),
        .p22(bottom_data_p3),
        .o11(final)
    );

    assign {vHSync, vVSync, vVDE, vData} = (mode == 2'b00) ?
        {data_e3[26:24], middle_data_p3[23:0]} : {data_e5[26:24], final};

//    assign {vHSync, vVSync, vVDE, vData} = {data_e4[26:24], data_e4[23:0]};
//    assign {vHSync, vVSync, vVDE, vData} = {data_e4[26:24], 24'hFFFFFF};

endmodule
