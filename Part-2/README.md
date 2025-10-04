# Week 2 – BabySoC Fundamentals & Functional Modelling  
## Part 2: Hands-on Functional Modelling

---

## Table of Contents
1. [Reset Operation](#1-reset-operation)
2. [Clock Signal](#2-clock-signal)
3. [Dataflow Between Modules](#3-dataflow-between-modules)
4. [Simulation Logs](#4-simulation-logs)
5. [Conclusion and Observation](#5-conclusion-and-observation)

---

## 1. Reset Operation

### Signals displayed: -
```
reset, clk, cpu_out, cpu_to_mem, mem_out, mem_to_cpu, mem_to_periph, periph_out, periph_to_cpu
```

### GTKWave: -  
<img width="1204" height="771" alt="reset_operation" src="https://github.com/user-attachments/assets/9caca34b-14bf-4f93-af44-065d6c6cad09" />


### Observation: -
When reset is high, all module outputs initialize to 0, while the clock continues to toggle. This confirms proper reset behavior of CPU, Memory, and Peripheral modules.

---

## 2. Clock Signal

### Signals displayed: -
```
clk, cpu_out, cpu_to_mem
```

### GTKWave: -  
<img width="1204" height="771" alt="clock_signal" src="https://github.com/user-attachments/assets/744533f4-23d7-4e8d-a4b8-6c4c03dd518e" />


### Observation: -
Clock toggles regularly. CPU output (cpu_out) increments on each rising edge of the clock, demonstrating correct synchronous operation.

---

## 3. Dataflow Between Modules

### Signals displayed: -
```
cpu_to_mem, mem_out, mem_to_cpu, mem_to_periph, periph_out, periph_to_cpu
```

### GTKWave: - 
<img width="1204" height="771" alt="dataflow" src="https://github.com/user-attachments/assets/10c8731d-0613-4a9b-a690-5ee3081a92b0" />


### Observation: -
CPU sends data to Memory (cpu_to_mem), Memory adds 1 (mem_out, mem_to_cpu), Peripheral adds 2 (mem_to_periph, periph_out, periph_to_cpu). This shows correct propagation of data through all modules.

---

## 4. Simulation Logs

Commands used to compile and simulate BabySoC:

```
bash
# Compile BabySoC modules
iverilog -o baby_soc_tb.vvp baby_soc_tb.v cpu.v memory.v peripheral.v baby_soc.v
```

### Run simulation
```
vvp baby_soc_tb.vvp
```

### Output: -
**Uploaded as** ***[baby_soc.vcd](baby_soc.vcd)***

## 5. Conclusion and Observation

**Observation: -**  
The BabySoC functional modelling correctly demonstrates the expected behavior of all modules. During reset, all outputs initialize to zero while the clock continues toggling. CPU, Memory, and Peripheral data propagate correctly, showing proper communication between modules. Waveform analysis confirms synchronous operation and accurate dataflow.  

**Conclusion: -**  
This hands-on exercise strengthens understanding of SoC fundamentals, prepares for more advanced RTL design and verification, and builds confidence in interpreting simulation waveforms for system-level debugging. It validates the BabySoC design workflow and ensures that CPU, Memory, and Peripheral modules function as intended.

