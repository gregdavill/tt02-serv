/*
 mem = 0
 gpio = 1
 */
module wb_mux
  (
    input wire 	      i_clk,
    input wire 	      i_rst,
    input wire [31:0]  i_wb_cpu_adr,
    input wire [31:0]  i_wb_cpu_dat,
    input wire [3:0]   i_wb_cpu_sel,
    input wire 	      i_wb_cpu_we,
    input wire 	      i_wb_cpu_cyc,
    output wire [31:0] o_wb_cpu_rdt,
    output reg 	      o_wb_cpu_ack,

    output wire [31:0] o_wb_mem_adr,
    output wire [31:0] o_wb_mem_dat,
    output wire [3:0]  o_wb_mem_sel,
    output wire 	      o_wb_mem_we,
    output wire 	      o_wb_mem_cyc,
    input wire [31:0]  i_wb_mem_rdt,

    output wire 	      o_wb_gpio_dat,
    output wire 	      o_wb_gpio_we,
    output wire 	      o_wb_gpio_cyc,
    input wire 	      i_wb_gpio_rdt,
  );

  parameter sim = 0;

  wire  	  s = i_wb_cpu_adr[31:30];

  assign o_wb_cpu_rdt = s ? {31'd0,i_wb_gpio_rdt} : i_wb_mem_rdt;
  always @(posedge i_clk)
    begin
      o_wb_cpu_ack <= 1'b0;

      if (i_wb_cpu_cyc & !o_wb_cpu_ack)
        o_wb_cpu_ack <= 1'b1;
      if (i_rst)
        o_wb_cpu_ack <= 1'b0;
    end

  assign o_wb_mem_adr = i_wb_cpu_adr;
  assign o_wb_mem_dat = i_wb_cpu_dat;
  assign o_wb_mem_sel = i_wb_cpu_sel;
  assign o_wb_mem_we  = i_wb_cpu_we;
  assign o_wb_mem_cyc = i_wb_cpu_cyc & !s;

  assign o_wb_gpio_dat = i_wb_cpu_dat[0];
  assign o_wb_gpio_we  = i_wb_cpu_we;
  assign o_wb_gpio_cyc = i_wb_cpu_cyc & s;

endmodule
