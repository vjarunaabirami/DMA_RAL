class dma_base_test extends uvm_test;

  `uvm_component_utils(dma_base_test)

  dma_env env;

  function new(string name = "dma_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

endclass


class dma_intr_reg_test extends uvm_test;

  `uvm_component_utils(dma_intr_reg_test)

  dma_env        env;
  dma_intr_reg_seq   reg_seq;

  function new(string name = "dma_intr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    reg_seq = dma_intr_reg_seq::type_id::create("reg_seq");
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    reg_seq.regmodel = env.regmodel;
    reg_seq.start(env.dma_agnt.sequencer);
    phase.drop_objection(this);
  endtask
 
endclass

class dma_ctrl_reg_test extends dma_base_test;

  `uvm_component_utils(dma_ctrl_reg_test)

  dma_ctrl_reg_seq ctrl_seq;

  function new(string name="dma_ctrl_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ctrl_seq = dma_ctrl_reg_seq::type_id::create("ctrl_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    ctrl_seq.regmodel = env.regmodel;
    ctrl_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class dma_io_addr_reg_test extends dma_base_test;
  `uvm_component_utils(dma_io_addr_reg_test)

  dma_io_addr_reg_seq io_seq;
  
   function new(string name="dma_io_addr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    io_seq = dma_io_addr_reg_seq::type_id::create("io_seq");
    io_seq.regmodel = env.regmodel;
    io_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class dma_mem_addr_reg_test extends dma_base_test;
  `uvm_component_utils(dma_mem_addr_reg_test)

  dma_mem_addr_reg_seq mem_seq;
  
   function new(string name="dma_mem_addr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    mem_seq = dma_mem_addr_reg_seq::type_id::create("mem_seq");
    mem_seq.regmodel = env.regmodel;
    mem_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class dma_extra_info_reg_test extends dma_base_test;
  `uvm_component_utils(dma_extra_info_reg_test)

  dma_extra_info_reg_seq extra_seq;
  
  function new(string name="dma_extra_info_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    extra_seq = dma_extra_info_reg_seq::type_id::create("extra_seq");
    extra_seq.regmodel = env.regmodel;
    extra_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class dma_status_reg_test extends dma_base_test;
  `uvm_component_utils(dma_status_reg_test)

  dma_status_reg_seq status_seq;

   function new(string name="dma_status_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    status_seq = dma_status_reg_seq::type_id::create("status_seq");
    status_seq.regmodel = env.regmodel;
    status_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class dma_transfer_count_reg_test extends dma_base_test;
  `uvm_component_utils(dma_transfer_count_reg_test)

  dma_transfer_count_reg_seq tc_seq;
  
  function new(string name="dma_transfer_count_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    tc_seq = dma_transfer_count_reg_seq::type_id::create("tc_seq");
    tc_seq.regmodel = env.regmodel;
    tc_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class dma_descriptor_addr_reg_test extends dma_base_test;
  `uvm_component_utils(dma_descriptor_addr_reg_test)

  dma_descriptor_addr_reg_seq desc_seq;
  
  function new(string name="dma_descriptor_addr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    desc_seq = dma_descriptor_addr_reg_seq::type_id::create("desc_seq");
    desc_seq.regmodel = env.regmodel;
    desc_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class dma_error_status_reg_test extends dma_base_test;
  `uvm_component_utils(dma_error_status_reg_test)

  dma_error_status_reg_seq err_seq;

  function new(string name = "dma_error_status_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    err_seq = dma_error_status_reg_seq::type_id::create("err_seq");
    err_seq.regmodel = env.regmodel;
    err_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class dma_config_reg_test extends dma_base_test;
  `uvm_component_utils(dma_config_reg_test)

  dma_config_reg_seq    config_seq;

  function new(string name = "dma_config_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    config_seq = dma_config_reg_seq::type_id::create("config_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    config_seq.regmodel = env.regmodel;

    config_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask

endclass

class dma_regression_test extends uvm_test;
  `uvm_component_utils(dma_regression_test)

  dma_env            env;
  dma_regression_seq reg_seq;

  function new(string name="dma_regression_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = dma_env::type_id::create("env", this);
    reg_seq = dma_regression_seq::type_id::create("reg_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    reg_seq.regmodel = env.regmodel;

    reg_seq.start(env.dma_agnt.sequencer);

    phase.drop_objection(this);
  endtask
endclass

