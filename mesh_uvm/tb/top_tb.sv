
`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "../dut/include/network_define.v"
`include "demoter.sv"
`include "router_if.sv"
`include "packet_transaction.sv"
`include "router_driver.sv"
`include "router_monitor.sv"
`include "router_sequence.sv"
`include "router_sequencer.sv"
`include "mesh_virtual_sequencer.sv"
`include "mesh_virtual_sequence_random.sv"
`include "router_agent.sv"
`include "mesh_scoreboard.sv"
`include "mesh_env.sv"
`include "test_random.sv"


module top_tb;

  reg clk;
  
  mesh_rst_if rst_if(clk);

  
  router_if input_if_0_0(clk,rst_if.rst);
  router_if output_if_0_0(clk,rst_if.rst);
  router_if input_if_0_1(clk,rst_if.rst);
  router_if output_if_0_1(clk,rst_if.rst);
  router_if input_if_0_2(clk,rst_if.rst);
  router_if output_if_0_2(clk,rst_if.rst);
  router_if input_if_0_3(clk,rst_if.rst);
  router_if output_if_0_3(clk,rst_if.rst);
  router_if input_if_0_4(clk,rst_if.rst);
  router_if output_if_0_4(clk,rst_if.rst);
  router_if input_if_1_0(clk,rst_if.rst);
  router_if output_if_1_0(clk,rst_if.rst);
  router_if input_if_1_1(clk,rst_if.rst);
  router_if output_if_1_1(clk,rst_if.rst);
  router_if input_if_1_2(clk,rst_if.rst);
  router_if output_if_1_2(clk,rst_if.rst);
  router_if input_if_1_3(clk,rst_if.rst);
  router_if output_if_1_3(clk,rst_if.rst);
  router_if input_if_1_4(clk,rst_if.rst);
  router_if output_if_1_4(clk,rst_if.rst);
  router_if input_if_2_0(clk,rst_if.rst);
  router_if output_if_2_0(clk,rst_if.rst);
  router_if input_if_2_1(clk,rst_if.rst);
  router_if output_if_2_1(clk,rst_if.rst);
  router_if input_if_2_2(clk,rst_if.rst);
  router_if output_if_2_2(clk,rst_if.rst);
  router_if input_if_2_3(clk,rst_if.rst);
  router_if output_if_2_3(clk,rst_if.rst);
  router_if input_if_2_4(clk,rst_if.rst);
  router_if output_if_2_4(clk,rst_if.rst);
  router_if input_if_3_0(clk,rst_if.rst);
  router_if output_if_3_0(clk,rst_if.rst);
  router_if input_if_3_1(clk,rst_if.rst);
  router_if output_if_3_1(clk,rst_if.rst);
  router_if input_if_3_2(clk,rst_if.rst);
  router_if output_if_3_2(clk,rst_if.rst);
  router_if input_if_3_3(clk,rst_if.rst);
  router_if output_if_3_3(clk,rst_if.rst);
  router_if input_if_3_4(clk,rst_if.rst);
  router_if output_if_3_4(clk,rst_if.rst);
  router_if input_if_4_0(clk,rst_if.rst);
  router_if output_if_4_0(clk,rst_if.rst);
  router_if input_if_4_1(clk,rst_if.rst);
  router_if output_if_4_1(clk,rst_if.rst);
  router_if input_if_4_2(clk,rst_if.rst);
  router_if output_if_4_2(clk,rst_if.rst);
  router_if input_if_4_3(clk,rst_if.rst);
  router_if output_if_4_3(clk,rst_if.rst);
  router_if input_if_4_4(clk,rst_if.rst);
  router_if output_if_4_4(clk,rst_if.rst);

  
  mesh mesh(
    .clk(clk),
    .reset_in(rst_if.rst),

    
    .data_in_p_0_0(input_if_0_0.data),
    .valid_in_p_0_0(input_if_0_0.valid),
    .yummy_in_p_0_0(output_if_0_0.yummy),

    .data_out_p_0_0(output_if_0_0.data),
    .valid_out_p_0_0(output_if_0_0.valid),
    .yummy_out_p_0_0(input_if_0_0.yummy),
    .thanks_in_p_0_0(),

    .data_in_p_0_1(input_if_0_1.data),
    .valid_in_p_0_1(input_if_0_1.valid),
    .yummy_in_p_0_1(output_if_0_1.yummy),

    .data_out_p_0_1(output_if_0_1.data),
    .valid_out_p_0_1(output_if_0_1.valid),
    .yummy_out_p_0_1(input_if_0_1.yummy),
    .thanks_in_p_0_1(),

    .data_in_p_0_2(input_if_0_2.data),
    .valid_in_p_0_2(input_if_0_2.valid),
    .yummy_in_p_0_2(output_if_0_2.yummy),

    .data_out_p_0_2(output_if_0_2.data),
    .valid_out_p_0_2(output_if_0_2.valid),
    .yummy_out_p_0_2(input_if_0_2.yummy),
    .thanks_in_p_0_2(),

    .data_in_p_0_3(input_if_0_3.data),
    .valid_in_p_0_3(input_if_0_3.valid),
    .yummy_in_p_0_3(output_if_0_3.yummy),

    .data_out_p_0_3(output_if_0_3.data),
    .valid_out_p_0_3(output_if_0_3.valid),
    .yummy_out_p_0_3(input_if_0_3.yummy),
    .thanks_in_p_0_3(),

    .data_in_p_0_4(input_if_0_4.data),
    .valid_in_p_0_4(input_if_0_4.valid),
    .yummy_in_p_0_4(output_if_0_4.yummy),

    .data_out_p_0_4(output_if_0_4.data),
    .valid_out_p_0_4(output_if_0_4.valid),
    .yummy_out_p_0_4(input_if_0_4.yummy),
    .thanks_in_p_0_4(),

    .data_in_p_1_0(input_if_1_0.data),
    .valid_in_p_1_0(input_if_1_0.valid),
    .yummy_in_p_1_0(output_if_1_0.yummy),

    .data_out_p_1_0(output_if_1_0.data),
    .valid_out_p_1_0(output_if_1_0.valid),
    .yummy_out_p_1_0(input_if_1_0.yummy),
    .thanks_in_p_1_0(),

    .data_in_p_1_1(input_if_1_1.data),
    .valid_in_p_1_1(input_if_1_1.valid),
    .yummy_in_p_1_1(output_if_1_1.yummy),

    .data_out_p_1_1(output_if_1_1.data),
    .valid_out_p_1_1(output_if_1_1.valid),
    .yummy_out_p_1_1(input_if_1_1.yummy),
    .thanks_in_p_1_1(),

    .data_in_p_1_2(input_if_1_2.data),
    .valid_in_p_1_2(input_if_1_2.valid),
    .yummy_in_p_1_2(output_if_1_2.yummy),

    .data_out_p_1_2(output_if_1_2.data),
    .valid_out_p_1_2(output_if_1_2.valid),
    .yummy_out_p_1_2(input_if_1_2.yummy),
    .thanks_in_p_1_2(),

    .data_in_p_1_3(input_if_1_3.data),
    .valid_in_p_1_3(input_if_1_3.valid),
    .yummy_in_p_1_3(output_if_1_3.yummy),

    .data_out_p_1_3(output_if_1_3.data),
    .valid_out_p_1_3(output_if_1_3.valid),
    .yummy_out_p_1_3(input_if_1_3.yummy),
    .thanks_in_p_1_3(),

    .data_in_p_1_4(input_if_1_4.data),
    .valid_in_p_1_4(input_if_1_4.valid),
    .yummy_in_p_1_4(output_if_1_4.yummy),

    .data_out_p_1_4(output_if_1_4.data),
    .valid_out_p_1_4(output_if_1_4.valid),
    .yummy_out_p_1_4(input_if_1_4.yummy),
    .thanks_in_p_1_4(),

    .data_in_p_2_0(input_if_2_0.data),
    .valid_in_p_2_0(input_if_2_0.valid),
    .yummy_in_p_2_0(output_if_2_0.yummy),

    .data_out_p_2_0(output_if_2_0.data),
    .valid_out_p_2_0(output_if_2_0.valid),
    .yummy_out_p_2_0(input_if_2_0.yummy),
    .thanks_in_p_2_0(),

    .data_in_p_2_1(input_if_2_1.data),
    .valid_in_p_2_1(input_if_2_1.valid),
    .yummy_in_p_2_1(output_if_2_1.yummy),

    .data_out_p_2_1(output_if_2_1.data),
    .valid_out_p_2_1(output_if_2_1.valid),
    .yummy_out_p_2_1(input_if_2_1.yummy),
    .thanks_in_p_2_1(),

    .data_in_p_2_2(input_if_2_2.data),
    .valid_in_p_2_2(input_if_2_2.valid),
    .yummy_in_p_2_2(output_if_2_2.yummy),

    .data_out_p_2_2(output_if_2_2.data),
    .valid_out_p_2_2(output_if_2_2.valid),
    .yummy_out_p_2_2(input_if_2_2.yummy),
    .thanks_in_p_2_2(),

    .data_in_p_2_3(input_if_2_3.data),
    .valid_in_p_2_3(input_if_2_3.valid),
    .yummy_in_p_2_3(output_if_2_3.yummy),

    .data_out_p_2_3(output_if_2_3.data),
    .valid_out_p_2_3(output_if_2_3.valid),
    .yummy_out_p_2_3(input_if_2_3.yummy),
    .thanks_in_p_2_3(),

    .data_in_p_2_4(input_if_2_4.data),
    .valid_in_p_2_4(input_if_2_4.valid),
    .yummy_in_p_2_4(output_if_2_4.yummy),

    .data_out_p_2_4(output_if_2_4.data),
    .valid_out_p_2_4(output_if_2_4.valid),
    .yummy_out_p_2_4(input_if_2_4.yummy),
    .thanks_in_p_2_4(),

    .data_in_p_3_0(input_if_3_0.data),
    .valid_in_p_3_0(input_if_3_0.valid),
    .yummy_in_p_3_0(output_if_3_0.yummy),

    .data_out_p_3_0(output_if_3_0.data),
    .valid_out_p_3_0(output_if_3_0.valid),
    .yummy_out_p_3_0(input_if_3_0.yummy),
    .thanks_in_p_3_0(),

    .data_in_p_3_1(input_if_3_1.data),
    .valid_in_p_3_1(input_if_3_1.valid),
    .yummy_in_p_3_1(output_if_3_1.yummy),

    .data_out_p_3_1(output_if_3_1.data),
    .valid_out_p_3_1(output_if_3_1.valid),
    .yummy_out_p_3_1(input_if_3_1.yummy),
    .thanks_in_p_3_1(),

    .data_in_p_3_2(input_if_3_2.data),
    .valid_in_p_3_2(input_if_3_2.valid),
    .yummy_in_p_3_2(output_if_3_2.yummy),

    .data_out_p_3_2(output_if_3_2.data),
    .valid_out_p_3_2(output_if_3_2.valid),
    .yummy_out_p_3_2(input_if_3_2.yummy),
    .thanks_in_p_3_2(),

    .data_in_p_3_3(input_if_3_3.data),
    .valid_in_p_3_3(input_if_3_3.valid),
    .yummy_in_p_3_3(output_if_3_3.yummy),

    .data_out_p_3_3(output_if_3_3.data),
    .valid_out_p_3_3(output_if_3_3.valid),
    .yummy_out_p_3_3(input_if_3_3.yummy),
    .thanks_in_p_3_3(),

    .data_in_p_3_4(input_if_3_4.data),
    .valid_in_p_3_4(input_if_3_4.valid),
    .yummy_in_p_3_4(output_if_3_4.yummy),

    .data_out_p_3_4(output_if_3_4.data),
    .valid_out_p_3_4(output_if_3_4.valid),
    .yummy_out_p_3_4(input_if_3_4.yummy),
    .thanks_in_p_3_4(),

    .data_in_p_4_0(input_if_4_0.data),
    .valid_in_p_4_0(input_if_4_0.valid),
    .yummy_in_p_4_0(output_if_4_0.yummy),

    .data_out_p_4_0(output_if_4_0.data),
    .valid_out_p_4_0(output_if_4_0.valid),
    .yummy_out_p_4_0(input_if_4_0.yummy),
    .thanks_in_p_4_0(),

    .data_in_p_4_1(input_if_4_1.data),
    .valid_in_p_4_1(input_if_4_1.valid),
    .yummy_in_p_4_1(output_if_4_1.yummy),

    .data_out_p_4_1(output_if_4_1.data),
    .valid_out_p_4_1(output_if_4_1.valid),
    .yummy_out_p_4_1(input_if_4_1.yummy),
    .thanks_in_p_4_1(),

    .data_in_p_4_2(input_if_4_2.data),
    .valid_in_p_4_2(input_if_4_2.valid),
    .yummy_in_p_4_2(output_if_4_2.yummy),

    .data_out_p_4_2(output_if_4_2.data),
    .valid_out_p_4_2(output_if_4_2.valid),
    .yummy_out_p_4_2(input_if_4_2.yummy),
    .thanks_in_p_4_2(),

    .data_in_p_4_3(input_if_4_3.data),
    .valid_in_p_4_3(input_if_4_3.valid),
    .yummy_in_p_4_3(output_if_4_3.yummy),

    .data_out_p_4_3(output_if_4_3.data),
    .valid_out_p_4_3(output_if_4_3.valid),
    .yummy_out_p_4_3(input_if_4_3.yummy),
    .thanks_in_p_4_3(),

    .data_in_p_4_4(input_if_4_4.data),
    .valid_in_p_4_4(input_if_4_4.valid),
    .yummy_in_p_4_4(output_if_4_4.yummy),

    .data_out_p_4_4(output_if_4_4.data),
    .valid_out_p_4_4(output_if_4_4.valid),
    .yummy_out_p_4_4(input_if_4_4.yummy),
    .thanks_in_p_4_4()

  );

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
    
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_0.drv", "vif", input_if_0_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_0.mon_in", "vif", input_if_0_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_0.mon_out", "vif", output_if_0_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_1.drv", "vif", input_if_0_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_1.mon_in", "vif", input_if_0_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_1.mon_out", "vif", output_if_0_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_2.drv", "vif", input_if_0_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_2.mon_in", "vif", input_if_0_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_2.mon_out", "vif", output_if_0_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_3.drv", "vif", input_if_0_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_3.mon_in", "vif", input_if_0_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_3.mon_out", "vif", output_if_0_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_4.drv", "vif", input_if_0_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_4.mon_in", "vif", input_if_0_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_0_4.mon_out", "vif", output_if_0_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_0.drv", "vif", input_if_1_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_0.mon_in", "vif", input_if_1_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_0.mon_out", "vif", output_if_1_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_1.drv", "vif", input_if_1_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_1.mon_in", "vif", input_if_1_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_1.mon_out", "vif", output_if_1_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_2.drv", "vif", input_if_1_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_2.mon_in", "vif", input_if_1_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_2.mon_out", "vif", output_if_1_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_3.drv", "vif", input_if_1_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_3.mon_in", "vif", input_if_1_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_3.mon_out", "vif", output_if_1_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_4.drv", "vif", input_if_1_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_4.mon_in", "vif", input_if_1_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_1_4.mon_out", "vif", output_if_1_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_0.drv", "vif", input_if_2_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_0.mon_in", "vif", input_if_2_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_0.mon_out", "vif", output_if_2_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_1.drv", "vif", input_if_2_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_1.mon_in", "vif", input_if_2_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_1.mon_out", "vif", output_if_2_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_2.drv", "vif", input_if_2_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_2.mon_in", "vif", input_if_2_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_2.mon_out", "vif", output_if_2_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_3.drv", "vif", input_if_2_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_3.mon_in", "vif", input_if_2_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_3.mon_out", "vif", output_if_2_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_4.drv", "vif", input_if_2_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_4.mon_in", "vif", input_if_2_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_2_4.mon_out", "vif", output_if_2_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_0.drv", "vif", input_if_3_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_0.mon_in", "vif", input_if_3_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_0.mon_out", "vif", output_if_3_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_1.drv", "vif", input_if_3_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_1.mon_in", "vif", input_if_3_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_1.mon_out", "vif", output_if_3_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_2.drv", "vif", input_if_3_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_2.mon_in", "vif", input_if_3_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_2.mon_out", "vif", output_if_3_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_3.drv", "vif", input_if_3_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_3.mon_in", "vif", input_if_3_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_3.mon_out", "vif", output_if_3_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_4.drv", "vif", input_if_3_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_4.mon_in", "vif", input_if_3_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_3_4.mon_out", "vif", output_if_3_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_0.drv", "vif", input_if_4_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_0.mon_in", "vif", input_if_4_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_0.mon_out", "vif", output_if_4_0);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_1.drv", "vif", input_if_4_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_1.mon_in", "vif", input_if_4_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_1.mon_out", "vif", output_if_4_1);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_2.drv", "vif", input_if_4_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_2.mon_in", "vif", input_if_4_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_2.mon_out", "vif", output_if_4_2);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_3.drv", "vif", input_if_4_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_3.mon_in", "vif", input_if_4_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_3.mon_out", "vif", output_if_4_3);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_4.drv", "vif", input_if_4_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_4.mon_in", "vif", input_if_4_4);
    uvm_config_db#(virtual router_if)::set(null, "uvm_test_top.env.agt_4_4.mon_out", "vif", output_if_4_4);

    uvm_config_db#(virtual mesh_rst_if)::set(null, "uvm_test_top", "rst_if", rst_if);
  end


endmodule
    
    
    