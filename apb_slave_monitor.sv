
 class apb_slave_monitor extends uvm_monitor;
   `uvm_component_utils(apb_slave_monitor)
   uvm_analysis_port#(apb_trans) slave_mon2sb;
   virtual apb_interface vif;
  apb_config cfg;
  apb_trans data_sent;
   extern function new(string name="apb_slave_monitor",uvm_component parent);
  extern function void build_phase(uvm_phase phase);  
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task collect_data();

endclass


    function apb_slave_monitor::new(string name="apb_slave_monitor",uvm_component parent);
    super.new(name,parent);
      slave_mon2sb=new("slave_mon2sb",this);
  endfunction
  
  function void apb_slave_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_config)::get(this,"","apb_config",cfg))
      `uvm_fatal(get_full_name(),"No interface is set")
  endfunction
  
  function void apb_slave_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=cfg.vif;
  endfunction

  task apb_slave_monitor::run_phase(uvm_phase phase);
    super.run_phase(phase);
          data_sent=apb_trans::type_id::create("data_sent");
    forever begin
      collect_data();
    end
  endtask

    
    task apb_slave_monitor::collect_data();
     @(vif.s_mon_cb)
    if(vif.s_mon_cb.psel) begin
        data_sent.paddr<=vif.s_mon_cb.paddr;
        data_sent.psel<=vif.s_mon_cb.psel;
        data_sent.pwrite<=vif.s_mon_cb.pwrite;
        data_sent.penable = vif.s_mon_cb.penable;
      
    if(data_sent.penable && vif.s_mon_cb.pready) begin
       `uvm_info(get_full_name(),$sformatf("value of slave pwdata=%d",vif.s_mon_cb.pwdata),UVM_LOW) 
       `uvm_info(get_full_name(),$sformatf("value of slave pready=%d",vif.s_mon_cb.pready),UVM_LOW)
       `uvm_info(get_full_name(),$sformatf("value of slave penable=%d",vif.s_mon_cb.penable),UVM_LOW)
       `uvm_info(get_full_name(),$sformatf("value of slave pready=%d",vif.s_mon_cb.pready),UVM_LOW)
       `uvm_info(get_full_name(),$sformatf("value of slave paddr=%d",vif.s_mon_cb.paddr),UVM_LOW)
      if(vif.s_mon_cb.pwrite) begin
        data_sent.pready=vif.s_mon_cb.pready;
        data_sent.pwdata  = vif.s_mon_cb.pwdata;
       slave_mon2sb.write(data_sent);
      end
      else
      begin
        `uvm_info(get_full_name(),$sformatf("value of slave prdata=%d",vif.s_mon_cb.prdata),UVM_LOW) 
        `uvm_info(get_full_name(),$sformatf("value of slave pready=%d",vif.s_mon_cb.pready),UVM_LOW)
        `uvm_info(get_full_name(),$sformatf("value of slave penable=%d",vif.s_mon_cb.penable),UVM_LOW)
        `uvm_info(get_full_name(),$sformatf("value of slave pready=%d",vif.s_mon_cb.pready),UVM_LOW)
        `uvm_info(get_full_name(),$sformatf("value of slave paddr=%d",vif.s_mon_cb.paddr),UVM_LOW)
        data_sent.pready=vif.s_mon_cb.pready;
        data_sent.prdata =vif.s_mon_cb.prdata;
        slave_mon2sb.write(data_sent);
      end
    end
  end
  endtask
