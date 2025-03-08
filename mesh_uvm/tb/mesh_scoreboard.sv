`ifndef SOCREBOARD_ENV__SV
`define SOCREBOARD_ENV__SV
// UVM scoreboard for mesh noc
// collect packets and compare


class mesh_scoreboard extends uvm_scoreboard;
    
    
    uvm_blocking_get_port #(packet_transaction)  input_0_0_port;
    uvm_blocking_get_port #(packet_transaction)  output_0_0_port;

    uvm_blocking_get_port #(packet_transaction)  input_0_1_port;
    uvm_blocking_get_port #(packet_transaction)  output_0_1_port;

    uvm_blocking_get_port #(packet_transaction)  input_0_2_port;
    uvm_blocking_get_port #(packet_transaction)  output_0_2_port;

    uvm_blocking_get_port #(packet_transaction)  input_0_3_port;
    uvm_blocking_get_port #(packet_transaction)  output_0_3_port;

    uvm_blocking_get_port #(packet_transaction)  input_0_4_port;
    uvm_blocking_get_port #(packet_transaction)  output_0_4_port;

    uvm_blocking_get_port #(packet_transaction)  input_1_0_port;
    uvm_blocking_get_port #(packet_transaction)  output_1_0_port;

    uvm_blocking_get_port #(packet_transaction)  input_1_1_port;
    uvm_blocking_get_port #(packet_transaction)  output_1_1_port;

    uvm_blocking_get_port #(packet_transaction)  input_1_2_port;
    uvm_blocking_get_port #(packet_transaction)  output_1_2_port;

    uvm_blocking_get_port #(packet_transaction)  input_1_3_port;
    uvm_blocking_get_port #(packet_transaction)  output_1_3_port;

    uvm_blocking_get_port #(packet_transaction)  input_1_4_port;
    uvm_blocking_get_port #(packet_transaction)  output_1_4_port;

    uvm_blocking_get_port #(packet_transaction)  input_2_0_port;
    uvm_blocking_get_port #(packet_transaction)  output_2_0_port;

    uvm_blocking_get_port #(packet_transaction)  input_2_1_port;
    uvm_blocking_get_port #(packet_transaction)  output_2_1_port;

    uvm_blocking_get_port #(packet_transaction)  input_2_2_port;
    uvm_blocking_get_port #(packet_transaction)  output_2_2_port;

    uvm_blocking_get_port #(packet_transaction)  input_2_3_port;
    uvm_blocking_get_port #(packet_transaction)  output_2_3_port;

    uvm_blocking_get_port #(packet_transaction)  input_2_4_port;
    uvm_blocking_get_port #(packet_transaction)  output_2_4_port;

    uvm_blocking_get_port #(packet_transaction)  input_3_0_port;
    uvm_blocking_get_port #(packet_transaction)  output_3_0_port;

    uvm_blocking_get_port #(packet_transaction)  input_3_1_port;
    uvm_blocking_get_port #(packet_transaction)  output_3_1_port;

    uvm_blocking_get_port #(packet_transaction)  input_3_2_port;
    uvm_blocking_get_port #(packet_transaction)  output_3_2_port;

    uvm_blocking_get_port #(packet_transaction)  input_3_3_port;
    uvm_blocking_get_port #(packet_transaction)  output_3_3_port;

    uvm_blocking_get_port #(packet_transaction)  input_3_4_port;
    uvm_blocking_get_port #(packet_transaction)  output_3_4_port;

    uvm_blocking_get_port #(packet_transaction)  input_4_0_port;
    uvm_blocking_get_port #(packet_transaction)  output_4_0_port;

    uvm_blocking_get_port #(packet_transaction)  input_4_1_port;
    uvm_blocking_get_port #(packet_transaction)  output_4_1_port;

    uvm_blocking_get_port #(packet_transaction)  input_4_2_port;
    uvm_blocking_get_port #(packet_transaction)  output_4_2_port;

    uvm_blocking_get_port #(packet_transaction)  input_4_3_port;
    uvm_blocking_get_port #(packet_transaction)  output_4_3_port;

    uvm_blocking_get_port #(packet_transaction)  input_4_4_port;
    uvm_blocking_get_port #(packet_transaction)  output_4_4_port;

    packet_transaction exp_q_0_0[$];
    packet_transaction exp_q_0_1[$];
    packet_transaction exp_q_0_2[$];
    packet_transaction exp_q_0_3[$];
    packet_transaction exp_q_0_4[$];
    packet_transaction exp_q_1_0[$];
    packet_transaction exp_q_1_1[$];
    packet_transaction exp_q_1_2[$];
    packet_transaction exp_q_1_3[$];
    packet_transaction exp_q_1_4[$];
    packet_transaction exp_q_2_0[$];
    packet_transaction exp_q_2_1[$];
    packet_transaction exp_q_2_2[$];
    packet_transaction exp_q_2_3[$];
    packet_transaction exp_q_2_4[$];
    packet_transaction exp_q_3_0[$];
    packet_transaction exp_q_3_1[$];
    packet_transaction exp_q_3_2[$];
    packet_transaction exp_q_3_3[$];
    packet_transaction exp_q_3_4[$];
    packet_transaction exp_q_4_0[$];
    packet_transaction exp_q_4_1[$];
    packet_transaction exp_q_4_2[$];
    packet_transaction exp_q_4_3[$];
    packet_transaction exp_q_4_4[$];


    // share vars of several forks, use lock to avoid conflict
    
    semaphore lock_q_0_0;
    semaphore lock_q_0_1;
    semaphore lock_q_0_2;
    semaphore lock_q_0_3;
    semaphore lock_q_0_4;
    semaphore lock_q_1_0;
    semaphore lock_q_1_1;
    semaphore lock_q_1_2;
    semaphore lock_q_1_3;
    semaphore lock_q_1_4;
    semaphore lock_q_2_0;
    semaphore lock_q_2_1;
    semaphore lock_q_2_2;
    semaphore lock_q_2_3;
    semaphore lock_q_2_4;
    semaphore lock_q_3_0;
    semaphore lock_q_3_1;
    semaphore lock_q_3_2;
    semaphore lock_q_3_3;
    semaphore lock_q_3_4;
    semaphore lock_q_4_0;
    semaphore lock_q_4_1;
    semaphore lock_q_4_2;
    semaphore lock_q_4_3;
    semaphore lock_q_4_4;


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
    
    input_0_0_port = new("input_0_0_port", this);
    output_0_0_port = new("output_0_0_port", this);
    lock_q_0_0 = new(1);

    input_0_1_port = new("input_0_1_port", this);
    output_0_1_port = new("output_0_1_port", this);
    lock_q_0_1 = new(1);

    input_0_2_port = new("input_0_2_port", this);
    output_0_2_port = new("output_0_2_port", this);
    lock_q_0_2 = new(1);

    input_0_3_port = new("input_0_3_port", this);
    output_0_3_port = new("output_0_3_port", this);
    lock_q_0_3 = new(1);

    input_0_4_port = new("input_0_4_port", this);
    output_0_4_port = new("output_0_4_port", this);
    lock_q_0_4 = new(1);

    input_1_0_port = new("input_1_0_port", this);
    output_1_0_port = new("output_1_0_port", this);
    lock_q_1_0 = new(1);

    input_1_1_port = new("input_1_1_port", this);
    output_1_1_port = new("output_1_1_port", this);
    lock_q_1_1 = new(1);

    input_1_2_port = new("input_1_2_port", this);
    output_1_2_port = new("output_1_2_port", this);
    lock_q_1_2 = new(1);

    input_1_3_port = new("input_1_3_port", this);
    output_1_3_port = new("output_1_3_port", this);
    lock_q_1_3 = new(1);

    input_1_4_port = new("input_1_4_port", this);
    output_1_4_port = new("output_1_4_port", this);
    lock_q_1_4 = new(1);

    input_2_0_port = new("input_2_0_port", this);
    output_2_0_port = new("output_2_0_port", this);
    lock_q_2_0 = new(1);

    input_2_1_port = new("input_2_1_port", this);
    output_2_1_port = new("output_2_1_port", this);
    lock_q_2_1 = new(1);

    input_2_2_port = new("input_2_2_port", this);
    output_2_2_port = new("output_2_2_port", this);
    lock_q_2_2 = new(1);

    input_2_3_port = new("input_2_3_port", this);
    output_2_3_port = new("output_2_3_port", this);
    lock_q_2_3 = new(1);

    input_2_4_port = new("input_2_4_port", this);
    output_2_4_port = new("output_2_4_port", this);
    lock_q_2_4 = new(1);

    input_3_0_port = new("input_3_0_port", this);
    output_3_0_port = new("output_3_0_port", this);
    lock_q_3_0 = new(1);

    input_3_1_port = new("input_3_1_port", this);
    output_3_1_port = new("output_3_1_port", this);
    lock_q_3_1 = new(1);

    input_3_2_port = new("input_3_2_port", this);
    output_3_2_port = new("output_3_2_port", this);
    lock_q_3_2 = new(1);

    input_3_3_port = new("input_3_3_port", this);
    output_3_3_port = new("output_3_3_port", this);
    lock_q_3_3 = new(1);

    input_3_4_port = new("input_3_4_port", this);
    output_3_4_port = new("output_3_4_port", this);
    lock_q_3_4 = new(1);

    input_4_0_port = new("input_4_0_port", this);
    output_4_0_port = new("output_4_0_port", this);
    lock_q_4_0 = new(1);

    input_4_1_port = new("input_4_1_port", this);
    output_4_1_port = new("output_4_1_port", this);
    lock_q_4_1 = new(1);

    input_4_2_port = new("input_4_2_port", this);
    output_4_2_port = new("output_4_2_port", this);
    lock_q_4_2 = new(1);

    input_4_3_port = new("input_4_3_port", this);
    output_4_3_port = new("output_4_3_port", this);
    lock_q_4_3 = new(1);

    input_4_4_port = new("input_4_4_port", this);
    output_4_4_port = new("output_4_4_port", this);
    lock_q_4_4 = new(1);


