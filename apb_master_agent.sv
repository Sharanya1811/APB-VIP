class apb_master_agent extends uvm_agent;
  `uvm_component_utils(apb_master_agent)
  apb_master_driver drv;
  apb_master_monitor mon;
  apb_master_sequencer seqr;
  apb_config cfg;

  extern function new(string name="apb_master_agent",uvm_component parent);
  extern function void build_phase(uvm_phase phase);  
  extern function void connect_phase(uvm_phase phase);
   
endclass

function apb_master_agent::new(string name="apb_master_agent",uvm_component parent);
   super.new(name,parent);
endfunction
  
function void apb_master_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(apb_config)::get(this,"","apb_config",cfg))
     `uvm_fatal(get_full_name(),"No config is not set")   
  
        
    mon=apb_master_monitor::type_id::create("mon",this);
  
  if(cfg.is_active_master==UVM_ACTIVE)  begin
      drv=apb_master_driver::type_id::create("drv",this);
      seqr=apb_master_sequencer::type_id::create("seqr",this);
    end
endfunction
  
function void apb_master_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(cfg.is_active_master==UVM_ACTIVE) begin
    drv.seq_item_port.connect(seqr.seq_item_export);
  end
endfunction
