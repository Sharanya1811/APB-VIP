
`include "apb_vsequencer.sv"
class apb_environment extends uvm_env;
  `uvm_component_utils(apb_environment)
  apb_scoreboard sc;
  apb_master_agent m_agent;
  apb_slave_agent s_agent;
  apb_config cfg;
  apb_vsequencer vseqr;

  
  function new(string name="apb_environment",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(apb_config)::get(this,"","apb_config",cfg))
      `uvm_fatal(get_full_name(),"No interface is set")
    
    m_agent=apb_master_agent::type_id::create("m_agent",this);
    s_agent=apb_slave_agent::type_id::create("s_agent",this);
    vseqr=apb_vsequencer::type_id::create("vseqr",this);  
    
    if(cfg.has_apb_scoreboard)
       sc=apb_scoreboard::type_id::create("sc",this);   

    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vseqr.m_seqr=m_agent.seqr;
    vseqr.s_seqr=s_agent.seqr;
    m_agent.mon.master_mon2sb.connect(sc.master_fifo.analysis_export);
    s_agent.mon.slave_mon2sb.connect(sc.slave_fifo.analysis_export);
  endfunction  
  
endclass
