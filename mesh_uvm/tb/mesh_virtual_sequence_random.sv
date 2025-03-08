
// this is a random sequence, which generate PACKET_NUM random packets for one sequence
class mesh_virtual_sequence_random extends uvm_sequence;
   int packets_num;    
   int p_free;     //sequence为空闲时候的概率,0-100
   int packet_max_len;     //均匀分布
   int packet_sum;
   packet_transaction m_trans;
   
   `uvm_object_utils(mesh_virtual_sequence_random)
   `uvm_declare_p_sequencer(mesh_virtual_sequencer) 

   function new(string name = "mesh_virtual_sequence_random");
      super.new(name);
   endfunction

   virtual task body();
      int packets_per_sequence = 100;
      
  router_sequence seq_0_0;
  router_sequence seq_0_1;
  router_sequence seq_0_2;
  router_sequence seq_0_3;
  router_sequence seq_0_4;
  router_sequence seq_1_0;
  router_sequence seq_1_1;
  router_sequence seq_1_2;
  router_sequence seq_1_3;
  router_sequence seq_1_4;
  router_sequence seq_2_0;
  router_sequence seq_2_1;
  router_sequence seq_2_2;
  router_sequence seq_2_3;
  router_sequence seq_2_4;
  router_sequence seq_3_0;
  router_sequence seq_3_1;
  router_sequence seq_3_2;
  router_sequence seq_3_3;
  router_sequence seq_3_4;
  router_sequence seq_4_0;
  router_sequence seq_4_1;
  router_sequence seq_4_2;
  router_sequence seq_4_3;
  router_sequence seq_4_4;

  seq_0_0 = router_sequence::type_id::create("seq_0_0");
  seq_0_1 = router_sequence::type_id::create("seq_0_1");
  seq_0_2 = router_sequence::type_id::create("seq_0_2");
  seq_0_3 = router_sequence::type_id::create("seq_0_3");
  seq_0_4 = router_sequence::type_id::create("seq_0_4");
  seq_1_0 = router_sequence::type_id::create("seq_1_0");
  seq_1_1 = router_sequence::type_id::create("seq_1_1");
  seq_1_2 = router_sequence::type_id::create("seq_1_2");
  seq_1_3 = router_sequence::type_id::create("seq_1_3");
  seq_1_4 = router_sequence::type_id::create("seq_1_4");
  seq_2_0 = router_sequence::type_id::create("seq_2_0");
  seq_2_1 = router_sequence::type_id::create("seq_2_1");
  seq_2_2 = router_sequence::type_id::create("seq_2_2");
  seq_2_3 = router_sequence::type_id::create("seq_2_3");
  seq_2_4 = router_sequence::type_id::create("seq_2_4");
  seq_3_0 = router_sequence::type_id::create("seq_3_0");
  seq_3_1 = router_sequence::type_id::create("seq_3_1");
  seq_3_2 = router_sequence::type_id::create("seq_3_2");
  seq_3_3 = router_sequence::type_id::create("seq_3_3");
  seq_3_4 = router_sequence::type_id::create("seq_3_4");
  seq_4_0 = router_sequence::type_id::create("seq_4_0");
  seq_4_1 = router_sequence::type_id::create("seq_4_1");
  seq_4_2 = router_sequence::type_id::create("seq_4_2");
  seq_4_3 = router_sequence::type_id::create("seq_4_3");
  seq_4_4 = router_sequence::type_id::create("seq_4_4");

      
      
      for(int j=0;j<packets_num/packets_per_sequence;j++) begin
         
         packet_sum += packets_per_sequence;
         
         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_0_0.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_0_1.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_0_2.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_0_3.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_0_4.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_1_0.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_1_1.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_1_2.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_1_3.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_1_4.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_2_0.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_2_1.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_2_2.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_2_3.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_2_4.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_3_0.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_3_1.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_3_2.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_3_3.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_3_4.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_4_0.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_4_1.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_4_2.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_4_3.trans_q.push_front(m_trans);
         end

         for(int i=0;i<packets_per_sequence;i++) begin
            m_trans = new("tr");
            generate_random_packet(m_trans);
            seq_4_4.trans_q.push_front(m_trans);
         end


         

         fork
            
            seq_0_0.start(p_sequencer.sqr_0_0); 
            seq_0_1.start(p_sequencer.sqr_0_1); 
            seq_0_2.start(p_sequencer.sqr_0_2); 
            seq_0_3.start(p_sequencer.sqr_0_3); 
            seq_0_4.start(p_sequencer.sqr_0_4); 
            seq_1_0.start(p_sequencer.sqr_1_0); 
            seq_1_1.start(p_sequencer.sqr_1_1); 
            seq_1_2.start(p_sequencer.sqr_1_2); 
            seq_1_3.start(p_sequencer.sqr_1_3); 
            seq_1_4.start(p_sequencer.sqr_1_4); 
            seq_2_0.start(p_sequencer.sqr_2_0); 
            seq_2_1.start(p_sequencer.sqr_2_1); 
            seq_2_2.start(p_sequencer.sqr_2_2); 
            seq_2_3.start(p_sequencer.sqr_2_3); 
            seq_2_4.start(p_sequencer.sqr_2_4); 
            seq_3_0.start(p_sequencer.sqr_3_0); 
            seq_3_1.start(p_sequencer.sqr_3_1); 
            seq_3_2.start(p_sequencer.sqr_3_2); 
            seq_3_3.start(p_sequencer.sqr_3_3); 
            seq_3_4.start(p_sequencer.sqr_3_4); 
            seq_4_0.start(p_sequencer.sqr_4_0); 
            seq_4_1.start(p_sequencer.sqr_4_1); 
            seq_4_2.start(p_sequencer.sqr_4_2); 
            seq_4_3.start(p_sequencer.sqr_4_3); 
            seq_4_4.start(p_sequencer.sqr_4_4); 

         join

         // if(j%100==0) begin
         //    $display("INFO: packet num %d", packet_sum);
         // end
         $display("INFO: packet num %d", packet_sum);
      end

      // wait for last packet finish
      #100000;
         
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