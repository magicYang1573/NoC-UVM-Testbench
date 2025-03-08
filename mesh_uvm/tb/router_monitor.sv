`ifndef MY_MONITOR__SV
`define MY_MONITOR__SV
class router_monitor extends uvm_monitor;

   virtual router_if vif;

   int yummy_flag;  //0 means input monitor, 1 means output monitor need to give back yummy
   int yummy_count;
   parameter yummy_back_time_max = 5;

   uvm_analysis_port #(packet_transaction)  ap;     //send to scoreboard

   `uvm_component_utils(router_monitor)
   function new(string name = "router_monitor", uvm_component parent = null);
      super.new(name, parent);
      yummy_count = 0;
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual router_if)::get(this, "", "vif", vif))
         `uvm_fatal("router_monitor", "virtual interface must be set for vif!!!")
    //   if(!uvm_config_db#(int)::get(this, "", "yummy_flag", yummy_flag))
    //      `uvm_fatal("router_monitor", "monitor type must be set (yummy_flag)!!!")
      ap = new("ap", this);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_packet(packet_transaction tr);
endclass

task router_monitor::main_phase(uvm_phase phase);
    packet_transaction tr;
    if(yummy_flag) 
        vif.yummy <= 1'b0;

    fork
        while(1) begin
            tr = new("tr");
            collect_one_packet(tr);
            ap.write(tr);
        end
        while(1) begin
            @(posedge vif.clk);
            if(yummy_flag) begin
                vif.yummy <= 1'b0;
                if(yummy_count>0) begin     //这里可能有bug，如果在发送数据后的下一周期甚至同周期返回yummy是否有效？
                    int t = $urandom % yummy_back_time_max;
                    repeat(t) @(posedge vif.clk);
                    vif.yummy <= 1'b1;
                    yummy_count--;
                end
            end
        end
    join

endtask

task router_monitor::collect_one_packet(packet_transaction tr);
    bit[`DATA_WIDTH-1:0] flit_q[$];
    int psize;

    while(1) begin
        @(posedge vif.clk);
        if(vif.valid) break;
    end
    //`uvm_info("router_monitor", "begin to collect one pkt", UVM_LOW);

    //collect header
    tr.dst_chip_id = vif.data[`DATA_WIDTH-1:`DATA_WIDTH-1-`CHIP_ID_WIDTH];
    tr.dst_x = vif.data[`DATA_WIDTH-`CHIP_ID_WIDTH-1:`DATA_WIDTH-`CHIP_ID_WIDTH-`XY_WIDTH];
    tr.dst_y = vif.data[`DATA_WIDTH-`CHIP_ID_WIDTH-`XY_WIDTH-1:`DATA_WIDTH-`CHIP_ID_WIDTH-2*`XY_WIDTH];
    tr.final_bits = vif.data[`DATA_WIDTH-`CHIP_ID_WIDTH-2*`XY_WIDTH-1:`DATA_WIDTH-`CHIP_ID_WIDTH-2*`XY_WIDTH-4];
    tr.payload_len = vif.data[`DATA_WIDTH-`CHIP_ID_WIDTH-2*`XY_WIDTH-5:`DATA_WIDTH-`CHIP_ID_WIDTH-2*`XY_WIDTH-4-`PAYLOAD_LEN];
    flit_q.push_back(vif.data);
    if(yummy_flag) yummy_count++;

    for(int i=0;i<tr.payload_len;i++) begin

        while(1) begin
            @(posedge vif.clk);
            if(vif.valid) break;
        end
        flit_q.push_back(vif.data);
        if(yummy_flag) yummy_count++;
    end

    tr.payload = new[flit_q.size()];
    psize = flit_q.size();
    
    for(int i=0;i<psize;i++) begin
        tr.payload[i] = flit_q.pop_front();
    end
endtask

`endif