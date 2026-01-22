//intr reg
class dma_intr_reg_seq extends uvm_sequence;
  
  `uvm_object_utils(dma_intr_reg_seq)
  
  dma_reg_block regmodel;
  
  function new(string name = "dma_intr_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e    status;
    uvm_reg_data_t des_val;
    uvm_reg_data_t mir_val;
    uvm_reg_data_t rd_val;
    uvm_reg_data_t ro_before;

    regmodel.intr.read(status, ro_before, UVM_FRONTDOOR);

    // write RW field
    regmodel.intr.intr_mask.set(16'hA5A5);
    regmodel.intr.update(status);

    // frontdoor read
    regmodel.intr.read(status, rd_val, UVM_FRONTDOOR);

    // desired and mirror
    des_val = regmodel.intr.get();
    mir_val = regmodel.intr.get_mirrored_value();

    `uvm_info("INTR_REG",
      $sformatf("DES=0x%08h MIRROR=0x%08h READ=0x%08h", des_val, mir_val, rd_val),
      UVM_LOW)

    // RW check 
    if (des_val !== mir_val)
      `uvm_error("INTR_REG", "Desired and Mirror mismatch")

    // RO check (must not change)
    if (rd_val[15:0] !== ro_before[15:0])
      `uvm_error("INTR_REG", "RO intr_status changed unexpectedly");
  endtask
endclass

//ctrl reg
class dma_ctrl_reg_seq extends uvm_sequence;
  `uvm_object_utils(dma_ctrl_reg_seq)

  dma_reg_block regmodel;

  function new(string name = "dma_ctrl_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e    status;
    uvm_reg_data_t des_val;
    uvm_reg_data_t mir_val;
    uvm_reg_data_t rd_val;

    regmodel.ctrl.start_dma.set(1);
    regmodel.ctrl.w_count.set(10);
    regmodel.ctrl.io_mem.set(1);

    regmodel.ctrl.update(status);

    #10;

    // frontdoor read (predictor updates mirror)
    regmodel.ctrl.read(status, rd_val, UVM_FRONTDOOR);

    des_val = regmodel.ctrl.get();
    mir_val = regmodel.ctrl.get_mirrored_value();

    `uvm_info("CTRL_REG", $sformatf("DES=0x%08h MIRROR=0x%08h READ=0x%08h", des_val, mir_val, rd_val), UVM_LOW)

    if (des_val !== mir_val)
      `uvm_error("CTRL_REG", $sformatf("DES/MIRROR mismatch: DES=0x%08h MIRROR=0x%08h", des_val, mir_val))

    if (rd_val[0] !== 1'b0)
      `uvm_error("CTRL_REG",$sformatf("start_dma not cleared: READ=%0b", rd_val[0]))

    // w_count check
    if (rd_val[15:1] !== 10)
      `uvm_error("CTRL_REG",$sformatf("w_count mismatch: READ=%0d EXP=10", rd_val[15:1]))

    // io_mem check
    if (rd_val[16] !== 1)
      `uvm_error("CTRL_REG", $sformatf("io_mem mismatch: READ=%0b EXP=1", rd_val[16]))
  endtask
endclass

//io addr reg
class dma_io_addr_reg_seq extends uvm_sequence;
  `uvm_object_utils(dma_io_addr_reg_seq)

  dma_reg_block regmodel;

  function new(string name = "dma_io_addr_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e    status;
    uvm_reg_data_t des_val;
    uvm_reg_data_t mir_val;
    uvm_reg_data_t rd_val;

    regmodel.io_addr.set(32'hAAAA_AAAA);
    regmodel.io_addr.update(status);

    regmodel.io_addr.read(status, rd_val, UVM_FRONTDOOR);

    des_val = regmodel.io_addr.get();
    mir_val = regmodel.io_addr.get_mirrored_value();

    `uvm_info("IO_ADDR_REG", $sformatf("DES=0x%08h MIRROR=0x%08h READ=0x%08h", des_val, mir_val, rd_val), UVM_LOW)

    if (des_val !== mir_val)
      `uvm_error("IO_ADDR_REG", $sformatf("DES/MIRROR mismatch: DES=0x%08h MIRROR=0x%08h",des_val, mir_val))
    
    if (rd_val !== 32'hAAAA_AAAA)
      `uvm_error("IO_ADDR_REG", $sformatf("READ mismatch: READ=0x%08h EXP=0xAAAA_AAAA", rd_val))
  endtask
