
class write_without_wait_seq extends uvm_sequence#(apb_trans);
  
  `uvm_object_utils(write_without_wait_seq)
  
  function new (string name = "");
    super.new(name);
  endfunction
  
  task body();
    apb_trans rw_trans;
    //create 10 random APB read/write transaction and send to driver
    repeat (2) begin
      rw_trans=new();
      start_item(rw_trans);
      assert(rw_trans.randomize() with{rw_trans.pwrite==1;rw_trans.psel==1;rw_trans.wait_time==1;});
      finish_item(rw_trans);
    end
  endtask
endclass
