// 将 yummy signal 的反馈控制发送的工作交给 driver 来做？
`ifndef ROUTER_DRIVER__SV
`define ROUTER_DRIVER__SV

class router_driver extends uvm_driver #(packet_transaction);

    virtual router_if vif;
    int buffer_num_left;
    int router_buffer_size;
    semaphore buffer_num_lock;

    `uvm_component_utils(router_driver)
    function new(string name = "router_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        buffer_num_lock = new(1);
        buffer_num_left = router_buffer_size;
        if(!uvm_config_db#(virtual router_if)::get(this, "", "vif", vif))
            `uvm_fatal("router_driver", "virtual interface must be set for vif!!!")
    endfunction

    extern task main_phase(uvm_phase phase);
    extern task drive_one_flit(bit [`DATA_WIDTH-1:0] data);
    extern task drive_one_packet(packet_transaction tr);
   
endclass

task router_driver::main_phase(uvm_phase phase);    
    fork
        while(1) begin
            @(posedge vif.clk);
            if(vif.yummy==1'b1) begin
                buffer_num_lock.get(1);
                buffer_num_left = buffer_num_left + 1;
                buffer_num_lock.put(1);
            end
        end
        begin
            vif.data <= 64'b0;
            vif.valid <= 1'b0;
            while(vif.rst)
                @(posedge vif.clk);
            
            while(1) begin
                seq_item_port.get_next_item(req);
                drive_one_packet(req);
                seq_item_port.item_done();
            end
        end
    join
endtask

// task router_driver::drive_one_flit(bit [`DATA_WIDTH-1:0] data);
//     $display($realtime, buffer_num_left, "       %h",data);
//     while(buffer_num_left==0) begin
//         vif.valid <= 1'b0;
//         vif.data <= `DATA_WIDTH'b0;
//         if(vif.yummy==1'b1) begin
//             buffer_num_left = buffer_num_left + 1;
//             // $display("Router yummy~");
//         end
//         @(posedge vif.clk);
//     end
//     vif.valid <= 1'b1;
//     vif.data <= data;
//     buffer_num_left = buffer_num_left - 1;
//     // $display("Send a flit to router!");
//     if(vif.yummy==1'b1) begin
//         buffer_num_left = buffer_num_left==router_buffer_size ? router_buffer_size : buffer_num_left + 1; 
//         // $display("Router yummy~");
//     end
//     @(posedge vif.clk);
// endtask

task router_driver::drive_one_flit(bit [`DATA_WIDTH-1:0] data);
    while(1) begin
        @(posedge vif.clk);
        vif.valid <= 1'b0;
        vif.data <= `DATA_WIDTH'b0;
        if(buffer_num_left==0) continue;
        
        vif.valid <= 1'b1;
        vif.data <= data;
        buffer_num_lock.get(1);
        buffer_num_left = buffer_num_left - 1;
        buffer_num_lock.put(1);
        break;
    end
endtask


task router_driver::drive_one_packet(packet_transaction tr);
    // free packet
    // valid=0 for several cycles
    if(tr.payload[0]==`DATA_WIDTH'b0) begin
        for(int i=0;i<tr.payload_len;i++) begin
            @(posedge vif.clk);
            vif.valid <= 1'b0;
            vif.data <= `DATA_WIDTH'b0;
        end
        return;
    end
    
    // send header and payloads
    // SV random return a 32-bit rand num
    for(int i=0;i<tr.payload.size();i++) begin
        drive_one_flit(tr.payload[i]);
    end
    
    @(posedge vif.clk);
    vif.valid <= 1'b0;
    vif.data <= `DATA_WIDTH'b0;
endtask
`endif