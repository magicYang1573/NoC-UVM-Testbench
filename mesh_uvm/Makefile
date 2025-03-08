VCS_HOME=/usr/synopsys/vcs/O-2018.09-SP2
UVM_HOME=/usr/synopsys/vcs/O-2018.09-SP2/etc/uvm
plat=amd64

COV_FLAG=-cm line+cond+tgl+fsm+branch+assert
# COV_FLAG=
COMP_FLAG=+vc -sverilog ${UVM_HOME}/src/dpi/uvm_dpi.cc ${VCS_HOME}/${plat}/lib/libucapi.a -ldl -lm -lpthread -lstdc++ -CFLAGS -DVCS 

all:
	rm -f ./tb-output.txt
	touch ./tb-output.txt
	make comp sim gencov

comp:
	rm -f ./tb-output.txt
	touch ./tb-output.txt
	UVM_HOME=${UVM_HOME} vcs -full64 ${COV_FLAG} ${COMP_FLAG} -timescale=1ns/1ps -f filelist.f +plusarg_save +ntb_random_seed_automatic

sim:
	./simv ${COV_FLAG} >> ./tb-output.txt


gencov:
	urg -dir simv.vdb

clean:
	rm -f simv.daidir/.vcs.timestamp

cleanall:
	rm -rf csrc/ simv.daidir/ simv.vdb/ urgReport/
	rm -f simv tr_db.log ucli.key vc_hdrs.h cm.log tb-output.txt simulation.log vcs.log