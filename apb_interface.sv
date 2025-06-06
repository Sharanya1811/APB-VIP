interface apb_interface();
  logic pclk,presetn;
  logic pready;
  logic penable;
  logic pwrite;
  logic [`ADDR_WIDTH-1:0]paddr;
  logic [(`DATA_WIDTH/8)-1:0] pstrb;
  logic [`DATA_WIDTH-1:0] pwdata;
  logic [`DATA_WIDTH-1:0] prdata;
  logic pslverr;
  logic psel;

 // clocking block for master driver
    clocking m_drv_cb @(posedge pclk);
    output pwrite;
    output psel;
    output penable;
    output paddr;
    output pwdata;
    output pstrb;
    input pslverr;
    input prdata;
    endclocking
 
  // clocking block for master monitor
    clocking m_mon_cb @(posedge pclk);
    input pwrite;
    input psel;
    input penable;
    input paddr;
    input pwdata;
    input pslverr;
    input pstrb;
    input pready;
    input prdata;
    endclocking
 
  // clocking block for slave driver
  clocking s_drv_cb @(posedge pclk);
    input pwrite;
    input psel;
    input penable;
    input paddr;
    input pwdata;
    input pslverr;
    input pstrb;
    output pready;
    output prdata;
    endclocking
 
  // clocking block for slave monitor
  clocking s_mon_cb @(posedge pclk);
    input pwrite;
    input psel;
    input penable;
    input paddr;
    input pwdata;
    input pslverr;
    input pready;
    input prdata;
    endclocking
     
  
   apb_addr_stable: assert property (
     @(posedge pclk) disable iff (!presetn)
    psel && penable |-> paddr 
  ) else $fatal("APB violation: PADDR changed during PENABLE");

  // Assertion: PENABLE should not be high unless PSEL was high
  apb_penable_after_psel: assert property (
    @(posedge pclk) disable iff (!presetn)
    penable |-> psel
  ) else $fatal("APB violation: PENABLE without PSEL");

  // Assertion: PREADY sampled only when PENABLE is high
  apb_pready_during_penable: assert property (
    @(posedge pclk) disable iff (!presetn)
    pready |-> penable
  ) else $fatal("APB violation: PREADY asserted without PENABLE");
   
   
 
endinterface
