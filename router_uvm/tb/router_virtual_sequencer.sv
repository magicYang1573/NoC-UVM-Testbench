class router_virtual_sequencer extends uvm_sequencer;

    router_sequencer sqr_N;
    router_sequencer sqr_E;
    router_sequencer sqr_S;
    router_sequencer sqr_W;
    router_sequencer sqr_P;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 
     
    `uvm_component_utils(router_virtual_sequencer)

endclass