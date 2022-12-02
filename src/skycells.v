module sky130_fd_sc_hd__buf_4
  (
   input wire [3:0]  A,
   output wire [3:0] X,
   input wire	     VPWR,
   input wire	     VGND);

  assign X = A;
endmodule

module sky130_fd_sc_hd__clkbuf_2
  (
   input wire  A,
   output wire X,
   input wire  VPWR,
   input wire  VGND);

  assign X = A;
endmodule

module sky130_fd_sc_hd__dfrtn_1
  (input wire  RESET_B,
   input wire CLK_N,
   input wire D,
   output reg Q,
   input wire VPWR,
   input wire VGND);

   always @(negedge CLK_N)
     Q <= D;

endmodule

module sky130_fd_sc_hd__sdfxtp_1
  (
   input wire CLK,
   input wire D,
   input wire SCD,
   input wire SCE,
   output reg Q,
   input wire VPWR,
   input wire VGND);

   always @(posedge CLK)
     Q <= SCE ? SCD : D;

endmodule
