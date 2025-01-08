class write_with_wait_test extends uvm_test;
  `uvm_component_utils(write_with_wait_test);
  apb_environment env;
  write_with_wait_seq seq1,seq2;
  apb_config cfg;
  uvm_active_passive_enum is_active;
  function new(string name="write_with_wait_test",uvm_component parent);
    super.new(name,parent);   
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg=apb_config::type_id::create("cfg");
    cfg.apb_as_master=1;
    cfg.apb_as_slave=0;
    cfg.has_apb_scoreboard=1;
    cfg.is_active_master=UVM_ACTIVE;
    cfg.is_active_slave=UVM_ACTIVE;   
    if(!uvm_config_db#(virtual apb_interface)::get(this,"","apb_interface",cfg.vif))
      `uvm_fatal(get_full_name(),"No interface is set")
  
      
    uvm_config_db#(apb_config)::set(this,"*","apb_config",cfg);
    env=apb_environment::type_id::create("env",this);
    seq1=write_with_wait_seq::type_id::create("seq1");
        $cast(seq2,seq1.clone());
  endfunction
  
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
      fork
        seq1.start(env.vseqr.m_seqr);
        seq2.start(env.vseqr.s_seqr);
    join
    #100ns;
    phase.drop_objection(this);
  endtask
endclass



class write_without_wait_test extends uvm_test;
  `uvm_component_utils(write_without_wait_test);
  apb_environment env;
  write_without_wait_seq seq1,seq2;
  apb_config cfg;
  uvm_active_passive_enum is_active;
  function new(string name="write_without_wait_test",uvm_component parent);
    super.new(name,parent);   
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg=apb_config::type_id::create("cfg");
    cfg.has_apb_scoreboard=1;
    cfg.is_active_master=UVM_ACTIVE;
    cfg.is_active_slave=UVM_ACTIVE;   
    if(!uvm_config_db#(virtual apb_interface)::get(this,"","apb_interface",cfg.vif))
      `uvm_fatal(get_full_name(),"No interface is set")
 
      
    uvm_config_db#(apb_config)::set(this,"*","apb_config",cfg);
    env=apb_environment::type_id::create("env",this);
    seq1=write_without_wait_seq::type_id::create("seq1");
        $cast(seq2,seq1.clone());
  endfunction
  
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
       fork
        seq1.start(env.vseqr.m_seqr);
        seq2.start(env.vseqr.s_seqr);
       join    
    #100ns;
    phase.drop_objection(this);
  endtask
endclass


class read_without_wait_test extends uvm_test;
  `uvm_component_utils(read_without_wait_test);
  apb_environment env;
  read_without_wait_seq seq1,seq2;
  apb_config cfg;
  uvm_active_passive_enum is_active;
  function new(string name="read_without_wait_test",uvm_component parent);
    super.new(name,parent);   
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg=apb_config::type_id::create("cfg");
    cfg.has_apb_scoreboard=1;
    cfg.is_active_master=UVM_ACTIVE;
    cfg.is_active_slave=UVM_ACTIVE;   
    if(!uvm_config_db#(virtual apb_interface)::get(this,"","apb_interface",cfg.vif))
      `uvm_fatal(get_full_name(),"No interface is set")
 
      
    uvm_config_db#(apb_config)::set(this,"*","apb_config",cfg);
    env=apb_environment::type_id::create("env",this);
    seq1=read_without_wait_seq::type_id::create("seq1");
        $cast(seq2,seq1.clone());
  endfunction
  
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
       fork
        seq1.start(env.vseqr.m_seqr);
        seq2.start(env.vseqr.s_seqr);
       join    
    #100ns;
    phase.drop_objection(this);
  endtask
endclass


class read_with_wait_test extends uvm_test;
  `uvm_component_utils(read_with_wait_test);
  apb_environment env;
  read_with_wait_seq seq1,seq2;
  apb_config cfg;
  uvm_active_passive_enum is_active;
  function new(string name="read_with_wait_test",uvm_component parent);
    super.new(name,parent);   
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg=apb_config::type_id::create("cfg");
    cfg.has_apb_scoreboard=1;
    cfg.is_active_master=UVM_ACTIVE;
    cfg.is_active_slave=UVM_ACTIVE;   
    if(!uvm_config_db#(virtual apb_interface)::get(this,"","apb_interface",cfg.vif))
      `uvm_fatal(get_full_name(),"No interface is set")
 
      
    uvm_config_db#(apb_config)::set(this,"*","apb_config",cfg);
    env=apb_environment::type_id::create("env",this);
    seq1=read_with_wait_seq::type_id::create("seq1");
        $cast(seq2,seq1.clone());
  endfunction
  
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
       fork
        seq1.start(env.vseqr.m_seqr);
        seq2.start(env.vseqr.s_seqr);
       join    
    #100ns;
    phase.drop_objection(this);
  endtask
endclass
