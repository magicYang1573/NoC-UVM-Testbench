`ifndef MESH_ENV__SV
`define MESH_ENV__SV
<%
     X_SIZE = 5
     Y_SIZE = 5
     router_queue = []
     for i in range(0,X_SIZE):
          for j in range(0,Y_SIZE):
               router_this = str(i) + '_' + str(j)
               router_queue.append(router_this)
%>
// UVM env for N*M mesh
class mesh_env extends uvm_env;

     demoter demoter_tmp;     //clean the log info
     
     //declare agent for every router
     <%
     print('')
     for r in router_queue:
          print("    router_agent agt_{};".format(r))
     %>

     mesh_scoreboard scb;

     mesh_virtual_sequencer vsqr;

     // connect every local port to scoreboard
     <%
     print('')
     for r in router_queue:
          print("    uvm_tlm_analysis_fifo #(packet_transaction) input_{}_scb_fifo;".format(r))
          print("    uvm_tlm_analysis_fifo #(packet_transaction) output_{}_scb_fifo;".format(r))
          print('')
     %>
     
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
     <%
     print('')
     for r in router_queue:
          print("    agt_{} = router_agent::type_id::create(\"agt_{}\", this);".format(r, r))
          print("    agt_{}.router_in_buffer_size = `ROUTER_BUFFER_SIZE_P;".format(r))
     %>
     
     scb = mesh_scoreboard::type_id::create("scb", this);
     
     vsqr = mesh_virtual_sequencer::type_id::create("mesh_virtual_sequencer",this);

     <%
     print('')
     for r in router_queue:
          print("    input_{}_scb_fifo = new(\"input_{}_scb_fifo\",this);".format(r,r))
     print('')
     for r in router_queue:
          print("    output_{}_scb_fifo = new(\"output_{}_scb_fifo\",this);".format(r,r))
     %>
     

endfunction

function void mesh_env::connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     <%
     for r in router_queue:
          print('')
          print("    agt_{}.ap_in.connect(input_{}_scb_fifo.analysis_export);".format(r,r))
          print("    scb.input_{}_port.connect(input_{}_scb_fifo.blocking_get_export);".format(r,r))
          print("    agt_{}.ap_out.connect(output_{}_scb_fifo.analysis_export);".format(r,r))
          print("    scb.output_{}_port.connect(output_{}_scb_fifo.blocking_get_export);".format(r,r))

     print('')
     for r in router_queue:
          print("    vsqr.sqr_{} = agt_{}.sqr;".format(r,r))
     %>

    
endfunction

`endif