endfunction

task mesh_scoreboard::main_phase(uvm_phase phase);
    
    packet_transaction input_0_0_trans;
    packet_transaction output_0_0_trans;
    packet_transaction input_0_1_trans;
    packet_transaction output_0_1_trans;
    packet_transaction input_0_2_trans;
    packet_transaction output_0_2_trans;
    packet_transaction input_0_3_trans;
    packet_transaction output_0_3_trans;
    packet_transaction input_0_4_trans;
    packet_transaction output_0_4_trans;
    packet_transaction input_1_0_trans;
    packet_transaction output_1_0_trans;
    packet_transaction input_1_1_trans;
    packet_transaction output_1_1_trans;
    packet_transaction input_1_2_trans;
    packet_transaction output_1_2_trans;
    packet_transaction input_1_3_trans;
    packet_transaction output_1_3_trans;
    packet_transaction input_1_4_trans;
    packet_transaction output_1_4_trans;
    packet_transaction input_2_0_trans;
    packet_transaction output_2_0_trans;
    packet_transaction input_2_1_trans;
    packet_transaction output_2_1_trans;
    packet_transaction input_2_2_trans;
    packet_transaction output_2_2_trans;
    packet_transaction input_2_3_trans;
    packet_transaction output_2_3_trans;
    packet_transaction input_2_4_trans;
    packet_transaction output_2_4_trans;
    packet_transaction input_3_0_trans;
    packet_transaction output_3_0_trans;
    packet_transaction input_3_1_trans;
    packet_transaction output_3_1_trans;
    packet_transaction input_3_2_trans;
    packet_transaction output_3_2_trans;
    packet_transaction input_3_3_trans;
    packet_transaction output_3_3_trans;
    packet_transaction input_3_4_trans;
    packet_transaction output_3_4_trans;
    packet_transaction input_4_0_trans;
    packet_transaction output_4_0_trans;
    packet_transaction input_4_1_trans;
    packet_transaction output_4_1_trans;
    packet_transaction input_4_2_trans;
    packet_transaction output_4_2_trans;
    packet_transaction input_4_3_trans;
    packet_transaction output_4_3_trans;
    packet_transaction input_4_4_trans;
    packet_transaction output_4_4_trans;


    super.main_phase(phase);
    fork 
        
        while (1) begin
            input_0_0_port.get(input_0_0_trans);
            store_packet(0, 0, input_0_0_trans);
        end
        while (1) begin
            input_0_1_port.get(input_0_1_trans);
            store_packet(0, 1, input_0_1_trans);
        end
        while (1) begin
            input_0_2_port.get(input_0_2_trans);
            store_packet(0, 2, input_0_2_trans);
        end
        while (1) begin
            input_0_3_port.get(input_0_3_trans);
            store_packet(0, 3, input_0_3_trans);
        end
        while (1) begin
            input_0_4_port.get(input_0_4_trans);
            store_packet(0, 4, input_0_4_trans);
        end
        while (1) begin
            input_1_0_port.get(input_1_0_trans);
            store_packet(1, 0, input_1_0_trans);
        end
        while (1) begin
            input_1_1_port.get(input_1_1_trans);
            store_packet(1, 1, input_1_1_trans);
        end
        while (1) begin
            input_1_2_port.get(input_1_2_trans);
            store_packet(1, 2, input_1_2_trans);
        end
        while (1) begin
            input_1_3_port.get(input_1_3_trans);
            store_packet(1, 3, input_1_3_trans);
        end
        while (1) begin
            input_1_4_port.get(input_1_4_trans);
            store_packet(1, 4, input_1_4_trans);
        end
        while (1) begin
            input_2_0_port.get(input_2_0_trans);
            store_packet(2, 0, input_2_0_trans);
        end
        while (1) begin
            input_2_1_port.get(input_2_1_trans);
            store_packet(2, 1, input_2_1_trans);
        end
        while (1) begin
            input_2_2_port.get(input_2_2_trans);
            store_packet(2, 2, input_2_2_trans);
        end
        while (1) begin
            input_2_3_port.get(input_2_3_trans);
            store_packet(2, 3, input_2_3_trans);
        end
        while (1) begin
            input_2_4_port.get(input_2_4_trans);
            store_packet(2, 4, input_2_4_trans);
        end
        while (1) begin
            input_3_0_port.get(input_3_0_trans);
            store_packet(3, 0, input_3_0_trans);
        end
        while (1) begin
            input_3_1_port.get(input_3_1_trans);
            store_packet(3, 1, input_3_1_trans);
        end
        while (1) begin
            input_3_2_port.get(input_3_2_trans);
            store_packet(3, 2, input_3_2_trans);
        end
        while (1) begin
            input_3_3_port.get(input_3_3_trans);
            store_packet(3, 3, input_3_3_trans);
        end
        while (1) begin
            input_3_4_port.get(input_3_4_trans);
            store_packet(3, 4, input_3_4_trans);
        end
        while (1) begin
            input_4_0_port.get(input_4_0_trans);
            store_packet(4, 0, input_4_0_trans);
        end
        while (1) begin
            input_4_1_port.get(input_4_1_trans);
            store_packet(4, 1, input_4_1_trans);
        end
        while (1) begin
            input_4_2_port.get(input_4_2_trans);
            store_packet(4, 2, input_4_2_trans);
        end
        while (1) begin
            input_4_3_port.get(input_4_3_trans);
            store_packet(4, 3, input_4_3_trans);
        end
        while (1) begin
            input_4_4_port.get(input_4_4_trans);
            store_packet(4, 4, input_4_4_trans);
        end

        
        while (1) begin
            output_0_0_port.get(output_0_0_trans);
            check_packet(0, 0, output_0_0_trans);
        end
        while (1) begin
            output_0_1_port.get(output_0_1_trans);
            check_packet(0, 1, output_0_1_trans);
        end
        while (1) begin
            output_0_2_port.get(output_0_2_trans);
            check_packet(0, 2, output_0_2_trans);
        end
        while (1) begin
            output_0_3_port.get(output_0_3_trans);
            check_packet(0, 3, output_0_3_trans);
        end
        while (1) begin
            output_0_4_port.get(output_0_4_trans);
            check_packet(0, 4, output_0_4_trans);
        end
        while (1) begin
            output_1_0_port.get(output_1_0_trans);
            check_packet(1, 0, output_1_0_trans);
        end
        while (1) begin
            output_1_1_port.get(output_1_1_trans);
            check_packet(1, 1, output_1_1_trans);
        end
        while (1) begin
            output_1_2_port.get(output_1_2_trans);
            check_packet(1, 2, output_1_2_trans);
        end
        while (1) begin
            output_1_3_port.get(output_1_3_trans);
            check_packet(1, 3, output_1_3_trans);
        end
        while (1) begin
            output_1_4_port.get(output_1_4_trans);
            check_packet(1, 4, output_1_4_trans);
        end
        while (1) begin
            output_2_0_port.get(output_2_0_trans);
            check_packet(2, 0, output_2_0_trans);
        end
        while (1) begin
            output_2_1_port.get(output_2_1_trans);
            check_packet(2, 1, output_2_1_trans);
        end
        while (1) begin
            output_2_2_port.get(output_2_2_trans);
            check_packet(2, 2, output_2_2_trans);
        end
        while (1) begin
            output_2_3_port.get(output_2_3_trans);
            check_packet(2, 3, output_2_3_trans);
        end
        while (1) begin
            output_2_4_port.get(output_2_4_trans);
            check_packet(2, 4, output_2_4_trans);
        end
        while (1) begin
            output_3_0_port.get(output_3_0_trans);
            check_packet(3, 0, output_3_0_trans);
        end
        while (1) begin
            output_3_1_port.get(output_3_1_trans);
            check_packet(3, 1, output_3_1_trans);
        end
        while (1) begin
            output_3_2_port.get(output_3_2_trans);
            check_packet(3, 2, output_3_2_trans);
        end
        while (1) begin
            output_3_3_port.get(output_3_3_trans);
            check_packet(3, 3, output_3_3_trans);
        end
        while (1) begin
            output_3_4_port.get(output_3_4_trans);
            check_packet(3, 4, output_3_4_trans);
        end
        while (1) begin
            output_4_0_port.get(output_4_0_trans);
            check_packet(4, 0, output_4_0_trans);
        end
        while (1) begin
            output_4_1_port.get(output_4_1_trans);
            check_packet(4, 1, output_4_1_trans);
        end
        while (1) begin
            output_4_2_port.get(output_4_2_trans);
            check_packet(4, 2, output_4_2_trans);
        end
        while (1) begin
            output_4_3_port.get(output_4_3_trans);
            check_packet(4, 3, output_4_3_trans);
        end
        while (1) begin
            output_4_4_port.get(output_4_4_trans);
            check_packet(4, 4, output_4_4_trans);
        end


    join
