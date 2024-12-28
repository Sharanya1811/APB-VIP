class apb_slave_driver extends uvm_driver#(apb_trans);
  `uvm_component_utils(apb_slave_driver)
  virtual apb_interface vif;
  apb_config cfg;
  function new(string name="apb_slave_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_config)::get(this,"","apb_config",cfg))
      `uvm_fatal(get_full_name(),"No interface is set")
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=cfg.vif;
  endfunction
  
 task run_phase(uvm_phase phase);
   reset();
    forever begin 
      seq_item_port.get_next_item(req);
      `uvm_info(get_full_name(),"HELLO",UVM_LOW)
      drive_item(req);
      seq_item_port.item_done();
    end
  endtask
  
 task reset();
    vif.s_drv_cb.pready<=0;
    vif.s_drv_cb.prdata<=0;
 endtask
  
  task drive_item(apb_trans req);
    if(req.pwrite==1)
      drive_write(req);
    else
      drive_read(req);
  endtask
/* 
  task drive_write(apb_trans req);
    if(vif.s_drv_cb.psel) 
     begin
       @(vif.s_drv_cb);
       if(vif.s_drv_cb.penable && vif.s_drv_cb.psel) begin
     `uvm_info(get_full_name(),"IN DRIVE WRITE SLAVE",UVM_LOW)       
         while(req.wait_time) begin
           @(vif.s_drv_cb);
            req.wait_time--;
         end
       vif.s_drv_cb.pready<=1;
       @(vif.s_drv_cb);
       vif.s_drv_cb.pready<=0;
      `uvm_info(get_full_name(),"END OF DRIVER SLAVE",UVM_LOW)
       end
     end
endtask
  
*/    
task drive_write(apb_trans req);
    @(vif.s_drv_cb);
    @(vif.s_drv_cb);    
    @(vif.s_drv_cb);
    @(vif.s_drv_cb);

    `uvm_info(get_full_name(),$sformatf("value of slave driver psel=%d",vif.s_drv_cb.psel),UVM_LOW) 
    `uvm_info(get_full_name(),$sformatf("value of slave penable=%d",vif.s_drv_cb.penable),UVM_LOW)  
   
    if(vif.s_drv_cb.psel && vif.s_drv_cb.penable)
      begin
        `uvm_info(get_full_name(),"IN DRIVE WRITE SLAVE",UVM_LOW) 
        while(req.wait_time) begin
          @(vif.s_drv_cb);
          req.wait_time--;
        end 
        vif.s_drv_cb.pready<=1;
        `uvm_info(get_full_name(),"END OF DRIVER SLAVE",UVM_LOW)
      end
    @(vif.s_drv_cb);
    vif.s_drv_cb.pready<=0;
  endtask
  
task drive_read(apb_trans req);
     @(vif.s_drv_cb);
    @(vif.s_drv_cb);    
    @(vif.s_drv_cb);
    @(vif.s_drv_cb);

    `uvm_info(get_full_name(),$sformatf("value of slave driver psel=%d",vif.s_drv_cb.psel),UVM_LOW) 
    `uvm_info(get_full_name(),$sformatf("value of slave penable=%d",vif.s_drv_cb.penable),UVM_LOW)  
   
    if(vif.s_drv_cb.psel && vif.s_drv_cb.penable)
      begin
        `uvm_info(get_full_name(),"IN DRIVE WRITE SLAVE",UVM_LOW) 
        while(req.wait_time) begin
          @(vif.s_drv_cb);
          req.wait_time--;
        end 
        vif.s_drv_cb.pready<=1;
        vif.s_drv_cb.prdata<=req.prdata;
        `uvm_info(get_full_name(),"END OF DRIVER SLAVE",UVM_LOW)
      end
    @(vif.s_drv_cb);
    vif.s_drv_cb.pready<=0;
endtask
  
    
endclass
 