endclass

//mem addr reg
class dma_mem_addr_reg_seq extends uvm_sequence;
  `uvm_object_utils(dma_mem_addr_reg_seq)

  dma_reg_block regmodel;

  function new(string name = "dma_mem_addr_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e    status;
    uvm_reg_data_t des_val;
    uvm_reg_data_t mir_val;
    uvm_reg_data_t rd_val;

    // desired value
    regmodel.mem_addr.set(32'hBBBB_BBBB);
    regmodel.mem_addr.update(status);

    // frontdoor read
    regmodel.mem_addr.read(status, rd_val, UVM_FRONTDOOR);

    des_val = regmodel.mem_addr.get();
    mir_val = regmodel.mem_addr.get_mirrored_value();

    `uvm_info("MEM_ADDR_REG",$sformatf("DES=0x%08h MIRROR=0x%08h READ=0x%08h",des_val, mir_val, rd_val), UVM_LOW)

    if (des_val !== mir_val)
      `uvm_error("MEM_ADDR_REG",$sformatf("DES/MIRROR mismatch: DES=0x%08h MIRROR=0x%08h", des_val, mir_val))

    if (rd_val !== 32'hBBBB_BBBB)
      `uvm_error("MEM_ADDR_REG", $sformatf("READ mismatch: READ=0x%08h EXP=0xBBBB_BBBB", rd_val))
  endtask
endclass

class dma_extra_info_reg_seq extends uvm_sequence;
  `uvm_object_utils(dma_extra_info_reg_seq)

  dma_reg_block regmodel;

  function new(string name = "dma_extra_info_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e    status;
    uvm_reg_data_t des_val;
    uvm_reg_data_t mir_val;
    uvm_reg_data_t rd_val;

    regmodel.extra_info.set(32'h1234_5678);
    regmodel.extra_info.update(status);

    regmodel.extra_info.read(status, rd_val, UVM_FRONTDOOR);

    des_val = regmodel.extra_info.get();
    mir_val = regmodel.extra_info.get_mirrored_value();

    `uvm_info("EXTRA_INFO_REG",
      $sformatf("DES=0x%08h MIRROR=0x%08h READ=0x%08h",
                des_val, mir_val, rd_val),
      UVM_LOW)

    if (des_val !== mir_val)
      `uvm_error("EXTRA_INFO_REG",
        $sformatf("DES/MIRROR mismatch: DES=0x%08h MIRROR=0x%08h",
                  des_val, mir_val))

    if (rd_val !== 32'h1234_5678)
      `uvm_error("EXTRA_INFO_REG",
        $sformatf("READ mismatch: READ=0x%08h EXP=0x12345678", rd_val))
  endtask
endclass

class dma_status_reg_seq extends uvm_sequence;
  `uvm_object_utils(dma_status_reg_seq)

  dma_reg_block regmodel;

  function new(string name="dma_status_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e    status;
    uvm_reg_data_t rd_val;

    regmodel.status.read(status, rd_val, UVM_FRONTDOOR);

    `uvm_info("STATUS_REG",
      $sformatf("READ=0x%08h", rd_val),
      UVM_LOW)

    if (rd_val[0] !== 0 && rd_val[0] !== 1)
      `uvm_error("STATUS_REG", "busy bit invalid")

    if (rd_val[1] !== 0 && rd_val[1] !== 1)
      `uvm_error("STATUS_REG", "done bit invalid")
  endtask
endclass

