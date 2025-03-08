`ifndef MESH_ENV__SV
`define MESH_ENV__SV

// UVM env for N*M mesh
class mesh_env extends uvm_env;

     demoter demoter_tmp;     //clean the log info
     
     //declare agent for every router
     
    router_agent agt_0_0;
    router_agent agt_0_1;
    router_agent agt_0_2;
    router_agent agt_0_3;
    router_agent agt_0_4;
    router_agent agt_1_0;
    router_agent agt_1_1;
    router_agent agt_1_2;
    router_agent agt_1_3;
    router_agent agt_1_4;
    router_agent agt_2_0;
    router_agent agt_2_1;
    router_agent agt_2_2;
    router_agent agt_2_3;
    router_agent agt_2_4;
    router_agent agt_3_0;
    router_agent agt_3_1;
    router_agent agt_3_2;
    router_agent agt_3_3;
    router_agent agt_3_4;
    router_agent agt_4_0;
    router_agent agt_4_1;
    router_agent agt_4_2;
    router_agent agt_4_3;
    router_agent agt_4_4;


     mesh_scoreboard scb;

     mesh_virtual_sequencer vsqr;

     // connect every local port to scoreboard
     
    uvm_tlm_analysis_fifo #(packet_transaction) input_0_0_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_0_0_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_0_1_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_0_1_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_0_2_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_0_2_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_0_3_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_0_3_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_0_4_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_0_4_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_1_0_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_1_0_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_1_1_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_1_1_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_1_2_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_1_2_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_1_3_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_1_3_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_1_4_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_1_4_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_2_0_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_2_0_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_2_1_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_2_1_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_2_2_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_2_2_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_2_3_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_2_3_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_2_4_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_2_4_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_3_0_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_3_0_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_3_1_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_3_1_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_3_2_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_3_2_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_3_3_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_3_3_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_3_4_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_3_4_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_4_0_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_4_0_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_4_1_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_4_1_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_4_2_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_4_2_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_4_3_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_4_3_scb_fifo;

    uvm_tlm_analysis_fifo #(packet_transaction) input_4_4_scb_fifo;
    uvm_tlm_analysis_fifo #(packet_transaction) output_4_4_scb_fifo;


     
     function new(string name = "mesh_env", uvm_component parent);
          super.new(name, parent);
     endfunction


     `uvm_component_utils(mesh_env)

     extern virtual function void build_phase(uvm_phase phase);
     extern virtual function void connect_phase(uvm_phase phase);

endclass

function void mesh_env::build_phase(uvm_phase phase);
     super.build_phase(phase);

     demoter_tmp = new("d");       
     uvm_report_cb::add(null, demoter_tmp);  //set info
     
    agt_0_0 = router_agent::type_id::create("agt_0_0", this);
    agt_0_0.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_0_1 = router_agent::type_id::create("agt_0_1", this);
    agt_0_1.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_0_2 = router_agent::type_id::create("agt_0_2", this);
    agt_0_2.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_0_3 = router_agent::type_id::create("agt_0_3", this);
    agt_0_3.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_0_4 = router_agent::type_id::create("agt_0_4", this);
    agt_0_4.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_1_0 = router_agent::type_id::create("agt_1_0", this);
    agt_1_0.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_1_1 = router_agent::type_id::create("agt_1_1", this);
    agt_1_1.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_1_2 = router_agent::type_id::create("agt_1_2", this);
    agt_1_2.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_1_3 = router_agent::type_id::create("agt_1_3", this);
    agt_1_3.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_1_4 = router_agent::type_id::create("agt_1_4", this);
    agt_1_4.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_2_0 = router_agent::type_id::create("agt_2_0", this);
    agt_2_0.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_2_1 = router_agent::type_id::create("agt_2_1", this);
    agt_2_1.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_2_2 = router_agent::type_id::create("agt_2_2", this);
    agt_2_2.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_2_3 = router_agent::type_id::create("agt_2_3", this);
    agt_2_3.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_2_4 = router_agent::type_id::create("agt_2_4", this);
    agt_2_4.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_3_0 = router_agent::type_id::create("agt_3_0", this);
    agt_3_0.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_3_1 = router_agent::type_id::create("agt_3_1", this);
    agt_3_1.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_3_2 = router_agent::type_id::create("agt_3_2", this);
    agt_3_2.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_3_3 = router_agent::type_id::create("agt_3_3", this);
    agt_3_3.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_3_4 = router_agent::type_id::create("agt_3_4", this);
    agt_3_4.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_4_0 = router_agent::type_id::create("agt_4_0", this);
    agt_4_0.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_4_1 = router_agent::type_id::create("agt_4_1", this);
    agt_4_1.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_4_2 = router_agent::type_id::create("agt_4_2", this);
    agt_4_2.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_4_3 = router_agent::type_id::create("agt_4_3", this);
    agt_4_3.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
    agt_4_4 = router_agent::type_id::create("agt_4_4", this);
    agt_4_4.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;

     
     scb = mesh_scoreboard::type_id::create("scb", this);
     
     vsqr = mesh_virtual_sequencer::type_id::create("mesh_virtual_sequencer",this);

     
    input_0_0_scb_fifo = new("input_0_0_scb_fifo",this);
    input_0_1_scb_fifo = new("input_0_1_scb_fifo",this);
    input_0_2_scb_fifo = new("input_0_2_scb_fifo",this);
    input_0_3_scb_fifo = new("input_0_3_scb_fifo",this);
    input_0_4_scb_fifo = new("input_0_4_scb_fifo",this);
    input_1_0_scb_fifo = new("input_1_0_scb_fifo",this);
    input_1_1_scb_fifo = new("input_1_1_scb_fifo",this);
    input_1_2_scb_fifo = new("input_1_2_scb_fifo",this);
    input_1_3_scb_fifo = new("input_1_3_scb_fifo",this);
    input_1_4_scb_fifo = new("input_1_4_scb_fifo",this);
    input_2_0_scb_fifo = new("input_2_0_scb_fifo",this);
    input_2_1_scb_fifo = new("input_2_1_scb_fifo",this);
    input_2_2_scb_fifo = new("input_2_2_scb_fifo",this);
    input_2_3_scb_fifo = new("input_2_3_scb_fifo",this);
    input_2_4_scb_fifo = new("input_2_4_scb_fifo",this);
    input_3_0_scb_fifo = new("input_3_0_scb_fifo",this);
    input_3_1_scb_fifo = new("input_3_1_scb_fifo",this);
    input_3_2_scb_fifo = new("input_3_2_scb_fifo",this);
    input_3_3_scb_fifo = new("input_3_3_scb_fifo",this);
    input_3_4_scb_fifo = new("input_3_4_scb_fifo",this);
    input_4_0_scb_fifo = new("input_4_0_scb_fifo",this);
    input_4_1_scb_fifo = new("input_4_1_scb_fifo",this);
    input_4_2_scb_fifo = new("input_4_2_scb_fifo",this);
    input_4_3_scb_fifo = new("input_4_3_scb_fifo",this);
    input_4_4_scb_fifo = new("input_4_4_scb_fifo",this);

    output_0_0_scb_fifo = new("output_0_0_scb_fifo",this);
    output_0_1_scb_fifo = new("output_0_1_scb_fifo",this);
    output_0_2_scb_fifo = new("output_0_2_scb_fifo",this);
    output_0_3_scb_fifo = new("output_0_3_scb_fifo",this);
    output_0_4_scb_fifo = new("output_0_4_scb_fifo",this);
    output_1_0_scb_fifo = new("output_1_0_scb_fifo",this);
    output_1_1_scb_fifo = new("output_1_1_scb_fifo",this);
    output_1_2_scb_fifo = new("output_1_2_scb_fifo",this);
    output_1_3_scb_fifo = new("output_1_3_scb_fifo",this);
    output_1_4_scb_fifo = new("output_1_4_scb_fifo",this);
    output_2_0_scb_fifo = new("output_2_0_scb_fifo",this);
    output_2_1_scb_fifo = new("output_2_1_scb_fifo",this);
    output_2_2_scb_fifo = new("output_2_2_scb_fifo",this);
    output_2_3_scb_fifo = new("output_2_3_scb_fifo",this);
    output_2_4_scb_fifo = new("output_2_4_scb_fifo",this);
    output_3_0_scb_fifo = new("output_3_0_scb_fifo",this);
    output_3_1_scb_fifo = new("output_3_1_scb_fifo",this);
    output_3_2_scb_fifo = new("output_3_2_scb_fifo",this);
    output_3_3_scb_fifo = new("output_3_3_scb_fifo",this);
    output_3_4_scb_fifo = new("output_3_4_scb_fifo",this);
    output_4_0_scb_fifo = new("output_4_0_scb_fifo",this);
    output_4_1_scb_fifo = new("output_4_1_scb_fifo",this);
    output_4_2_scb_fifo = new("output_4_2_scb_fifo",this);
    output_4_3_scb_fifo = new("output_4_3_scb_fifo",this);
    output_4_4_scb_fifo = new("output_4_4_scb_fifo",this);

     

endfunction

function void mesh_env::connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     
    agt_0_0.ap_in.connect(input_0_0_scb_fifo.analysis_export);
    scb.input_0_0_port.connect(input_0_0_scb_fifo.blocking_get_export);
    agt_0_0.ap_out.connect(output_0_0_scb_fifo.analysis_export);
    scb.output_0_0_port.connect(output_0_0_scb_fifo.blocking_get_export);

    agt_0_1.ap_in.connect(input_0_1_scb_fifo.analysis_export);
    scb.input_0_1_port.connect(input_0_1_scb_fifo.blocking_get_export);
    agt_0_1.ap_out.connect(output_0_1_scb_fifo.analysis_export);
    scb.output_0_1_port.connect(output_0_1_scb_fifo.blocking_get_export);

    agt_0_2.ap_in.connect(input_0_2_scb_fifo.analysis_export);
    scb.input_0_2_port.connect(input_0_2_scb_fifo.blocking_get_export);
    agt_0_2.ap_out.connect(output_0_2_scb_fifo.analysis_export);
    scb.output_0_2_port.connect(output_0_2_scb_fifo.blocking_get_export);

    agt_0_3.ap_in.connect(input_0_3_scb_fifo.analysis_export);
    scb.input_0_3_port.connect(input_0_3_scb_fifo.blocking_get_export);
    agt_0_3.ap_out.connect(output_0_3_scb_fifo.analysis_export);
    scb.output_0_3_port.connect(output_0_3_scb_fifo.blocking_get_export);

    agt_0_4.ap_in.connect(input_0_4_scb_fifo.analysis_export);
    scb.input_0_4_port.connect(input_0_4_scb_fifo.blocking_get_export);
    agt_0_4.ap_out.connect(output_0_4_scb_fifo.analysis_export);
    scb.output_0_4_port.connect(output_0_4_scb_fifo.blocking_get_export);

    agt_1_0.ap_in.connect(input_1_0_scb_fifo.analysis_export);
    scb.input_1_0_port.connect(input_1_0_scb_fifo.blocking_get_export);
    agt_1_0.ap_out.connect(output_1_0_scb_fifo.analysis_export);
    scb.output_1_0_port.connect(output_1_0_scb_fifo.blocking_get_export);

    agt_1_1.ap_in.connect(input_1_1_scb_fifo.analysis_export);
    scb.input_1_1_port.connect(input_1_1_scb_fifo.blocking_get_export);
    agt_1_1.ap_out.connect(output_1_1_scb_fifo.analysis_export);
    scb.output_1_1_port.connect(output_1_1_scb_fifo.blocking_get_export);

    agt_1_2.ap_in.connect(input_1_2_scb_fifo.analysis_export);
    scb.input_1_2_port.connect(input_1_2_scb_fifo.blocking_get_export);
    agt_1_2.ap_out.connect(output_1_2_scb_fifo.analysis_export);
    scb.output_1_2_port.connect(output_1_2_scb_fifo.blocking_get_export);

    agt_1_3.ap_in.connect(input_1_3_scb_fifo.analysis_export);
    scb.input_1_3_port.connect(input_1_3_scb_fifo.blocking_get_export);
    agt_1_3.ap_out.connect(output_1_3_scb_fifo.analysis_export);
    scb.output_1_3_port.connect(output_1_3_scb_fifo.blocking_get_export);

    agt_1_4.ap_in.connect(input_1_4_scb_fifo.analysis_export);
    scb.input_1_4_port.connect(input_1_4_scb_fifo.blocking_get_export);
    agt_1_4.ap_out.connect(output_1_4_scb_fifo.analysis_export);
    scb.output_1_4_port.connect(output_1_4_scb_fifo.blocking_get_export);

    agt_2_0.ap_in.connect(input_2_0_scb_fifo.analysis_export);
    scb.input_2_0_port.connect(input_2_0_scb_fifo.blocking_get_export);
    agt_2_0.ap_out.connect(output_2_0_scb_fifo.analysis_export);
    scb.output_2_0_port.connect(output_2_0_scb_fifo.blocking_get_export);

    agt_2_1.ap_in.connect(input_2_1_scb_fifo.analysis_export);
    scb.input_2_1_port.connect(input_2_1_scb_fifo.blocking_get_export);
    agt_2_1.ap_out.connect(output_2_1_scb_fifo.analysis_export);
    scb.output_2_1_port.connect(output_2_1_scb_fifo.blocking_get_export);

    agt_2_2.ap_in.connect(input_2_2_scb_fifo.analysis_export);
    scb.input_2_2_port.connect(input_2_2_scb_fifo.blocking_get_export);
    agt_2_2.ap_out.connect(output_2_2_scb_fifo.analysis_export);
    scb.output_2_2_port.connect(output_2_2_scb_fifo.blocking_get_export);

    agt_2_3.ap_in.connect(input_2_3_scb_fifo.analysis_export);
    scb.input_2_3_port.connect(input_2_3_scb_fifo.blocking_get_export);
    agt_2_3.ap_out.connect(output_2_3_scb_fifo.analysis_export);
    scb.output_2_3_port.connect(output_2_3_scb_fifo.blocking_get_export);

    agt_2_4.ap_in.connect(input_2_4_scb_fifo.analysis_export);
    scb.input_2_4_port.connect(input_2_4_scb_fifo.blocking_get_export);
    agt_2_4.ap_out.connect(output_2_4_scb_fifo.analysis_export);
    scb.output_2_4_port.connect(output_2_4_scb_fifo.blocking_get_export);

    agt_3_0.ap_in.connect(input_3_0_scb_fifo.analysis_export);
    scb.input_3_0_port.connect(input_3_0_scb_fifo.blocking_get_export);
    agt_3_0.ap_out.connect(output_3_0_scb_fifo.analysis_export);
    scb.output_3_0_port.connect(output_3_0_scb_fifo.blocking_get_export);

    agt_3_1.ap_in.connect(input_3_1_scb_fifo.analysis_export);
    scb.input_3_1_port.connect(input_3_1_scb_fifo.blocking_get_export);
    agt_3_1.ap_out.connect(output_3_1_scb_fifo.analysis_export);
    scb.output_3_1_port.connect(output_3_1_scb_fifo.blocking_get_export);

    agt_3_2.ap_in.connect(input_3_2_scb_fifo.analysis_export);
    scb.input_3_2_port.connect(input_3_2_scb_fifo.blocking_get_export);
    agt_3_2.ap_out.connect(output_3_2_scb_fifo.analysis_export);
    scb.output_3_2_port.connect(output_3_2_scb_fifo.blocking_get_export);

    agt_3_3.ap_in.connect(input_3_3_scb_fifo.analysis_export);
    scb.input_3_3_port.connect(input_3_3_scb_fifo.blocking_get_export);
    agt_3_3.ap_out.connect(output_3_3_scb_fifo.analysis_export);
    scb.output_3_3_port.connect(output_3_3_scb_fifo.blocking_get_export);

    agt_3_4.ap_in.connect(input_3_4_scb_fifo.analysis_export);
    scb.input_3_4_port.connect(input_3_4_scb_fifo.blocking_get_export);
    agt_3_4.ap_out.connect(output_3_4_scb_fifo.analysis_export);
    scb.output_3_4_port.connect(output_3_4_scb_fifo.blocking_get_export);

    agt_4_0.ap_in.connect(input_4_0_scb_fifo.analysis_export);
    scb.input_4_0_port.connect(input_4_0_scb_fifo.blocking_get_export);
    agt_4_0.ap_out.connect(output_4_0_scb_fifo.analysis_export);
    scb.output_4_0_port.connect(output_4_0_scb_fifo.blocking_get_export);

    agt_4_1.ap_in.connect(input_4_1_scb_fifo.analysis_export);
    scb.input_4_1_port.connect(input_4_1_scb_fifo.blocking_get_export);
    agt_4_1.ap_out.connect(output_4_1_scb_fifo.analysis_export);
    scb.output_4_1_port.connect(output_4_1_scb_fifo.blocking_get_export);

    agt_4_2.ap_in.connect(input_4_2_scb_fifo.analysis_export);
    scb.input_4_2_port.connect(input_4_2_scb_fifo.blocking_get_export);
    agt_4_2.ap_out.connect(output_4_2_scb_fifo.analysis_export);
    scb.output_4_2_port.connect(output_4_2_scb_fifo.blocking_get_export);

    agt_4_3.ap_in.connect(input_4_3_scb_fifo.analysis_export);
    scb.input_4_3_port.connect(input_4_3_scb_fifo.blocking_get_export);
    agt_4_3.ap_out.connect(output_4_3_scb_fifo.analysis_export);
    scb.output_4_3_port.connect(output_4_3_scb_fifo.blocking_get_export);

    agt_4_4.ap_in.connect(input_4_4_scb_fifo.analysis_export);
    scb.input_4_4_port.connect(input_4_4_scb_fifo.blocking_get_export);
    agt_4_4.ap_out.connect(output_4_4_scb_fifo.analysis_export);
    scb.output_4_4_port.connect(output_4_4_scb_fifo.blocking_get_export);

    vsqr.sqr_0_0 = agt_0_0.sqr;
    vsqr.sqr_0_1 = agt_0_1.sqr;
    vsqr.sqr_0_2 = agt_0_2.sqr;
    vsqr.sqr_0_3 = agt_0_3.sqr;
    vsqr.sqr_0_4 = agt_0_4.sqr;
    vsqr.sqr_1_0 = agt_1_0.sqr;
    vsqr.sqr_1_1 = agt_1_1.sqr;
    vsqr.sqr_1_2 = agt_1_2.sqr;
    vsqr.sqr_1_3 = agt_1_3.sqr;
    vsqr.sqr_1_4 = agt_1_4.sqr;
    vsqr.sqr_2_0 = agt_2_0.sqr;
    vsqr.sqr_2_1 = agt_2_1.sqr;
    vsqr.sqr_2_2 = agt_2_2.sqr;
    vsqr.sqr_2_3 = agt_2_3.sqr;
    vsqr.sqr_2_4 = agt_2_4.sqr;
    vsqr.sqr_3_0 = agt_3_0.sqr;
    vsqr.sqr_3_1 = agt_3_1.sqr;
    vsqr.sqr_3_2 = agt_3_2.sqr;
    vsqr.sqr_3_3 = agt_3_3.sqr;
    vsqr.sqr_3_4 = agt_3_4.sqr;
    vsqr.sqr_4_0 = agt_4_0.sqr;
    vsqr.sqr_4_1 = agt_4_1.sqr;
    vsqr.sqr_4_2 = agt_4_2.sqr;
    vsqr.sqr_4_3 = agt_4_3.sqr;
    vsqr.sqr_4_4 = agt_4_4.sqr;


    
endfunction

`endif
