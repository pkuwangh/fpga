//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
//Date        : Fri Jun 30 23:16:21 2017
//Host        : vm-ubuntu running 64-bit Ubuntu 14.04.5 LTS
//Command     : generate_target sobel_hdmi2vga_wrapper.bd
//Design      : sobel_hdmi2vga_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module sobel_hdmi2vga_wrapper
   (RefClk,
    buttons,
    hdmi_clk_n,
    hdmi_clk_p,
    hdmi_d_n,
    hdmi_d_p,
    hdmi_hpd,
    hdmi_in_ddc_scl_io,
    hdmi_in_ddc_sda_io,
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
  inout hdmi_in_ddc_scl_io;
  inout hdmi_in_ddc_sda_io;
  output [0:0]hdmi_out_en;
  output [4:0]vga_b;
  output [5:0]vga_g;
  output vga_hs;
  output [4:0]vga_r;
  output vga_vs;

  wire RefClk;
  wire [3:0]buttons;
  wire hdmi_clk_n;
  wire hdmi_clk_p;
  wire [2:0]hdmi_d_n;
  wire [2:0]hdmi_d_p;
  wire [0:0]hdmi_hpd;
  wire hdmi_in_ddc_scl_i;
  wire hdmi_in_ddc_scl_io;
  wire hdmi_in_ddc_scl_o;
  wire hdmi_in_ddc_scl_t;
  wire hdmi_in_ddc_sda_i;
  wire hdmi_in_ddc_sda_io;
  wire hdmi_in_ddc_sda_o;
  wire hdmi_in_ddc_sda_t;
  wire [0:0]hdmi_out_en;
  wire [4:0]vga_b;
  wire [5:0]vga_g;
  wire vga_hs;
  wire [4:0]vga_r;
  wire vga_vs;

  IOBUF hdmi_in_ddc_scl_iobuf
       (.I(hdmi_in_ddc_scl_o),
        .IO(hdmi_in_ddc_scl_io),
        .O(hdmi_in_ddc_scl_i),
        .T(hdmi_in_ddc_scl_t));
  IOBUF hdmi_in_ddc_sda_iobuf
       (.I(hdmi_in_ddc_sda_o),
        .IO(hdmi_in_ddc_sda_io),
        .O(hdmi_in_ddc_sda_i),
        .T(hdmi_in_ddc_sda_t));
  sobel_hdmi2vga sobel_hdmi2vga_i
       (.RefClk(RefClk),
        .buttons(buttons),
        .hdmi_clk_n(hdmi_clk_n),
        .hdmi_clk_p(hdmi_clk_p),
        .hdmi_d_n(hdmi_d_n),
        .hdmi_d_p(hdmi_d_p),
        .hdmi_hpd(hdmi_hpd),
        .hdmi_in_ddc_scl_i(hdmi_in_ddc_scl_i),
        .hdmi_in_ddc_scl_o(hdmi_in_ddc_scl_o),
        .hdmi_in_ddc_scl_t(hdmi_in_ddc_scl_t),
        .hdmi_in_ddc_sda_i(hdmi_in_ddc_sda_i),
        .hdmi_in_ddc_sda_o(hdmi_in_ddc_sda_o),
        .hdmi_in_ddc_sda_t(hdmi_in_ddc_sda_t),
        .hdmi_out_en(hdmi_out_en),
        .vga_b(vga_b),
        .vga_g(vga_g),
        .vga_hs(vga_hs),
        .vga_r(vga_r),
        .vga_vs(vga_vs));
endmodule
