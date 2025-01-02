class apb_config extends uvm_object;
  `uvm_object_utils(apb_config)
  
  uvm_active_passive_enum is_active_master= UVM_ACTIVE;
  uvm_active_passive_enum is_active_slave= UVM_PASSIVE;
  virtual apb_interface vif;
  bit has_apb_scoreboard=1;
  int wait_time=0;
  
  extern function new(string name="apb_config");
endclass


 function apb_config::new(string name="apb_config");
    super.new(name);
  endfunction
