extern "C" void getCov(string test_name);

// this is a random sequence, which generate PACKET_NUM random packets for one sequence
class router_virtual_sequence_0 extends uvm_sequence;
   int packets_num;    
   int p_free;     //sequence为空闲时候的概率,0-100
   int packet_max_len;     //均匀分布
   int packet_sum;
   packet_transaction m_trans;

   router_scoreboard scb;

   `uvm_object_utils(router_virtual_sequence_0)
   `uvm_declare_p_sequencer(router_virtual_sequencer) 

   function new(string name = "router_virtual_sequence_0");
      super.new(name);
   endfunction
   
   virtual task body();
      router_sequence seq_N;
      router_sequence seq_S;
      router_sequence seq_W;
      router_sequence seq_E;
      router_sequence seq_P;
      int packets_per_sequence = 100;

      seq_N = router_sequence::type_id::create("seq_N");
      seq_S = router_sequence::type_id::create("seq_S");
      seq_W = router_sequence::type_id::create("seq_W");
      seq_E = router_sequence::type_id::create("seq_E");
      seq_P = router_sequence::type_id::create("seq_P");
      
      
      for(int j=0;j<packets_num/packets_per_sequence;j++) begin         
         packet_sum += packets_per_sequence;
         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_N.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_S.trans_q.push_front(m_trans);
         end
         
         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_W.trans_q.push_front(m_trans);
         end
         
         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_E.trans_q.push_front(m_trans);
         end
         
         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_P.trans_q.push_front(m_trans);
         end

         fork
            seq_N.start(p_sequencer.sqr_N); 
            seq_S.start(p_sequencer.sqr_S); 
            seq_W.start(p_sequencer.sqr_W); 
            seq_E.start(p_sequencer.sqr_E); 
            seq_P.start(p_sequencer.sqr_P); 
         join

         if(j%10==0) begin
            `uvm_info("Virtual Sequence", $sformatf("packet num %d", packet_sum), UVM_LOW)
         end

         // wait for last packet finish
         #100000;
         
         // check scoreboard
         if(scb.exp_q_N.size()!=0 || scb.exp_q_E.size()!=0 || scb.exp_q_S.size()!=0 || scb.exp_q_W.size()!=0 || scb.exp_q_P.size()!=0) begin
            `uvm_fatal("router_virtual_sequence_0", "Packet Drop!!");
         end
         
      end

      
         
   endtask

   task generate_random_packet(packet_transaction m_trans);
      int p_tmp;
      bit [`HEADER_LEFT-1:0] header_left_rand;
      bit [`DATA_WIDTH-1:0] payload_flit_rand;

      // generate free packet
      p_tmp = $urandom % 101;
      if(p_tmp < p_free) begin
          m_trans.payload = new[1];
          m_trans.payload_len = $urandom % packet_max_len;
          m_trans.payload[0] = `DATA_WIDTH'b0;  //free flag
          return;
      end

      // // generate valid packet
      // m_trans.payload_len = $urandom % packet_max_len;
      // m_trans.dst_chip_id = `CHIP_ID;
      // m_trans.dst_x = $urandom % (`LOC_X_MAX + 1);
      // m_trans.dst_y = $urandom % (`LOC_Y_MAX + 1);
      // m_trans.final_bits = `FINAL_NONE;
      // m_trans.payload = new[m_trans.payload_len + 1];

      // header_left_rand = {$urandom} % (2**`HEADER_LEFT);
      // m_trans.payload[0] = { m_trans.dst_chip_id, m_trans.dst_x, m_trans.dst_y, m_trans.final_bits, m_trans.payload_len, header_left_rand};  //header
      
      // for(int i=0; i<m_trans.payload_len; i++) begin       //payload
      //     payload_flit_rand[`DATA_WIDTH-1:`DATA_WIDTH-32] = {$urandom};
      //     payload_flit_rand[`DATA_WIDTH-33:0] = {$urandom};
      //     m_trans.payload[i+1] = payload_flit_rand;
      // end
      m_trans.constraint_mode(0);
      m_trans.c_normal.constraint_mode(1);
      m_trans.randomize();

  endtask

endclass