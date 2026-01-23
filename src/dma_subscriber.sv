`uvm_analysis_imp_decl(_from_mon)

class dma_subscriber extends uvm_component;

  `uvm_component_utils(dma_subscriber)

  uvm_analysis_imp_from_mon #(dma_seq_item, dma_subscriber) monitor_aport;
  dma_seq_item monitor_trans;
  real coverage_results;

  // ----------------------------
  // COVERGROUP
  // ----------------------------
  covergroup dma_cov;
    option.per_instance = 1;

    wr_en_cp : coverpoint monitor_trans.wr_en { bins b[] = {0,1}; }
    rd_en_cp : coverpoint monitor_trans.rd_en { bins b[] = {0,1}; }

    addr_cp : coverpoint monitor_trans.addr {
      bins intr   = {32'h400};
      bins ctrl   = {32'h404};
      bins io     = {32'h408};
      bins mem    = {32'h40C};
      bins extra  = {32'h410};
      bins status = {32'h414};
      bins tc     = {32'h418};
      bins desc   = {32'h41C};
      bins err    = {32'h420};
      bins cfg    = {32'h424};
    }

    wdata_cp : coverpoint monitor_trans.wdata iff (monitor_trans.wr_en);
    rdata_cp : coverpoint monitor_trans.rdata iff (monitor_trans.rd_en);

    access_cross : cross wr_en_cp, rd_en_cp, addr_cp;

  endgroup
  // ----------------------------

  function new(string name="dma_subscriber", uvm_component parent=null);
    super.new(name, parent);
    monitor_aport  = new("monitor_aport", this);
    monitor_trans  = new();
    dma_cov        = new();
  endfunction

  function void write_from_mon(dma_seq_item t);
    monitor_trans.copy(t);  
    dma_cov.sample();
  endfunction

  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    coverage_results = dma_cov.get_coverage();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),
      $sformatf("DMA FUNCTIONAL COVERAGE = %0.2f%%", coverage_results),
      UVM_MEDIUM)
  endfunction

endclass