class dma_transfer_count_reg_seq extends uvm_sequence;
  `uvm_object_utils(dma_transfer_count_reg_seq)

  dma_reg_block regmodel;

  function new(string name = "dma_transfer_count_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e    status;
    uvm_reg_data_t rd_val;

    // read RO register
    regmodel.transfer_count.read(status, rd_val, UVM_FRONTDOOR);

    `uvm_info("TRANSFER_COUNT_REG",
      $sformatf("READ=0x%08h", rd_val),
      UVM_LOW)

  endtask
endclass

class dma_descriptor_addr_reg_seq extends uvm_sequence;
  `uvm_object_utils(dma_descriptor_addr_reg_seq)

  dma_reg_block regmodel;

  function new(string name = "dma_descriptor_addr_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e    status;
    uvm_reg_data_t des_val;
    uvm_reg_data_t mir_val;
    uvm_reg_data_t rd_val;

    regmodel.descriptor_addr.set(32'hDDDD_DDDD);
    regmodel.descriptor_addr.update(status);

    regmodel.descriptor_addr.read(status, rd_val, UVM_FRONTDOOR);

    des_val = regmodel.descriptor_addr.get();
    mir_val = regmodel.descriptor_addr.get_mirrored_value();

    `uvm_info("DESC_ADDR_REG",
      $sformatf("DES=0x%08h MIRROR=0x%08h READ=0x%08h",
                des_val, mir_val, rd_val),
      UVM_LOW)

    if (des_val !== mir_val)
      `uvm_error("DESC_ADDR_REG",
        $sformatf("DES/MIRROR mismatch: DES=0x%08h MIRROR=0x%08h",
                  des_val, mir_val))

    if (rd_val !== 32'hDDDD_DDDD)
      `uvm_error("DESC_ADDR_REG",
        $sformatf("READ mismatch: READ=0x%08h EXP=0xDDDD_DDDD", rd_val))
  endtask
endclass

class dma_error_status_reg_seq extends uvm_sequence;
  `uvm_object_utils(dma_error_status_reg_seq)

  dma_reg_block regmodel;

  function new(string name = "dma_error_status_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e    status;
    uvm_reg_data_t des_val;
    uvm_reg_data_t mir_val;
    uvm_reg_data_t rd_val;

    // read initial value
    regmodel.error_status.read(status, rd_val, UVM_FRONTDOOR);

    // write 1s to W1C bits [4:0]
    regmodel.error_status.set(32'h0000_001F);
    regmodel.error_status.update(status);

    // read after clear
    regmodel.error_status.read(status, rd_val, UVM_FRONTDOOR);

    des_val = regmodel.error_status.get();
    mir_val = regmodel.error_status.get_mirrored_value();

    `uvm_info("ERR_STATUS_REG",
      $sformatf("DES=0x%08h MIRROR=0x%08h READ=0x%08h",
                des_val, mir_val, rd_val),
      UVM_LOW)

    if (des_val !== mir_val)
      `uvm_error("ERR_STATUS_REG",
        $sformatf("DES/MIRROR mismatch: DES=0x%08h MIRROR=0x%08h",
                  des_val, mir_val))

    if (rd_val[4:0] !== 5'b0)
      `uvm_error("ERR_STATUS_REG",
        $sformatf("W1C clear failed: READ[4:0]=0x%0h", rd_val[4:0]))
  endtask
endclass

