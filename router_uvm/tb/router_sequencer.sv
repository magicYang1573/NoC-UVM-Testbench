`ifndef ROUTEr_SEQUENCER__SV
`define ROUTE_SEQUENCER__SV

class router_sequencer extends uvm_sequencer #(packet_transaction);
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(router_sequencer)
endclass

`endif
