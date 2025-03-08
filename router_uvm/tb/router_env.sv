`ifndef MY_ENV__SV
`define MY_ENV__SV

// UVM env for one single router
class router_env extends uvm_env;

     demoter demoter_tmp;     //clean the log info

     router_agent agt_N;
     router_agent agt_S;
     router_agent agt_W;
     router_agent agt_E;
     router_agent agt_P;

     router_scoreboard scb;

     router_virtual_sequencer vsqr;

     uvm_tlm_analysis_fifo #(packet_transaction) input_N_scb_fifo;
     uvm_tlm_analysis_fifo #(packet_transaction) input_S_scb_fifo;
     uvm_tlm_analysis_fifo #(packet_transaction) input_W_scb_fifo;
     uvm_tlm_analysis_fifo #(packet_transaction) input_E_scb_fifo;
     uvm_tlm_analysis_fifo #(packet_transaction) input_P_scb_fifo;
     
     uvm_tlm_analysis_fifo #(packet_transaction) output_N_scb_fifo;
     uvm_tlm_analysis_fifo #(packet_transaction) output_S_scb_fifo;
     uvm_tlm_analysis_fifo #(packet_transaction) output_W_scb_fifo;
     uvm_tlm_analysis_fifo #(packet_transaction) output_E_scb_fifo;
     uvm_tlm_analysis_fifo #(packet_transaction) output_P_scb_fifo;

     
     function new(string name = "router_env", uvm_component parent);
          super.new(name, parent);
     endfunction


     `uvm_component_utils(router_env)

     extern virtual function void build_phase(uvm_phase phase);
     extern virtual function void connect_phase(uvm_phase phase);

endclass

function void router_env::build_phase(uvm_phase phase);
     super.build_phase(phase);

     demoter_tmp = new("d");       
     uvm_report_cb::add(null, demoter_tmp);  //set info

     agt_N = router_agent::type_id::create("agt_N", this);
     agt_N.router_in_buffer_size = `ROUTER_BUFFER_SIZE_ESWN;
     agt_S = router_agent::type_id::create("agt_S", this);
     agt_S.router_in_buffer_size = `ROUTER_BUFFER_SIZE_ESWN;
     agt_E = router_agent::type_id::create("agt_E", this);
     agt_E.router_in_buffer_size = `ROUTER_BUFFER_SIZE_ESWN;
     agt_W = router_agent::type_id::create("agt_W", this);
     agt_W.router_in_buffer_size = `ROUTER_BUFFER_SIZE_ESWN;
     agt_P = router_agent::type_id::create("agt_P", this);
     agt_P.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;
     
     scb = router_scoreboard::type_id::create("scb", this);
     
     vsqr = router_virtual_sequencer::type_id::create("router_virtual_sequencer",this);

     input_N_scb_fifo = new("input_N_scb_fifo",this);
     input_S_scb_fifo = new("input_S_scb_fifo",this);
     input_W_scb_fifo = new("input_W_scb_fifo",this);
     input_E_scb_fifo = new("input_E_scb_fifo",this);
     input_P_scb_fifo = new("input_P_scb_fifo",this);

     output_S_scb_fifo = new("output_S_scb_fifo",this);
     output_N_scb_fifo = new("output_N_scb_fifo",this);
     output_W_scb_fifo = new("output_W_scb_fifo",this);
     output_E_scb_fifo = new("output_E_scb_fifo",this);
     output_P_scb_fifo = new("output_P_scb_fifo",this);

endfunction

function void router_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    agt_N.ap_in.connect(input_N_scb_fifo.analysis_export);
    scb.input_N_port.connect(input_N_scb_fifo.blocking_get_export);
    agt_S.ap_in.connect(input_S_scb_fifo.analysis_export);
    scb.input_S_port.connect(input_S_scb_fifo.blocking_get_export);
    agt_W.ap_in.connect(input_W_scb_fifo.analysis_export);
    scb.input_W_port.connect(input_W_scb_fifo.blocking_get_export);
    agt_E.ap_in.connect(input_E_scb_fifo.analysis_export);
    scb.input_E_port.connect(input_E_scb_fifo.blocking_get_export);
    agt_P.ap_in.connect(input_P_scb_fifo.analysis_export);
    scb.input_P_port.connect(input_P_scb_fifo.blocking_get_export);

    agt_N.ap_out.connect(output_N_scb_fifo.analysis_export);
    scb.output_N_port.connect(output_N_scb_fifo.blocking_get_export);
    agt_S.ap_out.connect(output_S_scb_fifo.analysis_export);
    scb.output_S_port.connect(output_S_scb_fifo.blocking_get_export);
    agt_W.ap_out.connect(output_W_scb_fifo.analysis_export);
    scb.output_W_port.connect(output_W_scb_fifo.blocking_get_export);
    agt_E.ap_out.connect(output_E_scb_fifo.analysis_export);
    scb.output_E_port.connect(output_E_scb_fifo.blocking_get_export);
    agt_P.ap_out.connect(output_P_scb_fifo.analysis_export);
    scb.output_P_port.connect(output_P_scb_fifo.blocking_get_export);

    vsqr.sqr_N = agt_N.sqr;
    vsqr.sqr_E = agt_E.sqr;
    vsqr.sqr_S = agt_S.sqr;
    vsqr.sqr_W = agt_W.sqr;
    vsqr.sqr_P = agt_P.sqr;
    
endfunction

`endif
