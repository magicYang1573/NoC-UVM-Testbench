`ifndef ROUTER_SEQUENCE__SV
`define ROUTER_SEQUENCE__SV

class router_sequence extends uvm_sequence #(packet_transaction);
    packet_transaction m_trans;
    packet_transaction trans_q[$];

    `uvm_object_utils(router_sequence)

    function new(string name= "router_sequence");
        super.new(name);
    endfunction

    virtual task body();          
        while(trans_q.size()!=0) begin
            m_trans = trans_q.pop_back();
            `uvm_send(m_trans)
        end
    endtask

    
    
endclass
`endif