class dma_config_reg_seq extends uvm_sequence;
  `uvm_object_utils(dma_config_reg_seq)

  dma_reg_block regmodel;

  function new(string name = "dma_config_reg_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e    status;
    uvm_reg_data_t des_val;
    uvm_reg_data_t mir_val;
    uvm_reg_data_t rd_val;

    // program RW fields
    regmodel.config_reg.priority_f.set(2'b10);
    regmodel.config_reg.auto_restart.set(1'b1);
    regmodel.config_reg.interrupt_enable.set(1'b1);
    regmodel.config_reg.burst_size.set(2'b01);
    regmodel.config_reg.data_width.set(2'b10);
    regmodel.config_reg.descriptor_mode.set(1'b1);

    regmodel.config_reg.update(status);

    // frontdoor read
    regmodel.config_reg.read(status, rd_val, UVM_FRONTDOOR);

    des_val = regmodel.config_reg.get();
    mir_val = regmodel.config_reg.get_mirrored_value();

    `uvm_info("CONFIG_REG",
      $sformatf("DES=0x%08h MIRROR=0x%08h READ=0x%08h",
                des_val, mir_val, rd_val),
      UVM_LOW)

    if (des_val !== mir_val)
      `uvm_error("CONFIG_REG",
        $sformatf("DES/MIRROR mismatch: DES=0x%08h MIRROR=0x%08h",
                  des_val, mir_val))

    if (rd_val[1:0] !== 2'b10)
      `uvm_error("CONFIG_REG", "priority_f mismatch")

    if (rd_val[2] !== 1'b1)
      `uvm_error("CONFIG_REG", "auto_restart mismatch")

    if (rd_val[3] !== 1'b1)
      `uvm_error("CONFIG_REG", "interrupt_enable mismatch")

    if (rd_val[5:4] !== 2'b01)
      `uvm_error("CONFIG_REG", "burst_size mismatch")

    if (rd_val[7:6] !== 2'b10)
      `uvm_error("CONFIG_REG", "data_width mismatch")

    if (rd_val[8] !== 1'b1)
      `uvm_error("CONFIG_REG", "descriptor_mode mismatch")

    // reserved bits must stay 0
    if (rd_val[31:9] !== 0)
      `uvm_error("CONFIG_REG",
        $sformatf("Reserved bits modified: READ[31:9]=0x%0h", rd_val[31:9]))
  endtask
endclass


//regression seq
class dma_regression_seq extends uvm_sequence;
  `uvm_object_utils(dma_regression_seq)

  dma_reg_block regmodel;

  dma_intr_reg_seq            intr_seq;
  dma_ctrl_reg_seq            ctrl_seq;
  dma_io_addr_reg_seq         io_seq;
  dma_mem_addr_reg_seq        mem_seq;
  dma_extra_info_reg_seq      extra_seq;
  dma_status_reg_seq          status_seq;
  dma_transfer_count_reg_seq  tc_seq;
  dma_descriptor_addr_reg_seq desc_seq;
  dma_error_status_reg_seq    err_seq;
  dma_config_reg_seq          cfg_seq;

  function new(string name="dma_regression_seq");
    super.new(name);
  endfunction

  task body();

    intr_seq   = dma_intr_reg_seq::type_id::create("intr_seq");
    ctrl_seq   = dma_ctrl_reg_seq::type_id::create("ctrl_seq");
    io_seq     = dma_io_addr_reg_seq::type_id::create("io_seq");
    mem_seq    = dma_mem_addr_reg_seq::type_id::create("mem_seq");
    extra_seq  = dma_extra_info_reg_seq::type_id::create("extra_seq");
    status_seq = dma_status_reg_seq::type_id::create("status_seq");
    tc_seq     = dma_transfer_count_reg_seq::type_id::create("tc_seq");
    desc_seq   = dma_descriptor_addr_reg_seq::type_id::create("desc_seq");
    err_seq    = dma_error_status_reg_seq::type_id::create("err_seq");
    cfg_seq    = dma_config_reg_seq::type_id::create("cfg_seq");

    intr_seq.regmodel   = regmodel;
    ctrl_seq.regmodel   = regmodel;
    io_seq.regmodel     = regmodel;
    mem_seq.regmodel    = regmodel;
    extra_seq.regmodel  = regmodel;
    status_seq.regmodel = regmodel;
    tc_seq.regmodel     = regmodel;
    desc_seq.regmodel   = regmodel;
    err_seq.regmodel    = regmodel;
    cfg_seq.regmodel    = regmodel;

    intr_seq.start(m_sequencer);
    ctrl_seq.start(m_sequencer);
    io_seq.start(m_sequencer);
    mem_seq.start(m_sequencer);
    extra_seq.start(m_sequencer);
    status_seq.start(m_sequencer);
    tc_seq.start(m_sequencer);
    desc_seq.start(m_sequencer);
    err_seq.start(m_sequencer);
    cfg_seq.start(m_sequencer);

  endtask
endclass


