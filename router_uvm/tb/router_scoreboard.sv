`ifndef ROUTER_ENV__SV
`define ROUTER_ENV__SV
// UVM scoreboard for one single router
// collect packets and compare

`define NORTH_PORT 1
`define EAST_PORT 2
`define SOUTH_PORT 3
`define WEST_PORT 4
`define PROCESSER_PORT 5

class router_scoreboard extends uvm_scoreboard;
    
    uvm_blocking_get_port #(packet_transaction)  input_N_port;
    uvm_blocking_get_port #(packet_transaction)  input_S_port;
    uvm_blocking_get_port #(packet_transaction)  input_E_port;
    uvm_blocking_get_port #(packet_transaction)  input_W_port;
    uvm_blocking_get_port #(packet_transaction)  input_P_port;

    uvm_blocking_get_port #(packet_transaction)  output_N_port;
    uvm_blocking_get_port #(packet_transaction)  output_S_port;
    uvm_blocking_get_port #(packet_transaction)  output_E_port;
    uvm_blocking_get_port #(packet_transaction)  output_W_port;
    uvm_blocking_get_port #(packet_transaction)  output_P_port;

    packet_transaction exp_q_N[$];
    packet_transaction exp_q_S[$];
    packet_transaction exp_q_E[$];
    packet_transaction exp_q_W[$];
    packet_transaction exp_q_P[$];

    // share vars of several forks, use lock to avoid conflict
    semaphore lock_q_N;
    semaphore lock_q_S;
    semaphore lock_q_E;
    semaphore lock_q_W;
    semaphore lock_q_P;



    `uvm_component_utils(router_scoreboard)
 
    extern function new(string name, uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual function void final_phase(uvm_phase phase);

    extern task route_cal(int input_port, packet_transaction tr);
    extern task check_packet(int output_port, packet_transaction tr);
endclass 

function router_scoreboard::new(string name, uvm_component parent = null);
    super.new(name, parent);
endfunction 

function void router_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    input_N_port = new("input_N_port", this);
    input_S_port = new("input_S_port", this);
    input_E_port = new("input_E_port", this);
    input_W_port = new("input_W_port", this);
    input_P_port = new("input_P_port", this);

    output_N_port = new("output_N_port", this);
    output_S_port = new("output_S_port", this);
    output_E_port = new("output_E_port", this);
    output_W_port = new("output_W_port", this);
    output_P_port = new("output_P_port", this);

    lock_q_N = new(1);
    lock_q_S = new(1);
    lock_q_E = new(1);
    lock_q_W = new(1);
    lock_q_P = new(1);
endfunction

task router_scoreboard::main_phase(uvm_phase phase);
    packet_transaction input_N_trans;
    packet_transaction input_S_trans;
    packet_transaction input_W_trans;
    packet_transaction input_E_trans;
    packet_transaction input_P_trans;
    packet_transaction output_S_trans;
    packet_transaction output_N_trans;
    packet_transaction output_W_trans;
    packet_transaction output_E_trans;
    packet_transaction output_P_trans;
  
    super.main_phase(phase);
    fork 
        while (1) begin
            input_N_port.get(input_N_trans);
            route_cal(`NORTH_PORT,input_N_trans);
        end
        while (1) begin
            input_S_port.get(input_S_trans);
            route_cal(`SOUTH_PORT,input_S_trans);
        end
        while (1) begin
            input_E_port.get(input_E_trans);
            route_cal(`EAST_PORT,input_E_trans);
        end
        while (1) begin
            input_W_port.get(input_W_trans);
            route_cal(`WEST_PORT,input_W_trans);
        end
        while (1) begin
            input_P_port.get(input_P_trans);
            route_cal(`PROCESSER_PORT,input_P_trans);
        end

        while (1) begin
            output_S_port.get(output_S_trans);
            check_packet(`SOUTH_PORT,output_S_trans);
        end
        while (1) begin
            output_N_port.get(output_N_trans);
            check_packet(`NORTH_PORT,output_N_trans);
        end
        while (1) begin
            output_W_port.get(output_W_trans);
            check_packet(`WEST_PORT,output_W_trans);
        end
        while (1) begin
            output_E_port.get(output_E_trans);
            check_packet(`EAST_PORT,output_E_trans);
        end
        while (1) begin
            output_P_port.get(output_P_trans);
            check_packet(`PROCESSER_PORT,output_P_trans);
        end
    join
endtask


function void router_scoreboard::final_phase(uvm_phase phase);
    super.final_phase(phase);
    //$display(exp_q_N.size(),exp_q_E.size(),exp_q_S.size(),exp_q_W.size(),exp_q_P.size());
    if(exp_q_N.size()!=0 || exp_q_E.size()!=0 || exp_q_S.size()!=0 || exp_q_W.size()!=0 || exp_q_P.size()!=0)
        `uvm_fatal("router_scoreboard", "Packet Drop!!");
endfunction


// route cal and put transaction to queue
// route strategy: E/W first, then N/S
task router_scoreboard::route_cal(int input_port, packet_transaction tr);
    int direction = 0;
    if(tr.dst_x==`LOC_X && tr.dst_y==`LOC_Y)
        case(tr.final_bits)
            `FINAL_NONE: direction = `PROCESSER_PORT;
            `FINAL_NORTH: direction = `NORTH_PORT;
            `FINAL_EAST: direction = `EAST_PORT;
            `FINAL_WEST: direction = `WEST_PORT;
            `FINAL_SOUTH: direction = `SOUTH_PORT;
        endcase
    else if(tr.dst_x==`LOC_X)
        if(tr.dst_y > `LOC_Y) direction = `SOUTH_PORT;
        else direction = `NORTH_PORT;
    else if(tr.dst_x < `LOC_X) direction = `WEST_PORT;
    else if(tr.dst_x > `LOC_X) direction = `EAST_PORT;
    
    case(direction)
        `PROCESSER_PORT: begin
            lock_q_P.get(1);
            exp_q_P.push_back(tr);
            lock_q_P.put(1);
        end
        `NORTH_PORT: begin
            lock_q_N.get(1);
            exp_q_N.push_back(tr);
            lock_q_N.put(1);
        end
        `SOUTH_PORT: begin
            lock_q_S.get(1);
            exp_q_S.push_back(tr);
            lock_q_S.put(1);
        end
        `EAST_PORT: begin
            lock_q_E.get(1);
            exp_q_E.push_back(tr);
            lock_q_E.put(1);
        end
        `WEST_PORT: begin
            lock_q_W.get(1);
            exp_q_W.push_back(tr);
            lock_q_W.put(1);
        end
        default: `uvm_fatal("router_scoreboard", "Wrong Direction!")
    endcase
    `uvm_info("Scoreboard", $sformatf("Receive pkt from Input Port [%1d], expect to Output Port [%1d], len %2d", input_port, direction, tr.payload_len), UVM_HIGH)
    // tr.print();
