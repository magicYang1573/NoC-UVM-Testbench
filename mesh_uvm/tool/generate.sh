rm ../dut/mesh/mesh.v
rm ../tb/mesh_env.sv
rm ../tb/mesh_virtual_sequencer.sv
rm ../tb/mesh_virtual_sequence_random.sv
rm ../tb/top_tb.sv
rm ../tb/mesh_scoreboard.sv
python3 pyhp.py ../dut/mesh/mesh_py.v >> ../dut/mesh/mesh.v
python3 pyhp.py ../tb/mesh_env_py.sv >> ../tb/mesh_env.sv
python3 pyhp.py ../tb/mesh_virtual_sequencer_py.sv >> ../tb/mesh_virtual_sequencer.sv
python3 pyhp.py ../tb/mesh_virtual_sequence_random_py.sv >> ../tb/mesh_virtual_sequence_random.sv
python3 pyhp.py ../tb/top_tb_py.sv >> ../tb/top_tb.sv
python3 pyhp.py ../tb/mesh_scoreboard_py.sv >> ../tb/mesh_scoreboard.sv