endtask


function void mesh_scoreboard::final_phase(uvm_phase phase);
    super.final_phase(phase);
    
    if(exp_q_0_0.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_0_1.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_0_2.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_0_3.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_0_4.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_1_0.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_1_1.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_1_2.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_1_3.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_1_4.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_2_0.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_2_1.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_2_2.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_2_3.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_2_4.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_3_0.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_3_1.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_3_2.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_3_3.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_3_4.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_4_0.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_4_1.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_4_2.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_4_3.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");
    if(exp_q_4_4.size()!=0)
        `uvm_fatal("mesh_scoreboard", "Packet Drop!!");

endfunction


task mesh_scoreboard::store_packet(int src_x, int src_y, packet_transaction tr);
    int dst_x;
    int dst_y;
    dst_x = tr.dst_x;
    dst_y = tr.dst_y;

    
    if(dst_x==0&&dst_y==0) begin
        lock_q_0_0.get(1);
        exp_q_0_0.push_back(tr);
        lock_q_0_0.put(1);
    end
    if(dst_x==0&&dst_y==1) begin
        lock_q_0_1.get(1);
        exp_q_0_1.push_back(tr);
        lock_q_0_1.put(1);
    end
    if(dst_x==0&&dst_y==2) begin
        lock_q_0_2.get(1);
        exp_q_0_2.push_back(tr);
        lock_q_0_2.put(1);
    end
    if(dst_x==0&&dst_y==3) begin
        lock_q_0_3.get(1);
        exp_q_0_3.push_back(tr);
        lock_q_0_3.put(1);
    end
    if(dst_x==0&&dst_y==4) begin
        lock_q_0_4.get(1);
        exp_q_0_4.push_back(tr);
        lock_q_0_4.put(1);
    end
    if(dst_x==1&&dst_y==0) begin
        lock_q_1_0.get(1);
        exp_q_1_0.push_back(tr);
        lock_q_1_0.put(1);
    end
    if(dst_x==1&&dst_y==1) begin
        lock_q_1_1.get(1);
        exp_q_1_1.push_back(tr);
        lock_q_1_1.put(1);
    end
    if(dst_x==1&&dst_y==2) begin
        lock_q_1_2.get(1);
        exp_q_1_2.push_back(tr);
        lock_q_1_2.put(1);
    end
    if(dst_x==1&&dst_y==3) begin
        lock_q_1_3.get(1);
        exp_q_1_3.push_back(tr);
        lock_q_1_3.put(1);
    end
    if(dst_x==1&&dst_y==4) begin
        lock_q_1_4.get(1);
        exp_q_1_4.push_back(tr);
        lock_q_1_4.put(1);
    end
    if(dst_x==2&&dst_y==0) begin
        lock_q_2_0.get(1);
        exp_q_2_0.push_back(tr);
        lock_q_2_0.put(1);
    end
    if(dst_x==2&&dst_y==1) begin
        lock_q_2_1.get(1);
        exp_q_2_1.push_back(tr);
        lock_q_2_1.put(1);
    end
    if(dst_x==2&&dst_y==2) begin
        lock_q_2_2.get(1);
        exp_q_2_2.push_back(tr);
        lock_q_2_2.put(1);
    end
    if(dst_x==2&&dst_y==3) begin
        lock_q_2_3.get(1);
        exp_q_2_3.push_back(tr);
        lock_q_2_3.put(1);
    end
    if(dst_x==2&&dst_y==4) begin
        lock_q_2_4.get(1);
        exp_q_2_4.push_back(tr);
        lock_q_2_4.put(1);
    end
    if(dst_x==3&&dst_y==0) begin
        lock_q_3_0.get(1);
        exp_q_3_0.push_back(tr);
        lock_q_3_0.put(1);
    end
    if(dst_x==3&&dst_y==1) begin
        lock_q_3_1.get(1);
        exp_q_3_1.push_back(tr);
        lock_q_3_1.put(1);
    end
    if(dst_x==3&&dst_y==2) begin
        lock_q_3_2.get(1);
        exp_q_3_2.push_back(tr);
        lock_q_3_2.put(1);
    end
    if(dst_x==3&&dst_y==3) begin
        lock_q_3_3.get(1);
        exp_q_3_3.push_back(tr);
        lock_q_3_3.put(1);
    end
    if(dst_x==3&&dst_y==4) begin
        lock_q_3_4.get(1);
        exp_q_3_4.push_back(tr);
        lock_q_3_4.put(1);
    end
    if(dst_x==4&&dst_y==0) begin
        lock_q_4_0.get(1);
        exp_q_4_0.push_back(tr);
        lock_q_4_0.put(1);
    end
    if(dst_x==4&&dst_y==1) begin
        lock_q_4_1.get(1);
        exp_q_4_1.push_back(tr);
        lock_q_4_1.put(1);
    end
    if(dst_x==4&&dst_y==2) begin
        lock_q_4_2.get(1);
        exp_q_4_2.push_back(tr);
        lock_q_4_2.put(1);
    end
    if(dst_x==4&&dst_y==3) begin
        lock_q_4_3.get(1);
        exp_q_4_3.push_back(tr);
        lock_q_4_3.put(1);
    end
    if(dst_x==4&&dst_y==4) begin
        lock_q_4_4.get(1);
        exp_q_4_4.push_back(tr);
        lock_q_4_4.put(1);
    end

    $display("P[%1d, %1d] send a packet, expect to P[%1d, %1d], len %2d", src_x, src_y, dst_x, dst_y, tr.payload_len);
    // tr.print();
endtask

task mesh_scoreboard::check_packet(int out_x, int out_y, packet_transaction tr);
    packet_transaction exp_q[$];
    int correct_flag = 0;
    $display("P[%1d, %1d] receive a packet, len %2d", out_x, out_y, tr.payload_len);
    
    if(out_x==0&&out_y==0) begin
        lock_q_0_0.get(1);
        exp_q = exp_q_0_0;
    end
    if(out_x==0&&out_y==1) begin
        lock_q_0_1.get(1);
        exp_q = exp_q_0_1;
    end
    if(out_x==0&&out_y==2) begin
        lock_q_0_2.get(1);
        exp_q = exp_q_0_2;
    end
    if(out_x==0&&out_y==3) begin
        lock_q_0_3.get(1);
        exp_q = exp_q_0_3;
    end
    if(out_x==0&&out_y==4) begin
        lock_q_0_4.get(1);
        exp_q = exp_q_0_4;
    end
    if(out_x==1&&out_y==0) begin
        lock_q_1_0.get(1);
        exp_q = exp_q_1_0;
    end
    if(out_x==1&&out_y==1) begin
        lock_q_1_1.get(1);
        exp_q = exp_q_1_1;
    end
    if(out_x==1&&out_y==2) begin
        lock_q_1_2.get(1);
        exp_q = exp_q_1_2;
    end
    if(out_x==1&&out_y==3) begin
        lock_q_1_3.get(1);
        exp_q = exp_q_1_3;
    end
    if(out_x==1&&out_y==4) begin
        lock_q_1_4.get(1);
        exp_q = exp_q_1_4;
    end
    if(out_x==2&&out_y==0) begin
        lock_q_2_0.get(1);
        exp_q = exp_q_2_0;
    end
    if(out_x==2&&out_y==1) begin
        lock_q_2_1.get(1);
        exp_q = exp_q_2_1;
    end
    if(out_x==2&&out_y==2) begin
        lock_q_2_2.get(1);
        exp_q = exp_q_2_2;
    end
    if(out_x==2&&out_y==3) begin
        lock_q_2_3.get(1);
        exp_q = exp_q_2_3;
    end
    if(out_x==2&&out_y==4) begin
        lock_q_2_4.get(1);
        exp_q = exp_q_2_4;
    end
    if(out_x==3&&out_y==0) begin
        lock_q_3_0.get(1);
        exp_q = exp_q_3_0;
    end
    if(out_x==3&&out_y==1) begin
        lock_q_3_1.get(1);
        exp_q = exp_q_3_1;
    end
    if(out_x==3&&out_y==2) begin
        lock_q_3_2.get(1);
        exp_q = exp_q_3_2;
    end
    if(out_x==3&&out_y==3) begin
        lock_q_3_3.get(1);
        exp_q = exp_q_3_3;
    end
    if(out_x==3&&out_y==4) begin
        lock_q_3_4.get(1);
        exp_q = exp_q_3_4;
    end
    if(out_x==4&&out_y==0) begin
        lock_q_4_0.get(1);
        exp_q = exp_q_4_0;
    end
    if(out_x==4&&out_y==1) begin
        lock_q_4_1.get(1);
        exp_q = exp_q_4_1;
    end
    if(out_x==4&&out_y==2) begin
        lock_q_4_2.get(1);
        exp_q = exp_q_4_2;
    end
    if(out_x==4&&out_y==3) begin
        lock_q_4_3.get(1);
        exp_q = exp_q_4_3;
    end
    if(out_x==4&&out_y==4) begin
        lock_q_4_4.get(1);
        exp_q = exp_q_4_4;
    end

    
    for(int i=0;i<exp_q.size();i++) begin
        if(tr.compare(exp_q[i])) begin
            exp_q.delete(i);
            correct_flag = 1;
            break;
        end
    end

    
    if(out_x==0&&out_y==0) begin
        exp_q_0_0 = exp_q;
        lock_q_0_0.put(1);
    end
    if(out_x==0&&out_y==1) begin
        exp_q_0_1 = exp_q;
        lock_q_0_1.put(1);
    end
    if(out_x==0&&out_y==2) begin
        exp_q_0_2 = exp_q;
        lock_q_0_2.put(1);
    end
    if(out_x==0&&out_y==3) begin
        exp_q_0_3 = exp_q;
        lock_q_0_3.put(1);
    end
    if(out_x==0&&out_y==4) begin
        exp_q_0_4 = exp_q;
        lock_q_0_4.put(1);
    end
    if(out_x==1&&out_y==0) begin
        exp_q_1_0 = exp_q;
        lock_q_1_0.put(1);
    end
    if(out_x==1&&out_y==1) begin
        exp_q_1_1 = exp_q;
        lock_q_1_1.put(1);
    end
    if(out_x==1&&out_y==2) begin
        exp_q_1_2 = exp_q;
        lock_q_1_2.put(1);
    end
    if(out_x==1&&out_y==3) begin
        exp_q_1_3 = exp_q;
        lock_q_1_3.put(1);
    end
    if(out_x==1&&out_y==4) begin
        exp_q_1_4 = exp_q;
        lock_q_1_4.put(1);
    end
    if(out_x==2&&out_y==0) begin
        exp_q_2_0 = exp_q;
        lock_q_2_0.put(1);
    end
    if(out_x==2&&out_y==1) begin
        exp_q_2_1 = exp_q;
        lock_q_2_1.put(1);
    end
    if(out_x==2&&out_y==2) begin
        exp_q_2_2 = exp_q;
        lock_q_2_2.put(1);
    end
    if(out_x==2&&out_y==3) begin
        exp_q_2_3 = exp_q;
        lock_q_2_3.put(1);
    end
    if(out_x==2&&out_y==4) begin
        exp_q_2_4 = exp_q;
        lock_q_2_4.put(1);
    end
    if(out_x==3&&out_y==0) begin
        exp_q_3_0 = exp_q;
        lock_q_3_0.put(1);
    end
    if(out_x==3&&out_y==1) begin
        exp_q_3_1 = exp_q;
        lock_q_3_1.put(1);
    end
    if(out_x==3&&out_y==2) begin
        exp_q_3_2 = exp_q;
        lock_q_3_2.put(1);
    end
    if(out_x==3&&out_y==3) begin
        exp_q_3_3 = exp_q;
        lock_q_3_3.put(1);
    end
    if(out_x==3&&out_y==4) begin
        exp_q_3_4 = exp_q;
        lock_q_3_4.put(1);
    end
    if(out_x==4&&out_y==0) begin
        exp_q_4_0 = exp_q;
        lock_q_4_0.put(1);
    end
    if(out_x==4&&out_y==1) begin
        exp_q_4_1 = exp_q;
        lock_q_4_1.put(1);
    end
    if(out_x==4&&out_y==2) begin
        exp_q_4_2 = exp_q;
        lock_q_4_2.put(1);
    end
    if(out_x==4&&out_y==3) begin
        exp_q_4_3 = exp_q;
        lock_q_4_3.put(1);
    end
    if(out_x==4&&out_y==4) begin
        exp_q_4_4 = exp_q;
        lock_q_4_4.put(1);
    end


    if(correct_flag==1) return;

    $display("P[%1d,%1d] get wrong packet!!", out_x, out_y);
    //tr.print();
    `uvm_fatal("router_scoreboard", "Wrong Packet Got!!!")

endtask



`endif



