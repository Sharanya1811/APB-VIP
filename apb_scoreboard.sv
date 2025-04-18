class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)
  uvm_tlm_analysis_fifo#(apb_trans) master_fifo;
  uvm_tlm_analysis_fifo#(apb_trans) slave_fifo;

  apb_trans master_data,slave_data;
  
  apb_config cfg;
  extern function new(string name="apb_scoreboard",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase); 
  extern task check_data(apb_trans master_data,slave_data);  
endclass  
  
  function apb_scoreboard::new(string name="apb_scoreboard",uvm_component parent);
    super.new(name,parent);
    master_fifo=new("master_fifo",this);
    slave_fifo=new("slave_fifo",this);
    master_data=apb_trans::type_id::create("master_data");
    slave_data=apb_trans::type_id::create("slave_data");    
  endfunction
  
  function void apb_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_config)::get(this,"","apb_config",cfg))
      `uvm_fatal(get_full_name(),"No interface is set")
  endfunction

  
  task apb_scoreboard::run_phase(uvm_phase phase);
    forever
      begin
        fork
        master_fifo.get(master_data);
        slave_fifo.get(slave_data);
        join
        check_data(master_data,slave_data);
      end
  endtask
    
  
  task apb_scoreboard::check_data(apb_trans master_data,slave_data);    
      if(master_data.pwrite || master_data.paddr || master_data.pwdata)
         begin
           if(master_data.pwrite && slave_data.pready && master_data.penable)
             begin
               if(master_data.paddr==slave_data.paddr)
                 begin
                   `uvm_info(get_full_name(),$sformatf("PASSED value of paddr=%d",master_data.paddr),UVM_LOW)
                 if(master_data.pwdata==slave_data.pwdata)
                   `uvm_info(get_full_name(),$sformatf("PASSED value of master pwdata=%d",master_data.pwdata),UVM_LOW)
                 else
                   `uvm_error(get_full_name(),$sformatf("FAIL master data=%d slave data=%d",master_data.pwdata,slave_data.pwdata))
                   end
                 else
                   `uvm_error(get_full_name(),$sformatf("FAIL master address=%d, slave address=%d",master_data.paddr,slave_data.paddr))
             end
                   
           else
             begin
               if(master_data.paddr==slave_data.paddr)
                 begin
                   `uvm_info(get_full_name(),$sformatf("PASS value of paddr=%d",master_data.paddr),UVM_LOW)
                 if(master_data.prdata==slave_data.prdata)
                   `uvm_info(get_full_name(),$sformatf("PASS value of master prdata=%d",master_data.prdata),UVM_LOW)
                 else
                   `uvm_error(get_full_name(),$sformatf("FAIL master data=%d slave data=%d",master_data.prdata,slave_data.prdata))
                   end
                 else
                   `uvm_error(get_full_name(),$sformatf("FAIL master address=%d, slave address=%d",master_data.paddr,slave_data.paddr))
             end
         end 
    endtask
