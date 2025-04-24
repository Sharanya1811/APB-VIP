
class write_without_wait_seq extends uvm_sequence#(apb_trans);
  
  `uvm_object_utils(write_without_wait_seq)
  
  function new (string name = "");
    super.new(name);
  endfunction
  
  task body();
    apb_trans rw_trans;
    repeat (2) begin
      rw_trans=new();
      start_item(rw_trans);
      assert(rw_trans.randomize() with{rw_trans.pwrite==1;rw_trans.psel==1;rw_trans.wait_time==0;});
      finish_item(rw_trans);
    end
  endtask
endclass



class write_with_wait_seq extends uvm_sequence#(apb_trans);
  
  `uvm_object_utils(write_with_wait_seq)
  
  function new (string name = "");
    super.new(name);
  endfunction
  
  task body();
    apb_trans rw_trans;
    repeat (5) begin
      rw_trans=new();
      start_item(rw_trans);
      assert(rw_trans.randomize() with{rw_trans.pwrite==1;rw_trans.psel==1;rw_trans.wait_time==3;});
      finish_item(rw_trans);
    end
  endtask
endclass


class read_without_wait_seq extends uvm_sequence#(apb_trans);
  
  `uvm_object_utils(read_without_wait_seq)
  
  function new (string name = "");
    super.new(name);
  endfunction
  
  task body();
    apb_trans rw_trans;
    repeat (5) begin
      rw_trans=new();
      start_item(rw_trans);
      assert(rw_trans.randomize() with{rw_trans.pwrite==0;rw_trans.psel==1;rw_trans.wait_time==0;});
      finish_item(rw_trans);
    end
  endtask
endclass

class read_with_wait_seq extends uvm_sequence#(apb_trans);
  
  `uvm_object_utils(read_with_wait_seq)
  
  function new (string name = "");
    super.new(name);
  endfunction
  
  task body();
    apb_trans rw_trans;
    repeat (5) begin
      rw_trans=new();
      start_item(rw_trans);
      assert(rw_trans.randomize() with{rw_trans.pwrite==0;rw_trans.psel==1;rw_trans.wait_time==4;});
      finish_item(rw_trans);
    end
  endtask
endclass
