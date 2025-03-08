/*

1> this sequence read transactions from binary file, transfer that to transaction, send to sequence.
2> communicate with AFL through AFL-proxy
3> hardware grammar: transcations(packets) are sent to port(ESNWP) depending on the bytes

*/


class router_virtual_sequence_2 extends uvm_sequence;

    packet_transaction m_trans;

    bit[7:0] data[0:1000];    //buffer data from fuzzing input file
    int data_ptr;                   //point which data has be iterated
    int data_len;
    int packets_num;                

    `uvm_object_utils(router_virtual_sequence_2)
    `uvm_declare_p_sequencer(router_virtual_sequencer) 
 
    function new(string name = "router_virtual_sequence_2");
        super.new(name);
        data_ptr = 0;
    endfunction
 
    virtual task body();
        router_sequence seq_N;
        router_sequence seq_S;
        router_sequence seq_W;
        router_sequence seq_E;
        router_sequence seq_P;

        string file_name;
        int file_handle;
        int file_size;
        bit[7:0] next_byte;
        

        // read input files from fuzzing env
        file_name = "../input";
        file_handle = $fopen(file_name, "rb");
        if (file_handle == 0) begin
            $display("Error: could not open file %s", file_name);
            $finish;
        end
        // Read the binary data into the byte array
        data_len = $fread(data, file_handle);
        if (data_len == 0) begin
            $display("Error: could not read file %s", file_name);
            $finish;
        end
        else $display("Rrrrrrread file success, len: %d", data_len);
        
        // for (int i = 0; i < `FILE_BYTE_NUM; i++) begin
        //     $display("data[%0d] = %b", i, data[i]);
        // end
        $fclose(file_handle);


        seq_N = router_sequence::type_id::create("seq_N");
        seq_S = router_sequence::type_id::create("seq_S");
        seq_W = router_sequence::type_id::create("seq_W");
        seq_E = router_sequence::type_id::create("seq_E");
        seq_P = router_sequence::type_id::create("seq_P");
        
        // each transaction takes 5 bytes
        packets_num = data_len/5;
        for(int i=0;i<packets_num/5;i++) begin
            
            m_trans = new("tr");
            generate_next_transaction(m_trans);
            
            next_byte = get_one_byte();
            if(next_byte<51) 
                seq_N.trans_q.push_front(m_trans);
            else if(next_byte<102)
                seq_E.trans_q.push_front(m_trans);
            else if(next_byte<153)
                seq_S.trans_q.push_front(m_trans);
            else if(next_byte<204)
                seq_W.trans_q.push_front(m_trans);
            else
                seq_P.trans_q.push_front(m_trans);
        end

        fork
            seq_N.start(p_sequencer.sqr_N); 
            seq_S.start(p_sequencer.sqr_S); 
            seq_W.start(p_sequencer.sqr_W); 
            seq_E.start(p_sequencer.sqr_E); 
            seq_P.start(p_sequencer.sqr_P); 
        join
        
        #100000;
        
    endtask
 
    
    task generate_packet(packet_transaction m_trans, int free_flag, bit[`PAYLOAD_LEN-1:0] payload_len, bit[`CHIP_ID_WIDTH-1:0] dst_chip_id, bit[`XY_WIDTH-1:0] dst_x, bit[`XY_WIDTH-1:0] dst_y, bit[`FINAL_BITS-1:0] final_bits);
        bit [`HEADER_LEFT-1:0] header_left_rand;
        bit [`DATA_WIDTH-1:0] payload_flit_rand;
        
        // generate free packet
        if(free_flag) begin
            m_trans.payload = new[1];
            m_trans.payload_len = payload_len;
            m_trans.payload[0] = `DATA_WIDTH'b0;  //free flag
            return;
        end

        // generate valid packet
        m_trans.payload_len = payload_len;
        m_trans.dst_chip_id = dst_chip_id;
        m_trans.dst_x = dst_x;
        m_trans.dst_y = dst_y;
        m_trans.final_bits = final_bits;
        m_trans.payload = new[m_trans.payload_len + 1];
    
        header_left_rand = {$urandom} % (2**`HEADER_LEFT);
        m_trans.payload[0] = { m_trans.dst_chip_id, m_trans.dst_x, m_trans.dst_y, m_trans.final_bits, m_trans.payload_len, header_left_rand};  //header
        
        for(int i=0; i<m_trans.payload_len; i++) begin       //payload
            payload_flit_rand[`DATA_WIDTH-1:`DATA_WIDTH-32] = {$urandom};
            payload_flit_rand[`DATA_WIDTH-33:0] = {$urandom};
            m_trans.payload[i+1] = payload_flit_rand;
        end
    endtask

    //translate byte array to transaction
    //hardware grammar
    task generate_next_transaction(packet_transaction m_trans);
        int free_flag = 0;
        bit[`PAYLOAD_LEN-1:0] payload_len;
        bit[`XY_WIDTH-1:0] dst_x;
        bit[`XY_WIDTH-1:0] dst_y;
        bit[`FINAL_BITS-1:0] final_bits;
        bit[`CHIP_ID_WIDTH-1:0] dst_chip_id;
        bit[7:0] next_byte;

        // free_flag;
        next_byte = get_one_byte();
        if(next_byte<51) free_flag = 1;

        //payload len
        next_byte = get_one_byte();
        payload_len = next_byte % 20;

        //dst_x,y
        next_byte = get_one_byte();
        dst_x = next_byte % `LOC_X_MAX;
        next_byte = get_one_byte();
        dst_y = next_byte % `LOC_Y_MAX;

        final_bits = `FINAL_NONE;
        dst_chip_id = `CHIP_ID;

        generate_packet(m_trans, free_flag, payload_len, dst_chip_id, dst_x, dst_y, final_bits);
        
    endtask

    function bit[7:0] get_one_byte();
        bit[7:0] ret = data[data_ptr];
        data_ptr++;
        return ret;
    endfunction

 endclass
