
`include "dynamic_node_top_wrap.v"

<%
    X_SIZE = 5
    Y_SIZE = 5
    router_queue = []
    for i in range(0,X_SIZE):
          for j in range(0,Y_SIZE):
               router_this = str(i) + '_' + str(j)
               router_queue.append(router_this)
%>


module mesh (
    input clk,
    input reset_in,
<%
print('')
for i in range(0,X_SIZE):
    for j in range(0,Y_SIZE):
        r = str(i) + '_' + str(j)
        print('    input [`DATA_WIDTH-1:0] data_in_p_' + r + ',')
        print('    input  valid_in_p_' + r + ',')
        print('    input  yummy_in_p_' + r + ',')
        
        print('    output [`DATA_WIDTH-1:0] data_out_p_' + r + ',')
        print('    output  valid_out_p_' + r + ',')
        print('    output  yummy_out_p_' + r + ',')

        if i==X_SIZE-1 and j==Y_SIZE-1:
            print('    output thanks_in_p_' + r)
        else:
            print('    output thanks_in_p_' + r + ',')
        print('')
%>
);

<%
for r in router_queue:
    print('    wire [`DATA_WIDTH-1:0] data_out_n_'+ r + ';')
    print('    wire [`DATA_WIDTH-1:0] data_out_e_'+ r + ';')
    print('    wire [`DATA_WIDTH-1:0] data_out_s_'+ r + ';')
    print('    wire [`DATA_WIDTH-1:0] data_out_w_'+ r + ';')
    print('')
    print('    wire valid_out_n_'+ r + ';')
    print('    wire valid_out_e_'+ r + ';')
    print('    wire valid_out_s_'+ r + ';')
    print('    wire valid_out_w_'+ r + ';')
    print('')
    print('    wire yummy_out_n_'+ r + ';')
    print('    wire yummy_out_e_'+ r + ';')
    print('    wire yummy_out_s_'+ r + ';')
    print('    wire yummy_out_w_'+ r + ';')
    print('')

%>
<%
for i in range(0,X_SIZE):
    for j in range(0,Y_SIZE):
        router_this = str(i) + '_' + str(j)
        print('    dynamic_node_top_wrap router_' + router_this + '(\n' \
              '        .clk(clk),\n' \
              '        .reset_in(reset_in),\n' \
        )
        
        print('        .myLocX(8\'d{}),'.format(i))
        print('        .myLocY(8\'d{}),'.format(j))
        print('        .myChipID(14\'d0),\n')

        if j==0:
            print('        .dataIn_N(`DATA_WIDTH\'b0),\n'\
                '        .yummyIn_N(1\'b0),\n'\
                '        .validIn_N(1\'b0),\n'\
                '        .dataOut_N(),\n'\
                '        .yummyOut_N(),\n'\
                '        .validOut_N(),\n' \
            )
        else:
            router_up = str(i) + '_' + str(j-1)
            print('        .dataIn_N(data_out_s_' + router_up + '),\n'\
                '        .yummyIn_N(yummy_out_s_' + router_up + '),\n'\
                '        .validIn_N(valid_out_s_' + router_up + '),\n'\
                '        .dataOut_N(data_out_n_' + router_this + '),\n'\
                '        .yummyOut_N(yummy_out_n_' + router_this + '),\n'\
                '        .validOut_N(valid_out_n_' + router_this + '),\n' \
            )

        if j==Y_SIZE-1:
            print('        .dataIn_S(`DATA_WIDTH\'b0),\n'\
                '        .yummyIn_S(1\'b0),\n'\
                '        .validIn_S(1\'b0),\n'\
                '        .dataOut_S(),\n'\
                '        .yummyOut_S(),\n'\
                '        .validOut_S(),\n' \
            )
        else:
            router_down = str(i) + '_' + str(j+1)
            print('        .dataIn_S(data_out_n_' + router_down + '),\n'\
                '        .yummyIn_S(yummy_out_n_' + router_down + '),\n'\
                '        .validIn_S(valid_out_n_' + router_down + '),\n'\
                '        .dataOut_S(data_out_s_' + router_this + '),\n'\
                '        .yummyOut_S(yummy_out_s_' + router_this + '),\n'\
                '        .validOut_S(valid_out_s_' + router_this + '),\n' \
            )

        if i==0:
            print('        .dataIn_W(`DATA_WIDTH\'b0),\n'\
                '        .yummyIn_W(1\'b0),\n'\
                '        .validIn_W(1\'b0),\n'\
                '        .dataOut_W(),\n'\
                '        .yummyOut_W(),\n'\
                '        .validOut_W(),\n' \
            )
        else:
            router_left = str(i-1) + '_' + str(j)
            print('        .dataIn_W(data_out_e_' + router_left + '),\n'\
                '        .yummyIn_W(yummy_out_e_' + router_left + '),\n'\
                '        .validIn_W(valid_out_e_' + router_left + '),\n'\
                '        .dataOut_W(data_out_w_' + router_this + '),\n'\
                '        .yummyOut_W(yummy_out_w_' + router_this + '),\n'\
                '        .validOut_W(valid_out_w_' + router_this + '),\n' \
            )

        if i==X_SIZE-1:
            print('        .dataIn_E(`DATA_WIDTH\'b0),\n'\
                '        .yummyIn_E(1\'b0),\n'\
                '        .validIn_E(1\'b0),\n'\
                '        .dataOut_E(),\n'\
                '        .yummyOut_E(),\n'\
                '        .validOut_E(),\n' \
            )
        else:
            router_right = str(i+1) + '_' + str(j)
            print('        .dataIn_E(data_out_w_' + router_right + '),\n'\
                '        .yummyIn_E(yummy_out_w_' + router_right + '),\n'\
                '        .validIn_E(valid_out_w_' + router_right + '),\n'\
                '        .dataOut_E(data_out_e_' + router_this + '),\n'\
                '        .yummyOut_E(yummy_out_e_' + router_this + '),\n'\
                '        .validOut_E(valid_out_e_' + router_this + '),\n' \
            )

        print('        .dataIn_P(data_in_p_' + router_this + '),\n'\
            '        .yummyIn_P(yummy_in_p_' + router_this + '),\n'\
            '        .validIn_P(valid_in_p_' + router_this + '),\n'\
            '        .dataOut_P(data_out_p_' + router_this + '),\n'\
            '        .yummyOut_P(yummy_out_p_' + router_this + '),\n'\
            '        .validOut_P(valid_out_p_' + router_this + '),\n' \
        )

        print('        .thanksIn_P(thanks_in_p_' + router_this + ')\n')
        print('    );\n')
%>


endmodule

