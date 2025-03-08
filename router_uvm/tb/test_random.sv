`ifndef RANDOM_TEST__SV
`define RANDOM_TEST__SV

class random_test extends uvm_test;

   router_env env;   
   router_virtual_sequence_0 vseq;
   router_scoreboard scb;

   virtual router_rst_if rst_vif;

   function new(string name = "random_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern task main_phase(uvm_phase phase);   

   `uvm_component_utils(random_test)
endclass


function void random_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
   env = router_env::type_id::create("env", this); 
   if(!uvm_config_db#(virtual router_rst_if)::get(this, "", "rst_if", rst_vif))
      `uvm_fatal("random_test", "reset signal must be set for test!!!")
endfunction

function void random_test::report_phase(uvm_phase phase);
   uvm_report_server server;
   int err_num;
   super.report_phase(phase);

   server = get_report_server();
   err_num = server.get_severity_count(UVM_ERROR);

   if (err_num != 0) begin
      $display("TEST CASE FAILED");
   end
   else begin
      $display("TEST CASE PASSED");
   end
endfunction

task random_test::main_phase(uvm_phase phase);   
   phase.raise_objection(this);

   // reset DUT
   rst_vif.rst <= 1'b1;
   #1000;
   rst_vif.rst <= 1'b0;

   vseq = new();
   vseq.scb = env.scb;

   vseq.packets_num = 10000;  
   vseq.p_free = 20;     
   vseq.packet_max_len = `PACKET_LEN_MAX;   

   vseq.start(env.vsqr);

   phase.drop_objection(this);

endtask


`endif
