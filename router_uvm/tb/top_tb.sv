
`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

// `define LOC_X 2
// `define LOC_Y 2
// `define CHIP_ID 1
// `define LOC_X_MAX 4
// `define LOC_Y_MAX 4
// `define PACKET_LEN_MAX 20
`include "../dut/include/network_define.v"
`include "demoter.sv"
`include "router_if.sv"
`include "packet_transaction.sv"
`include "router_driver.sv"
`include "router_monitor.sv"
`include "router_scoreboard.sv"
`include "router_sequence.sv"
`include "router_sequencer.sv"
`include "router_virtual_sequencer.sv"
`include "router_virtual_sequence_0.sv"
`include "router_virtual_sequence_1.sv"
`include "router_virtual_sequence_2.sv"
`include "router_agent.sv"
`include "router_env.sv"
`include "test_fuzz.sv"
`include "test_random.sv"


module top_tb;

  reg clk;
    
  wire [8-1:0] myLocX;       // this tile's position
  wire [8-1:0] myLocY;
  wire [14-1:0] myChipID;

  wire thanksIn_P;     // thanksIn to processor's space_avail

  assign myLocX = `LOC_X;
  assign myLocY = `LOC_Y;
  assign myChipID = `CHIP_ID;
  
  router_rst_if rst_if(clk);
  router_if input_if_N(clk,rst_if.rst);
  router_if output_if_N(clk,rst_if.rst);
  router_if input_if_S(clk,rst_if.rst);
  router_if output_if_S(clk,rst_if.rst);
  router_if input_if_W(clk,rst_if.rst);
  router_if output_if_W(clk,rst_if.rst);
  router_if input_if_E(clk,rst_if.rst);
  router_if output_if_E(clk,rst_if.rst);
  router_if input_if_P(clk,rst_if.rst);
  router_if output_if_P(clk,rst_if.rst);

  dynamic_node_top_wrap dynamic_node( 
    .clk(clk),
    .reset_in(rst_if.rst),
    // dataIn (to input blocks)
    .dataIn_N(input_if_N.data),
    .dataIn_E(input_if_E.data),
    .dataIn_S(input_if_S.data),
    .dataIn_W(input_if_W.data),
    .dataIn_P(input_if_P.data),
    // validIn (to input blocks)
    .validIn_N(input_if_N.valid),
    .validIn_E(input_if_E.valid),
    .validIn_S(input_if_S.valid),
    .validIn_W(input_if_W.valid),
    .validIn_P(input_if_P.valid),
    // yummy (from nighboring input blocks)
    // .yummyIn_N(yummyIn_N),
    // .yummyIn_E(yummyIn_E),
    // .yummyIn_S(yummyIn_S),
    // .yummyIn_W(yummyIn_W),
    // .yummyIn_P(yummyIn_P),
    .yummyIn_N(output_if_N.yummy),
    .yummyIn_E(output_if_E.yummy),
    .yummyIn_S(output_if_S.yummy),
    .yummyIn_W(output_if_W.yummy),
    .yummyIn_P(output_if_P.yummy),
    // My Absolute Address
    .myLocX(myLocX),
    .myLocY(myLocY),
    .myChipID(myChipID),
    //.ec_cfg(15'b0),//ec_dyn_cfg[14:0]),
    //.store_meter_partner_address_X(5'b0),
    //.store_meter_partner_address_Y(5'b0),
    // DataOut (from crossbar)
    .dataOut_N(output_if_N.data),
    .dataOut_E(output_if_E.data),
    .dataOut_S(output_if_S.data),
    .dataOut_W(output_if_W.data),
    .dataOut_P(output_if_P.data), //data output to processor
    // validOut (from crossbar)
    .validOut_N(output_if_N.valid),
    .validOut_E(output_if_E.valid),
    .validOut_S(output_if_S.valid),
    .validOut_W(output_if_W.valid),
    .validOut_P(output_if_P.valid), //data valid to processor
    // yummyOut (to neighboring output blocks)
    .yummyOut_N(input_if_N.yummy),
    .yummyOut_E(input_if_E.yummy),
    .yummyOut_W(input_if_W.yummy),
    .yummyOut_S(input_if_S.yummy),
    .yummyOut_P(input_if_P.yummy), //yummy out to neighboring
    // thanksIn (to CGNO)
    .thanksIn_P(thanksIn_P));
    //.external_interrupt(),
    //.store_meter_ack_partner(),
    //.store_meter_ack_non_partner(),
    //.ec_out(ec_dyn0));

  initial begin
    clk = 0;
    forever begin
        #100 clk = ~clk;
    end
  end
    
  initial begin
    run_test("random_test");
  end
  
  initial begin
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_N.drv", "vif", input_if_N);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_N.mon_in", "vif", input_if_N);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_N.mon_out", "vif", output_if_N);

    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_S.drv", "vif", input_if_S);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_S.mon_in", "vif", input_if_S);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_S.mon_out", "vif", output_if_S);

    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_W.drv", "vif", input_if_W);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_W.mon_in", "vif", input_if_W);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_W.mon_out", "vif", output_if_W);

    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_E.drv", "vif", input_if_E);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_E.mon_in", "vif", input_if_E);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_E.mon_out", "vif", output_if_E);

    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_P.drv", "vif", input_if_P);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_P.mon_in", "vif", input_if_P);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_P.mon_out", "vif", output_if_P);

    uvm_config_db#(virtual router_rst_if)::set(null, "uvm_test_top", "rst_if", rst_if);
    
    
  end


endmodule
    
    
    