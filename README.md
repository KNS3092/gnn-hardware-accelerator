# gnn-hardware-accelerator
Verilog implementation of a Graph Neural Network (GNN) accelerator for task scheduling on heterogeneous cores, including synthesis, APR, and power analysis.

# Verilog-Based GNN Accelerator

This repository contains a complete Graph Neural Network (GNN) hardware accelerator developed in Verilog for task scheduling in heterogeneous multicore systems. Built as part of ECE 755 (Spring 2025) at UW–Madison, the project covers all stages from RTL to physical design and post-layout power/performance estimation.

## 🔍 Problem Statement

The accelerator is designed to map tasks in an application onto either ARM Cortex-A53 or A57 cores. It uses a GNN where each task is modeled as a node with its own neural network. The network learns to minimize execution time by intelligently selecting the target core per task.

## 📐 High-Level Architecture

Each node (task) includes:
- **Feature Aggregator**: Combines features from neighboring nodes.
- **MAC1**: First-layer multiply-accumulate unit.
- **ReLU**: Activation function after hidden layer.
- **MAC2**: Final output computation block.

All layers operate in a pipelined fashion.

## 🛠️ Modules

- `top.sv`: Top-level GNN module
- `aggregator.sv`: Aggregates node and neighbor features
- `mac1.sv`: First-layer parallel MAC block
- `relu.sv`: Applies ReLU using sign-bit logic
- `mac2.sv`: Final layer computing core scores

## ⚙️ Toolchain

- **Simulation**: ModelSim / QuestaSim
- **Synthesis**: Synopsys Design Compiler (7nm tech)
- **Place & Route**: Cadence Innovus
- **Post-Layout Power/Timing**: Synopsys PrimeTime
- **Layout View**: Cadence Virtuoso

## 🧠 Optimizations

- **Deep Pipelining**: Improves critical path and throughput
- **Clock Gating**: Applied and later removed due to timing issues in MS6
- **Bit-Width Pruning**: Reduced intermediate signal widths to minimize area/power
- **Sign-Bit ReLU**: Area-optimized ReLU by using sign-bit check
- **Modular Design**: Clean split of functional blocks for reuse and synthesis optimization

## 📊 Final Results

| Metric          | Value         |
|-----------------|---------------|
| Area            | 0.098 mm²     |
| Max Freq        | 869.56 MHz    |
| Min Latency     | 5.12 ns       |
| Power           | 3.07 mW       |
| Energy          | 15.71 pJ      |
| EDAP            | 7.91 pJ·ns·mm²|

## 👥 Authors

- Kaushik Shroff
- Shraddha Singh

Spring 2025, University of Wisconsin–Madison  
ECE 755: VLSI Systems Design
