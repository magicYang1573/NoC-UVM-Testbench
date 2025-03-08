<%
     X_SIZE = 5
     Y_SIZE = 5
     router_queue = []
     for i in range(0,X_SIZE):
          for j in range(0,Y_SIZE):
               router_this = str(i) + '_' + str(j)
               router_queue.append(router_this)
%>
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
      <%
      print('')
      for r in router_queue:
         print("  router_sequence seq_{};".format(r))
      
      print('')
      for r in router_queue:
         print("  seq_{} = router_sequence::type_id::create(\"seq_{}\");".format(r,r))
      %>
      
      
      for(int j=0;j<packets_num/packets_per_sequence;j++) begin
         
         packet_sum += packets_per_sequence;
         <%
            print('')
            for r in router_queue:
               print("         for(int i=0;i<packets_per_sequence;i++) begin")
               print("            m_trans = new(\"tr\");")
               print("            generate_random_packet(m_trans);")
               print("            seq_{}.trans_q.push_front(m_trans);".format(r))
               print("         end")
               print('')
         %>
         

         fork
            <%
               print('')
               for r in router_queue:
                  print("            seq_{}.start(p_sequencer.sqr_{}); ".format(r,r))
            %>
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