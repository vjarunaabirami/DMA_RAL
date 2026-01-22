//intr_reg
class dma_intr_reg extends uvm_reg;

  uvm_reg_field intr_status;
  uvm_reg_field intr_mask;

  `uvm_object_utils(dma_intr_reg)

  function new(string name = "dma_intr_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
  endfunction

  function void build();

    intr_status = uvm_reg_field::type_id::create("intr_status");
    intr_status.configure(this,16,0,"RO",0,0,1,0,1);

    intr_mask = uvm_reg_field::type_id::create("intr_mask");
    intr_mask.configure(this,16,16,"RW",0,0,1,1,1);

  endfunction
endclass

// CTRL Register (0x404)
class dma_ctrl_reg extends uvm_reg;

  uvm_reg_field start_dma;
  uvm_reg_field w_count;
  uvm_reg_field io_mem;

  `uvm_object_utils(dma_ctrl_reg)

  function new(string name="dma_ctrl_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
  endfunction

  function void build();

    start_dma = uvm_reg_field::type_id::create("start_dma");
    start_dma.configure(this,1,0,"RW",0,0,1,1,1);

    w_count = uvm_reg_field::type_id::create("w_count");
    w_count.configure(this,15,1,"RW",0,0,1,1,1);

    io_mem = uvm_reg_field::type_id::create("io_mem");
    io_mem.configure(this,1,16,"RW",0,0,1,1,1);

  endfunction
endclass


// IO_ADDR Register (0x408)
class dma_io_addr_reg extends uvm_reg;

  uvm_reg_field io_addr;

  `uvm_object_utils(dma_io_addr_reg)

  function new(string name="dma_io_addr_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
  endfunction

  function void build();
    io_addr = uvm_reg_field::type_id::create("io_addr");
    io_addr.configure(this,32,0,"RW",0,0,1,1,0);
  endfunction
endclass

// MEM_ADDR Register (0x40C)
class dma_mem_addr_reg extends uvm_reg;

  uvm_reg_field mem_addr;

  `uvm_object_utils(dma_mem_addr_reg)

  function new(string name="dma_mem_addr_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
  endfunction

 function void build();
  mem_addr = uvm_reg_field::type_id::create("mem_addr");
  mem_addr.configure(this,32,0,"RW",0,0,1,1,0);
endfunction

endclass


// EXTRA_INFO Register (0x410)
class dma_extra_info_reg extends uvm_reg;

  uvm_reg_field extra_info;

  `uvm_object_utils(dma_extra_info_reg)

  function new(string name="dma_extra_info_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
  endfunction
  
  function void build();
    extra_info = uvm_reg_field::type_id::create("extra_info");
    extra_info.configure(this,32,0,"RW",0,0,1,1,0);
  endfunction

endclass

// STATUS Register (0x414)
class dma_status_reg extends uvm_reg;

  uvm_reg_field busy, done, error, paused;
  uvm_reg_field current_state, fifo_level;

  `uvm_object_utils(dma_status_reg)

  function new(string name="dma_status_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
  endfunction

  function void build();

    busy = uvm_reg_field::type_id::create("busy");
    busy.configure(this,1,0,"RO",0,0,1,0,1);

    done = uvm_reg_field::type_id::create("done");
    done.configure(this,1,1,"RO",0,0,1,0,1);

    error = uvm_reg_field::type_id::create("error");
    error.configure(this,1,2,"RO",0,0,1,0,1);

    paused = uvm_reg_field::type_id::create("paused");
    paused.configure(this,1,3,"RO",0,0,1,0,1);

    current_state = uvm_reg_field::type_id::create("current_state");
    current_state.configure(this,4,4,"RO",0,0,1,0,1);

    fifo_level = uvm_reg_field::type_id::create("fifo_level");
    fifo_level.configure(this,8,8,"RO",0,0,1,0,1);

  endfunction

endclass


// TRANSFER_COUNT Register (0x418)
class dma_transfer_count_reg extends uvm_reg;

  uvm_reg_field transfer_count;

  `uvm_object_utils(dma_transfer_count_reg)

  function new(string name="dma_transfer_count_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
  endfunction

 function void build();
   transfer_count = uvm_reg_field::type_id::create("transfer_count");
   transfer_count.configure(this,32,0,"RO",0,0,1,0,1);
 endfunction

endclass


// DESCRIPTOR_ADDR Register (0x41C)
class dma_descriptor_addr_reg extends uvm_reg;

  uvm_reg_field descriptor_addr;

  `uvm_object_utils(dma_descriptor_addr_reg)

  function new(string name="dma_descriptor_addr_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
  endfunction

 function void build();
   descriptor_addr = uvm_reg_field::type_id::create("descriptor_addr");
   descriptor_addr.configure(this,32,0,"RW",0,0,1,1,0);
 endfunction

endclass


// ERROR_STATUS Register (0x420)
class dma_error_status_reg extends uvm_reg;

  uvm_reg_field bus_error, timeout_error, alignment_error;
  uvm_reg_field overflow_error, underflow_error;
  uvm_reg_field error_code, error_addr_offset;

  `uvm_object_utils(dma_error_status_reg)

  function new(string name="dma_error_status_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
  endfunction

  function void build();

    bus_error = uvm_reg_field::type_id::create("bus_error");
    bus_error.configure(this,1,0,"W1C",0,0,1,0,1);

    timeout_error = uvm_reg_field::type_id::create("timeout_error");
    timeout_error.configure(this,1,1,"W1C",0,0,1,0,1);

    alignment_error = uvm_reg_field::type_id::create("alignment_error");
    alignment_error.configure(this,1,2,"W1C",0,0,1,0,1);

    overflow_error = uvm_reg_field::type_id::create("overflow_error");
    overflow_error.configure(this,1,3,"W1C",0,0,1,0,1);

    underflow_error = uvm_reg_field::type_id::create("underflow_error");
    underflow_error.configure(this,1,4,"W1C",0,0,1,0,1);

    error_code = uvm_reg_field::type_id::create("error_code");
    error_code.configure(this,8,8,"RO",0,0,1,0,1);

    error_addr_offset = uvm_reg_field::type_id::create("error_addr_offset");
    error_addr_offset.configure(this,16,16,"RO",0,0,1,0,1);

  endfunction

endclass


// CONFIG Register (0x424)
class dma_config_reg extends uvm_reg;

  uvm_reg_field priority_f, auto_restart, interrupt_enable;
  uvm_reg_field burst_size, data_width, descriptor_mode;

  `uvm_object_utils(dma_config_reg)

  function new(string name="dma_config_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
  endfunction

  function void build();

    priority_f = uvm_reg_field::type_id::create("priority_f");
    priority_f.configure(this,2,0,"RW",0,0,1,1,0);

    auto_restart = uvm_reg_field::type_id::create("auto_restart");
    auto_restart.configure(this,1,2,"RW",0,0,1,1,0);

    interrupt_enable = uvm_reg_field::type_id::create("interrupt_enable");
    interrupt_enable.configure(this,1,3,"RW",0,0,1,1,0);

    burst_size = uvm_reg_field::type_id::create("burst_size");
    burst_size.configure(this,2,4,"RW",0,0,1,1,0);

    data_width = uvm_reg_field::type_id::create("data_width");
    data_width.configure(this,2,6,"RW",0,0,1,1,0);

    descriptor_mode = uvm_reg_field::type_id::create("descriptor_mode");
    descriptor_mode.configure(this,1,8,"RW",0,0,1,1,0);

  endfunction

endclass


//REG BLOCK
class dma_reg_block extends uvm_reg_block;

  `uvm_object_utils(dma_reg_block)
  
  uvm_reg_map dma_map;

  rand dma_intr_reg            intr;
  rand dma_ctrl_reg            ctrl;
  rand dma_io_addr_reg         io_addr;
  rand dma_mem_addr_reg        mem_addr;
  rand dma_extra_info_reg      extra_info;
  rand dma_status_reg          status;
  rand dma_transfer_count_reg  transfer_count;
  rand dma_descriptor_addr_reg descriptor_addr;
  rand dma_error_status_reg    error_status;
  rand dma_config_reg          config_reg;

  function new(string name = "dma_reg_block");
    super.new(name, UVM_CVR_ALL);
  endfunction

  virtual function void build();
    
    set_hdl_path_root("top.dut");

    intr = dma_intr_reg::type_id::create("intr");
    intr.build();
    intr.configure(this);
    intr.add_hdl_path_slice("intr_status", 0, 16);
    intr.add_hdl_path_slice("intr_mask",  16, 16);
	
    ctrl = dma_ctrl_reg::type_id::create("ctrl");
    ctrl.build();
    ctrl.configure(this);
    ctrl.add_hdl_path_slice("ctrl_start_dma", 0, 1);
    ctrl.add_hdl_path_slice("ctrl_w_count",   1, 15);
    ctrl.add_hdl_path_slice("ctrl_io_mem",   16, 1);


    io_addr = dma_io_addr_reg::type_id::create("io_addr");
    io_addr.build();
    io_addr.configure(this);
    io_addr.add_hdl_path_slice("io_addr", 0, 32);

    mem_addr = dma_mem_addr_reg::type_id::create("mem_addr");
    mem_addr.build();
    mem_addr.configure(this);
    mem_addr.add_hdl_path_slice("mem_addr", 0, 32);


    extra_info = dma_extra_info_reg::type_id::create("extra_info");
    extra_info.build();
    extra_info.configure(this);
    extra_info.add_hdl_path_slice("extra_info", 0, 32);

    status = dma_status_reg::type_id::create("status");
    status.build();
    status.configure(this);
    status.add_hdl_path_slice("status_busy",          0, 1);
    status.add_hdl_path_slice("status_done",          1, 1);
    status.add_hdl_path_slice("status_error",         2, 1);
    status.add_hdl_path_slice("status_paused",        3, 1);
    status.add_hdl_path_slice("status_current_state", 4, 4);
    status.add_hdl_path_slice("status_fifo_level",    8, 8);

    transfer_count = dma_transfer_count_reg::type_id::create("transfer_count");
    transfer_count.build();
    transfer_count.configure(this);
    transfer_count.add_hdl_path_slice("transfer_count", 0, 32);

    descriptor_addr = dma_descriptor_addr_reg::type_id::create("descriptor_addr");
    descriptor_addr.build();
    descriptor_addr.configure(this);
    descriptor_addr.add_hdl_path_slice("descriptor_addr", 0, 32);


    error_status = dma_error_status_reg::type_id::create("error_status");
    error_status.build();
    error_status.configure(this);
    error_status.add_hdl_path_slice("error_bus",         0, 1);
    error_status.add_hdl_path_slice("error_timeout",     1, 1);
    error_status.add_hdl_path_slice("error_alignment",   2, 1);
    error_status.add_hdl_path_slice("error_overflow",    3, 1);
    error_status.add_hdl_path_slice("error_underflow",   4, 1);
    error_status.add_hdl_path_slice("error_code",        8, 8);
    error_status.add_hdl_path_slice("error_addr_offset",16,16);

    config_reg = dma_config_reg::type_id::create("config_reg");
    config_reg.build();
    config_reg.configure(this);
    config_reg.add_hdl_path_slice("config_priority",         0, 2);
    config_reg.add_hdl_path_slice("config_auto_restart",     2, 1);
    config_reg.add_hdl_path_slice("config_interrupt_enable", 3, 1);
    config_reg.add_hdl_path_slice("config_burst_size",       4, 2);
    config_reg.add_hdl_path_slice("config_data_width",       6, 2);
    config_reg.add_hdl_path_slice("config_descriptor_mode",  8, 1);

    dma_map = create_map("dma_map",'h400,  4, UVM_LITTLE_ENDIAN );

    dma_map.add_reg(intr,            'h00, "RO"); // 0x400
    dma_map.add_reg(ctrl,            'h04, "RW"); // 0x404
    dma_map.add_reg(io_addr,         'h08, "RW"); // 0x408
    dma_map.add_reg(mem_addr,        'h0C, "RW"); // 0x40C
    dma_map.add_reg(extra_info,      'h10, "RW"); // 0x410
    dma_map.add_reg(status,          'h14, "RO"); // 0x414
    dma_map.add_reg(transfer_count,  'h18, "RO"); // 0x418
    dma_map.add_reg(descriptor_addr, 'h1C, "RW"); // 0x41C
    dma_map.add_reg(error_status,    'h20, "RW"); // 0x420
    dma_map.add_reg(config_reg,      'h24, "RW"); // 0x424

    set_default_map(dma_map);
    lock_model();

  endfunction

endclass