endtask

task router_scoreboard::check_packet(int output_port, packet_transaction tr);
    packet_transaction exp_q[$];
    int correct_flag = 0;
    
    `uvm_info("Scoreboard", $sformatf("Output Port [%1d] receive packet", output_port), UVM_HIGH)
    // tr.print();

    case(output_port)
        `NORTH_PORT: begin
            lock_q_N.get(1);
            exp_q = exp_q_N;
        end
        `SOUTH_PORT: begin
            lock_q_S.get(1);
            exp_q = exp_q_S;
        end
        `WEST_PORT: begin
            lock_q_W.get(1);
            exp_q = exp_q_W;
        end
        `EAST_PORT: begin
            lock_q_E.get(1);
            exp_q = exp_q_E;
        end
        `PROCESSER_PORT: begin
            lock_q_P.get(1);
            exp_q = exp_q_P;
        end
    endcase

    for(int i=0;i<exp_q.size();i++) begin
        if(tr.compare(exp_q[i])) begin
            exp_q.delete(i);
            // `uvm_info("Scoreboard", $sformatf("Output Port [%1d] get correct packet!!", output_port), UVM_HIGH)
            // tr.print();
            correct_flag = 1;
            break;
        end
    end
    case(output_port)
        `NORTH_PORT: begin
            exp_q_N = exp_q;
            lock_q_N.put(1);
        end
        `SOUTH_PORT: begin
            exp_q_S = exp_q;
            lock_q_S.put(1);
        end
        `WEST_PORT: begin
            exp_q_W = exp_q;
            lock_q_W.put(1);
        end
        `EAST_PORT: begin
            exp_q_E = exp_q;
            lock_q_E.put(1);
        end
        `PROCESSER_PORT: begin
            exp_q_P = exp_q;
            lock_q_P.put(1);
        end
        
    endcase

    if(correct_flag==1) return;

    //tr.print();
    `uvm_fatal("<Scoreboard>", $sformatf("Output Port [%1d] get wrong packet!!", output_port))

endtask




`endif



