class dma_env extends uvm_env;

  `uvm_component_utils(dma_env)
  dma_agent  dma_agnt;
  dma_reg_block  regmodel;
  dma_adapter adapter;
  uvm_reg_predictor #(dma_seq_item) predictor;
  dma_subscriber sub;


  function new(string name = "dma_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    predictor = uvm_reg_predictor #(dma_seq_item)::type_id::create("predictor", this);
    sub = dma_subscriber::type_id::create("sub", this);
    dma_agnt = dma_agent::type_id::create("dma_agnt", this);
    regmodel = dma_reg_block::type_id::create("regmodel", this);
    regmodel.build();
    adapter = dma_adapter::type_id::create("adapter", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    regmodel.default_map.set_sequencer( dma_agnt.sequencer, adapter );
    regmodel.default_map.set_base_addr('h400);
    predictor.map     = regmodel.default_map;  
    predictor.adapter = adapter;           
    dma_agnt.monitor.mon_ap.connect(predictor.bus_in);
    dma_agnt.monitor.mon_ap.connect(sub.monitor_aport);
    regmodel.default_map.set_auto_predict(0);
  endfunction

endclass

