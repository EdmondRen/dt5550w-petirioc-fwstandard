// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
// Date        : Thu Jan 16 12:37:15 2020
// Host        : vivado4 running 64-bit Ubuntu 18.04.3 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/user/GIT/DT5550W/dt5550w-petirioc-fwstandard/DT5550w.srcs/sources_1/ip/FTDI_FIFOs/FTDI_FIFOs_stub.v
// Design      : FTDI_FIFOs
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tffg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_1,Vivado 2017.4" *)
module FTDI_FIFOs(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, 
  empty, valid, prog_full, prog_empty)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[33:0],wr_en,rd_en,dout[33:0],full,empty,valid,prog_full,prog_empty" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [33:0]din;
  input wr_en;
  input rd_en;
  output [33:0]dout;
  output full;
  output empty;
  output valid;
  output prog_full;
  output prog_empty;
endmodule
