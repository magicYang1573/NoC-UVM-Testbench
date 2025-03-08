<%
     X_SIZE = 5
     Y_SIZE = 5
     router_queue = []
     for i in range(0,X_SIZE):
          for j in range(0,Y_SIZE):
               router_this = str(i) + '_' + str(j)
               router_queue.append(router_this)
%>
class mesh_virtual_sequencer extends uvm_sequencer;
    <%
    print('')
    for r in router_queue:
        print("    router_sequencer sqr_{};".format(r,r))
    %>

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 
     
    `uvm_component_utils(mesh_virtual_sequencer)

endclass