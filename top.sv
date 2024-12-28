// Code your testbench here
// or browse Examples
`define MASTER_AGENTS 1
`define SLAVE_AGENTS 1
`define ADDR_WIDTH 32
`define DATA_WIDTH 32

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "apb_interface.sv"


`include "apb_config.sv"
`include "apb_trans.sv"
`include "apb_sequence.sv"

`include "apb_master_driver.sv"
`include "apb_master_monitor.sv"
`include "apb_master_sequencer.sv"

`include "apb_slave_driver.sv"
`include "apb_slave_monitor.sv"
`include "apb_slave_sequencer.sv"

`include "apb_master_agent.sv"
`include "apb_slave_agent.sv"


`include "apb_scoreboard.sv"
`include "apb_env.sv"
`include "apb_test.sv"

module top;
  
  bit clk,rstn;
  apb_interface vif();

  apb_slave dut(.dif(vif));
  apb_config cfg;

   initial begin
      vif.pclk=0;
   end

    //Generate a clock
   always begin
      #5 vif.pclk = ~vif.pclk;
   end

  initial begin
    vif.presetn=0;
      repeat (1) @(posedge vif.pclk);
    vif.presetn=1;
    end
 
    initial
    begin   
      uvm_config_db#(virtual apb_interface)::set(null,"*","apb_interface",vif);
      run_test("write_without_wait_test");
    end
  
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    end
  
endmodule
