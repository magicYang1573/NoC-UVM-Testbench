
class mesh_virtual_sequencer extends uvm_sequencer;
    
    router_sequencer sqr_0_0;
    router_sequencer sqr_0_1;
    router_sequencer sqr_0_2;
    router_sequencer sqr_0_3;
    router_sequencer sqr_0_4;
    router_sequencer sqr_1_0;
    router_sequencer sqr_1_1;
    router_sequencer sqr_1_2;
    router_sequencer sqr_1_3;
    router_sequencer sqr_1_4;
    router_sequencer sqr_2_0;
    router_sequencer sqr_2_1;
    router_sequencer sqr_2_2;
    router_sequencer sqr_2_3;
    router_sequencer sqr_2_4;
    router_sequencer sqr_3_0;
    router_sequencer sqr_3_1;
    router_sequencer sqr_3_2;
    router_sequencer sqr_3_3;
    router_sequencer sqr_3_4;
    router_sequencer sqr_4_0;
    router_sequencer sqr_4_1;
    router_sequencer sqr_4_2;
    router_sequencer sqr_4_3;
    router_sequencer sqr_4_4;


    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 
     
    `uvm_component_utils(mesh_virtual_sequencer)

endclass