class apb_master_driver extends uvm_driver#(apb_trans);
  `uvm_component_utils(apb_master_driver)

  virtual apb_interface vif;
  apb_config cfg;
  extern function new(string name="apb_master_driver",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task reset();
  extern task drive_item(apb_trans req);
  extern task drive_write(apb_trans req);
  extern task drive_read(apb_trans req);

endclass


  function apb_master_driver::new(string name="apb_master_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void apb_master_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_config)::get(this,"","apb_config",cfg))
      `uvm_fatal(get_full_name(),"No interface is set")
  endfunction 
  
  function void apb_master_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=cfg.vif;
  endfunction 
 
  task apb_master_driver::reset();
    @(vif.m_drv_cb);
    vif.m_drv_cb.paddr<=0;
    vif.m_drv_cb.penable<=0;
    vif.m_drv_cb.psel<=0;
    vif.m_drv_cb.pwrite<=0;
    vif.m_drv_cb.pwdata<=0;
    vif.m_drv_cb.pstrb<=0;
 endtask   
        
  task apb_master_driver::run_phase(uvm_phase phase);
    reset();
   forever begin
     seq_item_port.get_next_item(req);
     if(req.pwrite==1)
       drive_write(req);
     else
       drive_read(req);
     seq_item_port.item_done();
   end
  endtask 
 
    task apb_master_driver::drive_read(apb_trans req);
      @(vif.m_drv_cb);
      vif.m_drv_cb.paddr<=req.paddr;
      vif.m_drv_cb.pwrite<=req.pwrite;
      vif.m_drv_cb.psel<=req.psel;
      vif.m_drv_cb.pwdata<=req.pwdata;
      
      @(vif.m_drv_cb);
      vif.m_drv_cb.penable<=1'b1;

      @(posedge vif.m_drv_cb.pready);
      
       @(vif.m_drv_cb);
       vif.m_drv_cb.penable<=0;
       vif.m_drv_cb.psel<=0;
   endtask
   
    
   
    
    task apb_master_driver::drive_write(apb_trans req);
      @(vif.m_drv_cb);
      vif.m_drv_cb.paddr<=req.paddr;
      vif.m_drv_cb.pwrite<=req.pwrite;
      vif.m_drv_cb.psel<=req.psel;
      vif.m_drv_cb.pwdata<=req.pwdata;
      
      @(vif.m_drv_cb);
      vif.m_drv_cb.penable<=1'b1;

      @(posedge vif.m_drv_cb.pready);
      
       @(vif.m_drv_cb);
       vif.m_drv_cb.penable<=0;
       vif.m_drv_cb.psel<=0;
   endtask
