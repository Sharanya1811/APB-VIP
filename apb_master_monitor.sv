class apb_master_monitor extends uvm_monitor;
  `uvm_component_utils(apb_master_monitor)
  uvm_analysis_port#(apb_trans) master_mon2sb;  
  virtual apb_interface vif;
  apb_config cfg;
  apb_trans data_sent;
  extern function new(string name="apb_master_monitor",uvm_component parent);
  extern function void build_phase(uvm_phase phase);  
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task collect_data();

endclass


    function apb_master_monitor::new(string name="apb_master_monitor",uvm_component parent);
    super.new(name,parent);
      master_mon2sb=new("master_mon2sb",this);
    endfunction 
  
  function void apb_master_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_config)::get(this,"","apb_config",cfg))
      `uvm_fatal(get_full_name(),"No interface is set")
      
  endfunction 
  
  function void apb_master_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=cfg.vif;
  endfunction 

  task apb_master_monitor::run_phase(uvm_phase phase);
    super.run_phase(phase);
    data_sent=apb_trans::type_id::create("data_sent");
    forever begin
      collect_data();
    end
  endtask 
    
  task apb_master_monitor::collect_data();
    @(vif.m_mon_cb);
    if(vif.m_mon_cb.paddr &&  vif.m_mon_cb.pwrite && vif.m_mon_cb.psel && vif.m_mon_cb.pwdata)
      begin
        if(vif.m_mon_cb.pwrite==1)
          begin  
            if(vif.m_mon_cb.pready && vif.m_mon_cb.penable) begin
              data_sent.psel   = vif.m_mon_cb.psel;
              data_sent.paddr  = vif.m_mon_cb.paddr;
              data_sent.pwrite = vif.m_mon_cb.pwrite;
              data_sent.penable = vif.m_mon_cb.penable;
              data_sent.pwdata  = vif.m_mon_cb.pwdata;
              data_sent.pready =vif.m_mon_cb.pready;

            `uvm_info(get_full_name(),$sformatf("value of master pwdata=%d",data_sent.pwdata),UVM_LOW) 
            `uvm_info(get_full_name(),$sformatf("value of master pready=%d",vif.m_mon_cb.pready),UVM_LOW)
            `uvm_info(get_full_name(),$sformatf("value of master penable=%d",vif.m_mon_cb.penable),UVM_LOW)
            `uvm_info(get_full_name(),$sformatf("value of master psel=%d",vif.m_mon_cb.psel),UVM_LOW)
            `uvm_info(get_full_name(),$sformatf("value of master paddr=%d",vif.m_mon_cb.paddr),UVM_LOW)  
            `uvm_info(get_full_name(),$sformatf("value of master pready=%d",vif.m_mon_cb.pready),UVM_LOW)
             master_mon2sb.write(data_sent);
            end
          end
        else
          begin
            if(vif.m_mon_cb.pready && vif.m_mon_cb.penable)
              data_sent.psel   = vif.m_mon_cb.psel;
              data_sent.paddr  = vif.m_mon_cb.paddr;
              data_sent.pwrite = vif.m_mon_cb.pwrite;
              data_sent.penable = vif.m_mon_cb.penable;
              data_sent.pwdata  = vif.m_mon_cb.pwdata;
              data_sent.pready =vif.m_mon_cb.pready;   
              data_sent.prdata = vif.m_mon_cb.prdata;
              master_mon2sb.write(data_sent);
            end
         end
   endtask
 
