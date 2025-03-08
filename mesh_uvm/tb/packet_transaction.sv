// NoC packet transaction
`include "define.h"
`ifndef PACKET_TRANSACTION__SV
`define PACKET_TRANSACTION__SV

class packet_transaction extends uvm_sequence_item;
    
    rand bit[`XY_WIDTH-1:0] dst_x;
    rand bit[`XY_WIDTH-1:0] dst_y;
    rand bit[`CHIP_ID_WIDTH-1:0] dst_chip_id;
    rand bit[`FINAL_BITS-1:0] final_bits;
    rand bit[`PAYLOAD_LEN-1:0] payload_len;     //除了header之外的flit长度?

    //储存包括 header flit 在内的所有 flits
    //payload[0]为0表示是free packet，此时payload_len表示空闲cycle num，driver需留出相应cycle的 free time

    rand bit[`DATA_WIDTH-1:0] payload[];        


    `uvm_object_utils_begin(packet_transaction)
        `uvm_field_int(dst_x, UVM_ALL_ON)
        `uvm_field_int(dst_y, UVM_ALL_ON)
        `uvm_field_int(dst_chip_id, UVM_ALL_ON)
        `uvm_field_int(final_bits, UVM_ALL_ON)
        `uvm_field_int(payload_len, UVM_ALL_ON)
        `uvm_field_array_int(payload, UVM_ALL_ON)
    `uvm_object_utils_end

    // random
    constraint c_normal {
        dst_x inside {[$:`LOC_X_MAX]};
        dst_y inside {[$:`LOC_Y_MAX]};
        dst_chip_id == `CHIP_ID;
        final_bits == `FINAL_NONE;
        payload_len inside {[$:`PACKET_LEN_MAX]};
        
        payload.size() == payload_len + 1;
        payload[0][`DATA_WIDTH-1:`HEADER_LEFT] == { dst_chip_id, dst_x, dst_y, final_bits, payload_len};
    }

    // packet send to port N/S
    // constraint c_NS {
    //     dst_x == `LOC_X ;
    //     dst_y inside {[$:`LOC_Y_MAX]};
    //     dst_chip_id == `CHIP_ID;
    //     final_bits == `FINAL_NONE;
    //     payload_len inside {[$:`PACKET_LEN_MAX]};
        
    //     payload.size() == payload_len + 1;
    //     payload[0][`DATA_WIDTH-1:`HEADER_LEFT] == { dst_chip_id, dst_x, dst_y, final_bits, payload_len};
    // }

    // // packet send to port P
    // constraint c_P {
    //     dst_x == `LOC_X ;
    //     dst_y == `LOC_Y ;
    //     dst_chip_id == `CHIP_ID;
    //     final_bits == `FINAL_NONE;
    //     payload_len inside {[$:`PACKET_LEN_MAX]};
        
    //     payload.size() == payload_len + 1;
    //     payload[0][`DATA_WIDTH-1:`HEADER_LEFT] == { dst_chip_id, dst_x, dst_y, final_bits, payload_len};
    // }

    
    function new(string name = "packet_transaction");
        super.new();
    endfunction

    // function print();
    //     $display("dst (%d,%d)\nPayload:",dst_x,dst_y);
    //     for(int i=0;i<payload.size();i++)
    //         $display(payload[i]);
    // endfunction

endclass

`endif
