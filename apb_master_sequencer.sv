class apb_master_sequencer extends uvm_sequencer#(apb_trans);
  `uvm_component_utils(apb_master_sequencer)
  
   apb_config cfg;

  extern function new(string name="apb_master_sequencer",uvm_component parent); 
 extern function void build_phase(uvm_phase phase);
  
endclass
      
   function apb_master_sequencer::new(string name="apb_master_sequencer",uvm_component  parent);
    super.new(name,parent);
  endfunction
  
  function void apb_master_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_config)::get(this,"","apb_config",cfg))
      `uvm_fatal(get_full_name(),"No interface is set")
  endfunction
      
