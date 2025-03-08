
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

<%
X_SIZE = 5
Y_SIZE = 5
router_queue = []
for i in range(0,X_SIZE):
  for j in range(0,Y_SIZE):
    router_this = str(i) + '_' + str(j)
    router_queue.append(router_this)
%>
module top_tb;

  reg clk;
  
  mesh_rst_if rst_if(clk);

  <%
  print('')
  for r in router_queue:
    print("  router_if input_if_{}(clk,rst_if.rst);".format(r))
    print("  router_if output_if_{}(clk,rst_if.rst);".format(r))
  %>
  
  mesh mesh(
    .clk(clk),
    .reset_in(rst_if.rst),

    <%
      for i in range(0,len(router_queue)):
        r = router_queue[i]
        print('')
        print("    .data_in_p_{}(input_if_{}.data),".format(r,r))
        print("    .valid_in_p_{}(input_if_{}.valid),".format(r,r))
        print("    .yummy_in_p_{}(output_if_{}.yummy),".format(r,r))
        print('')
        print("    .data_out_p_{}(output_if_{}.data),".format(r,r))
        print("    .valid_out_p_{}(output_if_{}.valid),".format(r,r))
        print("    .yummy_out_p_{}(input_if_{}.yummy),".format(r,r))
        if(i==len(router_queue)-1):
          print("    .thanks_in_p_{}()".format(r))
        else:
          print("    .thanks_in_p_{}(),".format(r))
    %>
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
    <%
    print('')
    for r in router_queue:
      print("    uvm_config_db#(virtual router_if)::set(null, \"uvm_test_top.env.agt_{}.drv\", \"vif\", input_if_{});".format(r,r))
      print("    uvm_config_db#(virtual router_if)::set(null, \"uvm_test_top.env.agt_{}.mon_in\", \"vif\", input_if_{});".format(r,r))
      print("    uvm_config_db#(virtual router_if)::set(null, \"uvm_test_top.env.agt_{}.mon_out\", \"vif\", output_if_{});".format(r,r))
    %>
    uvm_config_db#(virtual mesh_rst_if)::set(null, "uvm_test_top", "rst_if", rst_if);
  end


endmodule
    
    
    