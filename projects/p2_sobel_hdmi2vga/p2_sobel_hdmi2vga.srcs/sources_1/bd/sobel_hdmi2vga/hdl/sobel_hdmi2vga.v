//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
//Date        : Fri Jun 30 23:16:21 2017
//Host        : vm-ubuntu running 64-bit Ubuntu 14.04.5 LTS
//Command     : generate_target sobel_hdmi2vga.bd
//Design      : sobel_hdmi2vga
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "sobel_hdmi2vga,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=sobel_hdmi2vga,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=8,numReposBlks=8,numNonXlnxBlks=3,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "sobel_hdmi2vga.hwdef" *) 
module sobel_hdmi2vga
   (RefClk,
    buttons,
    hdmi_clk_n,
    hdmi_clk_p,
    hdmi_d_n,
    hdmi_d_p,
    hdmi_hpd,
    hdmi_in_ddc_scl_i,
    hdmi_in_ddc_scl_o,
    hdmi_in_ddc_scl_t,
    hdmi_in_ddc_sda_i,
    hdmi_in_ddc_sda_o,
    hdmi_in_ddc_sda_t,
    hdmi_out_en,
    vga_b,
    vga_g,
    vga_hs,
    vga_r,
    vga_vs);
  input RefClk;
  input [3:0]buttons;
  input hdmi_clk_n;
  input hdmi_clk_p;
  input [2:0]hdmi_d_n;
  input [2:0]hdmi_d_p;
  output [0:0]hdmi_hpd;
  input hdmi_in_ddc_scl_i;
  output hdmi_in_ddc_scl_o;
  output hdmi_in_ddc_scl_t;
  input hdmi_in_ddc_sda_i;
  output hdmi_in_ddc_sda_o;
  output hdmi_in_ddc_sda_t;
  output [0:0]hdmi_out_en;
  output [4:0]vga_b;
  output [5:0]vga_g;
  output vga_hs;
  output [4:0]vga_r;
  output vga_vs;

  wire [0:0]GND_dout;
  wire RefClk_1;
  wire [0:0]VDD_dout;
  wire [31:0]blk_mem_gen_0_douta;
  wire [31:0]blk_mem_gen_1_douta;
  wire [31:0]blk_mem_gen_2_douta;
  wire [3:0]buttons_1;
  wire dvi2rgb_0_DDC_SCL_I;
  wire dvi2rgb_0_DDC_SCL_O;
  wire dvi2rgb_0_DDC_SCL_T;
  wire dvi2rgb_0_DDC_SDA_I;
  wire dvi2rgb_0_DDC_SDA_O;
  wire dvi2rgb_0_DDC_SDA_T;
  wire dvi2rgb_0_PixelClk;
  wire [23:0]dvi2rgb_0_vid_pData;
  wire dvi2rgb_0_vid_pHSync;
  wire dvi2rgb_0_vid_pVDE;
  wire dvi2rgb_0_vid_pVSync;
  wire hdmi_clk_n_1;
  wire hdmi_clk_p_1;
  wire [2:0]hdmi_d_n_1;
  wire [2:0]hdmi_d_p_1;
  wire [4:0]rgb2vga_0_vga_pBlue;
  wire [5:0]rgb2vga_0_vga_pGreen;
  wire rgb2vga_0_vga_pHSync;
  wire [4:0]rgb2vga_0_vga_pRed;
  wire rgb2vga_0_vga_pVSync;
  wire sobel_trans_0_areset;
  wire [31:0]sobel_trans_0_bram0_addr;
  wire [31:0]sobel_trans_0_bram0_data_wr;
  wire sobel_trans_0_bram0_rd_en;
  wire [3:0]sobel_trans_0_bram0_wr_en;
  wire [3:0]sobel_trans_0_bram1_wr_en;
  wire [3:0]sobel_trans_0_bram2_wr_en;
  wire [23:0]sobel_trans_0_vData;
  wire sobel_trans_0_vHSync;
  wire sobel_trans_0_vVDE;
  wire sobel_trans_0_vVSync;

  assign RefClk_1 = RefClk;
  assign buttons_1 = buttons[3:0];
  assign dvi2rgb_0_DDC_SCL_I = hdmi_in_ddc_scl_i;
  assign dvi2rgb_0_DDC_SDA_I = hdmi_in_ddc_sda_i;
  assign hdmi_clk_n_1 = hdmi_clk_n;
  assign hdmi_clk_p_1 = hdmi_clk_p;
  assign hdmi_d_n_1 = hdmi_d_n[2:0];
  assign hdmi_d_p_1 = hdmi_d_p[2:0];
  assign hdmi_hpd[0] = VDD_dout;
  assign hdmi_in_ddc_scl_o = dvi2rgb_0_DDC_SCL_O;
  assign hdmi_in_ddc_scl_t = dvi2rgb_0_DDC_SCL_T;
  assign hdmi_in_ddc_sda_o = dvi2rgb_0_DDC_SDA_O;
  assign hdmi_in_ddc_sda_t = dvi2rgb_0_DDC_SDA_T;
  assign hdmi_out_en[0] = GND_dout;
  assign vga_b[4:0] = rgb2vga_0_vga_pBlue;
  assign vga_g[5:0] = rgb2vga_0_vga_pGreen;
  assign vga_hs = rgb2vga_0_vga_pHSync;
  assign vga_r[4:0] = rgb2vga_0_vga_pRed;
  assign vga_vs = rgb2vga_0_vga_pVSync;
  sobel_hdmi2vga_xlconstant_1_0 GND
       (.dout(GND_dout));
  sobel_hdmi2vga_xlconstant_0_0 VDD
       (.dout(VDD_dout));
  sobel_hdmi2vga_blk_mem_gen_0_0 blk_mem_gen_0
       (.addra(sobel_trans_0_bram0_addr),
        .clka(dvi2rgb_0_PixelClk),
        .dina(sobel_trans_0_bram0_data_wr),
        .douta(blk_mem_gen_0_douta),
        .ena(sobel_trans_0_bram0_rd_en),
        .rsta(1'b0),
        .wea(sobel_trans_0_bram0_wr_en));
  sobel_hdmi2vga_blk_mem_gen_1_0 blk_mem_gen_1
       (.addra(sobel_trans_0_bram0_addr),
        .clka(dvi2rgb_0_PixelClk),
        .dina(sobel_trans_0_bram0_data_wr),
        .douta(blk_mem_gen_1_douta),
        .ena(sobel_trans_0_bram0_rd_en),
        .rsta(1'b0),
        .wea(sobel_trans_0_bram1_wr_en));
  sobel_hdmi2vga_blk_mem_gen_2_0 blk_mem_gen_2
       (.addra(sobel_trans_0_bram0_addr),
        .clka(dvi2rgb_0_PixelClk),
        .dina(sobel_trans_0_bram0_data_wr),
        .douta(blk_mem_gen_2_douta),
        .ena(sobel_trans_0_bram0_rd_en),
        .rsta(1'b0),
        .wea(sobel_trans_0_bram2_wr_en));
  sobel_hdmi2vga_dvi2rgb_0_0 dvi2rgb_0
       (.DDC_SCL_I(dvi2rgb_0_DDC_SCL_I),
        .DDC_SCL_O(dvi2rgb_0_DDC_SCL_O),
        .DDC_SCL_T(dvi2rgb_0_DDC_SCL_T),
        .DDC_SDA_I(dvi2rgb_0_DDC_SDA_I),
        .DDC_SDA_O(dvi2rgb_0_DDC_SDA_O),
        .DDC_SDA_T(dvi2rgb_0_DDC_SDA_T),
        .PixelClk(dvi2rgb_0_PixelClk),
        .RefClk(RefClk_1),
        .TMDS_Clk_n(hdmi_clk_n_1),
        .TMDS_Clk_p(hdmi_clk_p_1),
        .TMDS_Data_n(hdmi_d_n_1),
        .TMDS_Data_p(hdmi_d_p_1),
        .aRst(sobel_trans_0_areset),
        .pRst(1'b0),
        .vid_pData(dvi2rgb_0_vid_pData),
        .vid_pHSync(dvi2rgb_0_vid_pHSync),
        .vid_pVDE(dvi2rgb_0_vid_pVDE),
        .vid_pVSync(dvi2rgb_0_vid_pVSync));
  sobel_hdmi2vga_rgb2vga_0_0 rgb2vga_0
       (.PixelClk(dvi2rgb_0_PixelClk),
        .rgb_pData(sobel_trans_0_vData),
        .rgb_pHSync(sobel_trans_0_vHSync),
        .rgb_pVDE(sobel_trans_0_vVDE),
        .rgb_pVSync(sobel_trans_0_vVSync),
        .vga_pBlue(rgb2vga_0_vga_pBlue),
        .vga_pGreen(rgb2vga_0_vga_pGreen),
        .vga_pHSync(rgb2vga_0_vga_pHSync),
        .vga_pRed(rgb2vga_0_vga_pRed),
        .vga_pVSync(rgb2vga_0_vga_pVSync));
  sobel_hdmi2vga_sobel_trans_0_0 sobel_trans_0
       (.areset(sobel_trans_0_areset),
        .bram0_data_rd(blk_mem_gen_0_douta),
        .bram0_wr_en(sobel_trans_0_bram0_wr_en),
        .bram1_data_rd(blk_mem_gen_1_douta),
        .bram1_wr_en(sobel_trans_0_bram1_wr_en),
        .bram2_data_rd(blk_mem_gen_2_douta),
        .bram2_wr_en(sobel_trans_0_bram2_wr_en),
        .bram_addr(sobel_trans_0_bram0_addr),
        .bram_data_wr(sobel_trans_0_bram0_data_wr),
        .bram_en(sobel_trans_0_bram0_rd_en),
        .buttons(buttons_1),
        .hData(dvi2rgb_0_vid_pData),
        .hHSync(dvi2rgb_0_vid_pHSync),
        .hVDE(dvi2rgb_0_vid_pVDE),
        .hVSync(dvi2rgb_0_vid_pVSync),
        .pixelClk(dvi2rgb_0_PixelClk),
        .vData(sobel_trans_0_vData),
        .vHSync(sobel_trans_0_vHSync),
        .vVDE(sobel_trans_0_vVDE),
        .vVSync(sobel_trans_0_vVSync));
endmodule
