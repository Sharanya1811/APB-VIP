
class apb_vsequencer extends uvm_sequencer#(uvm_sequence_item);
  `uvm_component_utils(apb_vsequencer)
  apb_master_sequencer mseqr;
  
  extern function new(string name="apb_vsequencer",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
endclass

    function apb_vsequencer::new(string name="apb_vsequencer",uvm_component parent);
      super.new(name,parent);
    endfunction  
   
   function void apb_vsequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
   endfunction
      
