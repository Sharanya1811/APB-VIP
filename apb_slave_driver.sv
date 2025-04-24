class apb_slave_driver extends uvm_driver#(apb_trans);
  `uvm_component_utils(apb_slave_driver)
  virtual apb_interface vif;
  apb_config cfg;
  apb_trans req;
  function new(string name="apb_slave_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_config)::get(this,"","apb_config",cfg))
      `uvm_fatal(get_full_name(),"No interface is set")
      req=apb_trans::type_id::create("req");  
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=cfg.vif;
  endfunction
  
  task reset();
   @(vif.s_drv_cb);
    vif.s_drv_cb.pready<=0;
    vif.s_drv_cb.prdata<=0;
  endtask


 
  task run_phase(uvm_phase phase);
  reset();
  req=apb_trans::type_id::create("req");
     forever begin 
      seq_item_port.get_next_item(req);
     `uvm_info(get_full_name(),"HELLO",UVM_LOW)
      drive_item(req);
      seq_item_port.item_done();
    end
  endtask
  
  task drive_item(apb_trans req);
           //@(posedge vif.s_drv_cb.psel);
     //@(posedge vif.s_drv_cb.penable);
    forever begin
      @(vif.s_drv_cb);
     if (vif.s_drv_cb.psel && vif.s_drv_cb.penable) begin
         repeat (req.wait_time - 1) @(vif.s_drv_cb);
          if(vif.s_drv_cb.pwrite) begin
             vif.s_drv_cb.pready <= 1;
          end
          else begin
             vif.s_drv_cb.pready <= 1;
             vif.s_drv_cb.prdata<=req.prdata;
          end
       @(vif.s_drv_cb);
       vif.s_drv_cb.pready <= 0;
       break;
       end
    end
   endtask

    
endclass
