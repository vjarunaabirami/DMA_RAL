class dma_driver extends uvm_driver #(dma_seq_item);

  `uvm_component_utils(dma_driver)

  virtual dma_interface vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual dma_interface)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "dma_if not set for dma_driver");
  endfunction

  task run_phase(uvm_phase phase);
    
    wait (vif.rst_n == 1);
    @(posedge vif.clk);  

    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done();
    end
  endtask


  task drive(dma_seq_item req);
    `uvm_info("DRV", $sformatf("REQ received: wr_en=%0b rd_en=%0b addr=0x%08h wdata=0x%08h", req.wr_en, req.rd_en, req.addr, req.wdata), UVM_MEDIUM)
    
    vif.wr_en  <= 0;
    vif.rd_en  <= 0;
    vif.addr   <= '0;
    vif.wdata  <= '0;

    if (req.wr_en) begin
      vif.addr  <= req.addr;
      vif.wdata <= req.wdata;
      @(posedge vif.drv_cb);  
      vif.wr_en <= 1;
      @(posedge vif.drv_cb);    
      vif.wr_en <= 0;
    end

    else begin
      vif.addr  <= req.addr;
      vif.rd_en <= 1;
      @(posedge vif.drv_cb);  
      @(posedge vif.drv_cb); 
      req.rdata = vif.rdata;
      vif.rd_en <= 0;
    end

  endtask

endclass

