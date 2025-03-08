// make some info priority lower (such as tr.compare()[MISCMP])
// clean the log output

  class demoter extends uvm_report_catcher;
    `uvm_object_utils(demoter)
    function new(string name="miscmp_error_demoter");
      super.new(name);
    endfunction
 
    function action_e catch();
      if(get_id() == "MISCMP") begin
        return (get_verbosity() <= UVM_HIGH) ? (CAUGHT) : (THROW); 
      end
      return THROW;
    endfunction
 
  endclass