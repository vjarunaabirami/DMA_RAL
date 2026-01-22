class dma_adapter extends uvm_reg_adapter;

  `uvm_object_utils(dma_adapter)

  function new(string name = "dma_adapter");
    super.new(name);
  endfunction

  virtual function uvm_sequence_item reg2bus( const ref uvm_reg_bus_op rw);
    
    dma_seq_item tx;
    tx = dma_seq_item::type_id::create("tx");

    tx.addr  = rw.addr;
   // tx.valid = 1'b1;

    if (rw.kind == UVM_WRITE) begin
      tx.wr_en = 1'b1;
      tx.rd_en = 0;
      tx.wdata = rw.data;
    end
    else begin
      tx.wr_en = 1'b0;
      tx.rd_en = 1;
    end

    return tx;
  endfunction

  virtual function void bus2reg( uvm_sequence_item bus_item, ref uvm_reg_bus_op rw );

    dma_seq_item tx;

    if (!$cast(tx, bus_item)) begin
      `uvm_fatal("DMA_ADAPTER", "bus2reg: cast failed")
    end

    rw.addr   = tx.addr;  
    if (tx.wr_en)
      rw.kind = UVM_WRITE;
    else
      rw.kind = UVM_READ;
    rw.data   = tx.rdata;
    rw.status = UVM_IS_OK;
  endfunction
endclass

