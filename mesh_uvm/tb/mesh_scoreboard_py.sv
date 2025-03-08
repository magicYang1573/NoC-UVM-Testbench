`ifndef SOCREBOARD_ENV__SV
`define SOCREBOARD_ENV__SV
// UVM scoreboard for mesh noc
// collect packets and compare
<%
X_SIZE = 5
Y_SIZE = 5
router_queue = []
for i in range(0,X_SIZE):
  for j in range(0,Y_SIZE):
    router_this = str(i) + '_' + str(j)
    router_queue.append(router_this)
%>

class mesh_scoreboard extends uvm_scoreboard;
    
    <%
    for r in router_queue:
        print('')
        print("    uvm_blocking_get_port #(packet_transaction)  input_{}_port;".format(r))
        print("    uvm_blocking_get_port #(packet_transaction)  output_{}_port;".format(r))
    
    print('')
    for r in router_queue:
        print("    packet_transaction exp_q_{}[$];".format(r))
    %>

    // share vars of several forks, use lock to avoid conflict
    <%
    print('')
    for r in router_queue:
        print("    semaphore lock_q_{};".format(r))
    %>

    `uvm_component_utils(mesh_scoreboard)
 
    extern function new(string name, uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual function void final_phase(uvm_phase phase);

    extern task store_packet(int src_x, int src_y, packet_transaction tr);
    extern task check_packet(int out_x, int out_y, packet_transaction tr);
endclass 

function mesh_scoreboard::new(string name, uvm_component parent = null);
    super.new(name, parent);
endfunction 

function void mesh_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    <%
    for r in router_queue:
        print('')
        print("    input_{}_port = new(\"input_{}_port\", this);".format(r,r))
        print("    output_{}_port = new(\"output_{}_port\", this);".format(r,r))
        print("    lock_q_{} = new(1);".format(r))
    %>

endfunction

task mesh_scoreboard::main_phase(uvm_phase phase);
    <%
    print('')
    for r in router_queue:
        print("    packet_transaction input_{}_trans;".format(r))
        print("    packet_transaction output_{}_trans;".format(r))
    %>

    super.main_phase(phase);
    fork 
        <%
        print('')
        for i in range(0,X_SIZE):
            for j in range(0,Y_SIZE):
                r = str(i) + "_" + str(j)
                print("        while (1) begin")
                print("            input_{}_port.get(input_{}_trans);".format(r,r))
                print("            store_packet({}, {}, input_{}_trans);".format(i,j,r))
                print("        end")
        %>
        <%
        print('')
        for i in range(0,X_SIZE):
            for j in range(0,Y_SIZE):
                r = str(i) + "_" + str(j)
                print("        while (1) begin")
                print("            output_{}_port.get(output_{}_trans);".format(r,r))
                print("            check_packet({}, {}, output_{}_trans);".format(i,j,r))
                print("        end")
        %>

    join
endtask


function void mesh_scoreboard::final_phase(uvm_phase phase);
    super.final_phase(phase);
    <%
    print('')
    for r in router_queue:
        print("    if(exp_q_{}.size()!=0)".format(r))
        print("        `uvm_fatal(\"mesh_scoreboard\", \"Packet Drop!!\");")
    %>
endfunction


task mesh_scoreboard::store_packet(int src_x, int src_y, packet_transaction tr);
    int dst_x;
    int dst_y;
    dst_x = tr.dst_x;
    dst_y = tr.dst_y;

    <%
        print('')
        for i in range(0,X_SIZE):
            for j in range(0,Y_SIZE):
                print("    if(dst_x=={}&&dst_y=={}) begin".format(i,j))
                print("        lock_q_{}_{}.get(1);".format(i,j))
                print("        exp_q_{}_{}.push_back(tr);".format(i,j))
                print("        lock_q_{}_{}.put(1);".format(i,j))
                print("    end")
    %>
    $display("P[%1d, %1d] send a packet, expect to P[%1d, %1d], len %2d", src_x, src_y, dst_x, dst_y, tr.payload_len);
    // tr.print();
endtask

task mesh_scoreboard::check_packet(int out_x, int out_y, packet_transaction tr);
    packet_transaction exp_q[$];
    int correct_flag = 0;
    $display("P[%1d, %1d] receive a packet, len %2d", out_x, out_y, tr.payload_len);
    <%
    print('')
    for i in range(0,X_SIZE):
        for j in range(0,Y_SIZE):
            r = str(i) + "_" + str(j)
            print("    if(out_x=={}&&out_y=={}) begin".format(i,j))
            print("        lock_q_{}.get(1);".format(r))
            print("        exp_q = exp_q_{};".format(r))
            print("    end")
    %>
    
    for(int i=0;i<exp_q.size();i++) begin
        if(tr.compare(exp_q[i])) begin
            exp_q.delete(i);
            correct_flag = 1;
            break;
        end
    end

    <%
    print('')
    for i in range(0,X_SIZE):
        for j in range(0,Y_SIZE):
            r = str(i) + "_" + str(j)
            print("    if(out_x=={}&&out_y=={}) begin".format(i,j))
            print("        exp_q_{} = exp_q;".format(r))
            print("        lock_q_{}.put(1);".format(r))
            print("    end")
    %>

    if(correct_flag==1) return;

    $display("P[%1d,%1d] get wrong packet!!", out_x, out_y);
    //tr.print();
    `uvm_fatal("router_scoreboard", "Wrong Packet Got!!!")

endtask



`endif



