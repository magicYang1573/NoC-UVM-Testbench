`ifndef FUZZ_TEST__SV
`define FUZZ_TEST__SV

extern "C" int waitForAFL();
extern "C" int sendCov2AFL(string test_name);

class fuzz_test extends uvm_test;

   router_env env;   
   virtual router_rst_if rst_vif;
   
   function new(string name = "fuzz_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern task main_phase(uvm_phase phase);   

   `uvm_component_utils(fuzz_test)
endclass


function void fuzz_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
   env = router_env::type_id::create("env", this); 
   if(!uvm_config_db#(virtual router_rst_if)::get(this, "", "rst_if", rst_vif))
      `uvm_fatal("fuzz_test", "reset signal must be set for test!!!")
endfunction

function void fuzz_test::report_phase(uvm_phase phase);
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

task fuzz_test::main_phase(uvm_phase phase);   

   router_virtual_sequence_1 vseq;
   string test_name;
   int test_cnt = 0;
   int packets_sum = 0;
   int ret;

   phase.raise_objection(this);

   
   while(waitForAFL()) begin
      // reset DUT
      rst_vif.rst <= 1'b1;
      #1000;
      rst_vif.rst <= 1'b0;

      //launch sequence
      vseq = new();
      vseq.start(env.vsqr);

      // dump coverage to database
      $sformat(test_name, "test_%0d", test_cnt);
      // test_cnt++;
      // $display("Dump %s\n", test_name);

      $coverage_dump(test_name);
      #1;

      packets_sum += vseq.packets_num;
      $display("INFO: current packet %d", packets_sum);
      // if(packets_sum > 1000 * 5) begin
      //    $display("\nReach target PACKET sum\n");
      //    break;
      // end

      //send cov trace to AFL
      ret = sendCov2AFL(test_name);    
      if(ret) break;

      //reset coverage database
      $coverage_reset();
      
   end
   phase.drop_objection(this);

endtask


`endif
