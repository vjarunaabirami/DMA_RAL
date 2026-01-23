`timescale 1ns/1ps

`include "design.sv"
`include "dma_interface.sv"
`include "dma_pkg.sv"

import uvm_pkg::*;
import dma_pkg::*;

module top;

  logic clk;
  logic rst_n;
  
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rst_n = 0;
    #20 rst_n = 1;
  end

  dma_interface vif (
    .clk   (clk),
    .rst_n (rst_n)
  );

  // DUT
  dma_design dut (
    .clk    (clk),
    .rst_n  (rst_n),
    .wr_en  (vif.wr_en),
    .rd_en  (vif.rd_en),
    .addr   (vif.addr),
    .wdata  (vif.wdata),
    .rdata  (vif.rdata)
  );

  // Connect interface to UVM
  initial begin
    uvm_config_db#(virtual dma_interface)::set(null, "*", "vif", vif);
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  initial begin
    //run_test("dma_intr_reg_test");
    //run_test("dma_ctrl_reg_test");
    //run_test("dma_io_addr_reg_test");
    //run_test("dma_mem_addr_reg_test");
    //run_test("dma_extra_info_reg_test");
    //run_test("dma_status_reg_test");
    //run_test("dma_transfer_count_reg_test");
    //run_test("dma_descriptor_addr_reg_test");
    //run_test("dma_error_status_reg_test");
    //run_test("dma_config_reg_test");
    run_test("dma_regression_test");
  end

endmodule

