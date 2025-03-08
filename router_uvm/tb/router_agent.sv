//input port + output port of one direction
//include:
//input driver
//input monitor
//ouput monitor

class router_agent extends uvm_agent;
    router_driver drv;
    router_monitor mon_in;  //not send back yummy
    router_monitor mon_out; //send back yummy

    router_sequencer sqr;

    int router_in_buffer_size;

    uvm_analysis_port #(packet_transaction)  ap_in;     //connect to mon_in ap
    uvm_analysis_port #(packet_transaction)  ap_out;    //connect to mon_out ap

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

    `uvm_component_utils(router_agent)
endclass

function void router_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    drv = router_driver::type_id::create("drv", this);
    drv.router_buffer_size = router_in_buffer_size;

    mon_in = router_monitor::type_id::create("mon_in", this);
    mon_out = router_monitor::type_id::create("mon_out", this);
    mon_in.yummy_flag = 0;
    mon_out.yummy_flag = 1;

    sqr = router_sequencer::type_id::create("sqr",this);

endfunction 

function void router_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv.seq_item_port.connect(sqr.seq_item_export);
    
    ap_in = mon_in.ap;
    ap_out = mon_out.ap;
 endfunction