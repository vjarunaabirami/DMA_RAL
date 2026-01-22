class dma_monitor extends uvm_monitor;

  `uvm_component_utils(dma_monitor)

  virtual dma_interface vif;

  uvm_analysis_port #(dma_seq_item) mon_ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon_ap = new("mon_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual dma_interface)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "dma_interface not set for dma_monitor");
  endfunction

  task run_phase(uvm_phase phase);
    dma_seq_item tx;

    forever begin
      @(posedge vif.mon_cb);

      if (vif.wr_en) begin
        tx = dma_seq_item::type_id::create("tx", this);

        tx.wr_en = 1;
        tx.rd_en = 0;
        tx.addr  = vif.mon_cb.addr;
        tx.wdata = vif.mon_cb.wdata;
        `uvm_info("MON", $sformatf("WRITE observed: addr=0x%08h wdata=0x%08h", tx.addr, tx.wdata), UVM_MEDIUM)


        mon_ap.write(tx);
      end

      if (vif.rd_en) begin
        tx = dma_seq_item::type_id::create("tx", this);

        tx.wr_en = 0;
        tx.rd_en = 1;
        tx.addr  = vif.addr;

        @(posedge vif.mon_cb);
        tx.rdata = vif.rdata;
        `uvm_info("MON",$sformatf("READ observed: addr=0x%08h rdata=0x%08h", tx.addr, tx.rdata), UVM_MEDIUM)


        mon_ap.write(tx);
      end
    end
  endtask

endclass

