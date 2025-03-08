# NoC-UVM-Testbench

## Introduction

This repository includes a UVM testbench for the NoC component in OpenPiton. [OpenPiton GitHub Repository](https://github.com/PrincetonUniversity/openpiton)

This is the UVM testbench used in our paper NoCFuzzer. It provides a detailed introduction to the NoC UVM testbench and introduce the development of the fuzzing framework based on this UVM testbench. If this testbench is helpful for your research, you can cite the following papers:

- [NoCFuzzer: Automating NoC Verification in UVM](https://ieeexplore.ieee.org/abstract/document/10601229/)

```bibtex
@article{ma2024nocfuzzer,
  title={NoCFuzzer: Automating NoC Verification in UVM},
  author={Ma, Ruiyang and Huang, Jiayi and Zhang, Shijian and Xie, Yuan and Luo, Guojie},
  journal={IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems},
  year={2024},
  publisher={IEEE}
}
```

- [An endeavor to industrialize hardware fuzzing: Automating NoC verification in UVM](https://ieeexplore.ieee.org/document/10546548/)

```bibtex
@inproceedings{ma2024endeavor,
  title={An endeavor to industrialize hardware fuzzing: Automating NoC verification in UVM},
  author={Ma, Ruiyang and Zhao, Huatao and Huang, Jiayi and Zhang, Shijian and Luo, Guojie},
  booktitle={2024 Design, Automation \& Test in Europe Conference \& Exhibition (DATE)},
  pages={1--2},
  year={2024},
  organization={IEEE}
}
```

## Router Testbench

Located in `/router_uvm`

The `Makefile` is the running script for the VCS simulator.

## Mesh Testbench

Located in `/mesh_uvm`

The script in `tool/generate.sh` first generates the mesh design with size M\*N and the corresponding UVM testbench. Run the UVM testbench using the `Makefile` with the VCS simulator.