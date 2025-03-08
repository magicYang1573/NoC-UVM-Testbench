`ifndef ROUTER_IF__SV
`define ROUTER_IF__SV

interface router_if(input clk, input rst);

   logic [`DATA_WIDTH-1:0] data;
   logic valid;
   logic yummy;

endinterface

interface router_rst_if(input clk);
   logic rst;
endinterface

`endif