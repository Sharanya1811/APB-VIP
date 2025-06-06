class apb_coverage extends uvm_object;
  `uvm_object_utils(apb_coverage)
  apb_trans xtn;
//  virtual apb_interface vif;
  //apb_config cfg;
  
     covergroup apb_cg;
          option.per_instance=1;
        PWRITE: coverpoint xtn.pwrite{bins b1[]={0,1};}
        PSEL: coverpoint xtn.psel{bins b1[]={0,1};}
        PREADY: coverpoint xtn.pready{bins b1[]={0,1};}
        PENABLE: coverpoint xtn.penable{bins b1[]={0,1};}
        PRESETN: coverpoint xtn.presetn{bins b1[]={0,1};}
      endgroup
  
  function new(string name="apb_coverage");
    super.new(name);
        xtn=apb_trans::type_id::create("xtn");
    apb_cg=new();
    
    //if(uvm_config_db#(apb_config)::get(this,"","apb_config",cfg))
     // `uvm_fatal(get_full_name(),"Virtual Interface is not set in apb_coverage")
      
    //vif=cfg.vif; 
  endfunction
  


    
 
endclass
