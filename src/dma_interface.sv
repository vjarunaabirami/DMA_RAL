interface dma_interface(input logic clk,rst_n);
  
  logic [31:0] addr;
  logic        wr_en;
  logic        rd_en;
  logic [31:0] wdata;
  logic [31:0] rdata;
  
  clocking drv_cb @(posedge clk);
    default input #0 output #0;
    output addr;
    output wr_en;
    output rd_en;
    output wdata;
    input  rdata;  
  endclocking
  
  clocking mon_cb @(posedge clk);
    default input #0 output #0;
    input addr;
    input wr_en;
    input rd_en;
    input wdata;
    input rdata;  
  endclocking
  
  modport DRIVER  (clocking drv_cb,input clk,rst_n);
    
  modport MONITOR (clocking mon_cb,input clk,rst_n);
  
endinterface
