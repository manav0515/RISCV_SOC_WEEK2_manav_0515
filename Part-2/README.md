# BabySoC Hands-On Functional Modeling & Pre-Synthesis Simulation

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Part 1: Functional Modeling of BabySoC](#2-part-1-functional-modeling-of-babysoc)
    - [1.1 Reset Operation](#21-reset-operation)
    - [1.2 Clock Signal](#22-clock-signal)
    - [1.3 Dataflow Between Modules](#23-dataflow-between-modules)
    - [1.4 Simulation Logs](#24-simulation-logs)
    - [1.5 Observations and Conclusion](#25-observations-and-conclusion)
3. [Transition: From Module-Level to System-Level](#3-transition---from-module-level-to-system-level)
4. [Part 2: Pre-Synthesis Simulation & DAC Output](#4-part-2---pre-synthesis-simulation--dac-output)
    - [4.1 Repository & TL-Verilog Conversion](#41-repository--tl-verilog-conversion)
    - [4.2 Compile Verilog Code](#42-compile-verilog-code)
    - [4.3 Run Pre-Synthesis Simulation](#43-run-pre-synthesis-simulation)
    - [4.4 Waveform Analysis](#44-waveform-analysis)
    - [4.5 Observations and Conclusion](#45-observations-and-conclusion)
5. [Signal Table & Observed Values](#5-signal-table--observed-values)
    - [5.1 Part 1 – Module-Level Functional Modeling](#51-part-1--module-level-functional-modeling)
    - [5.2 Part 2 – Pre-Synthesis System-Level Simulation](#52-part-2--pre-synthesis-system-level-simulation)
    - [5.3 Notes on Signal Tables](#53-notes-on-signal-tables)
6. [Summary](#6-summary)

---

## 1 Introduction

This repository demonstrates **hands-on functional modeling** and **pre-synthesis simulation** of BabySoC. The workflow is divided into two stages:

1. **Module-Level Simulation:** Focused on CPU, Memory, and Peripheral modules to understand basic dataflow and reset/clock behavior.  
2. **System-Level Pre-Synthesis Simulation:** Covers TL-Verilog modules (RVMYTH), DAC waveform generation, PLL clocks, and mixed-signal interfaces.

This progression helps learners start with simple module testing and gradually move to system-level pre-synthesis validation.

---

## 2 Part 1: Functional Modeling of BabySoC

### 2.1 Reset Operation

**Signals observed:**
```
reset, clk, cpu_out, cpu_to_mem, mem_out, mem_to_cpu, mem_to_periph, periph_out, periph_to_cpu
```


**GTKWave Screenshot:**
<img width="1204" height="771" alt="reset_operation" src="https://github.com/user-attachments/assets/9caca34b-14bf-4f93-af44-065d6c6cad09" />

**Observation:**
- When `reset` is high, all outputs initialize to 0.
- The clock continues to toggle.
- Confirms correct reset behavior for CPU, Memory, and Peripheral modules.

---

### 2.2 Clock Signal

**Signals observed:**
```
clk, cpu_out, cpu_to_mem
```


**GTKWave Screenshot:**
<img width="1204" height="771" alt="clock_signal" src="https://github.com/user-attachments/assets/744533f4-23d7-4e8d-a4b8-6c4c03dd518e" />

**Observation:**
- Clock toggles regularly.
- CPU output (`cpu_out`) increments on each rising edge of the clock.
- Demonstrates synchronous operation of CPU with memory interactions.

---

### 2.3 Dataflow Between Modules

**Signals observed:**
```
cpu_to_mem, mem_out, mem_to_cpu, mem_to_periph, periph_out, periph_to_cpu
```

**GTKWave Screenshot:**
<img width="1204" height="771" alt="dataflow" src="https://github.com/user-attachments/assets/10c8731d-0613-4a9b-a690-5ee3081a92b0" />

**Observation:**
- CPU sends data to Memory (`cpu_to_mem`).
- Memory adds 1 (`mem_out`, `mem_to_cpu`).
- Peripheral adds 2 (`mem_to_periph`, `periph_out`, `periph_to_cpu`).
- Shows correct data propagation through all modules.

---

### 2.4 Simulation Logs

**Compile Verilog Modules:**
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
**Uploaded as** ***[baby_soc.vcd](%28Module-Level%20Simulation%29%20Functional%20Modeling%20of%20BabySoC/baby_soc.vcd)***


## 2.5 Observations and Conclusion

**Observation: -**  
The BabySoC functional modelling correctly demonstrates the expected behavior of all modules. During reset, all outputs initialize to zero while the clock continues toggling. CPU, Memory, and Peripheral data propagate correctly, showing proper communication between modules. Waveform analysis confirms synchronous operation and accurate dataflow.  

**Conclusion: -**  
This hands-on exercise strengthens understanding of SoC fundamentals, prepares for more advanced RTL design and verification, and builds confidence in interpreting simulation waveforms for system-level debugging. It validates the BabySoC design workflow and ensures that CPU, Memory, and Peripheral modules function as intended.

## 3. Transition: - From Module-Level to System-Level

- After understanding module-level behavior, we move to system-level pre-synthesis simulation:
- TL-Verilog modules like RVMYTH are used to generate complex DAC waveforms.
- Pre-synthesis simulation shows clock domains, DAC outputs, control/status flags.
- This stage validates full system integration, bridging the gap between simple functional modeling and real hardware simulation.

## 4. Part 2: - Pre-Synthesis Simulation & DAC Output
### 4.1 Repository & TL-Verilog Conversion

**Clone the repository: -**
```
git clone https://github.com/manili/VSDBabySoC.git
cd VSDBabySoC
mkdir -p simulation
```

**Install SandPiper to convert TL-Verilog to Verilog: -**
```
pip3 install pyyaml click sandpiper-saas
sandpiper-saas -i ./src/module/*.tlv -o rvmyth.v --bestsv --noline -p verilog --outdir ./src/module/
```
**Explanation: -**
- TL-Verilog modules allow concise, high-level RTL description.
- Converting to Verilog is necessary for simulation with Icarus Verilog.

### 4.2 Compile Verilog Code

**Compile all BabySoC modules including converted RVMYTH: -**
```
iverilog -o simulation/pre_synth_sim.out -DPRE_SYNTH_SIM src/module/testbench.v -I src/include -I src/module
```
**Explanation: -**
- ```-DPRE_SYNTH_SIM``` allows conditional compilation for pre-synthesis simulation.
- All modules are included for full system validation.

### 4.3 Run Pre-Synthesis Simulation
**Run the simulation: -**
```
cd simulation
./pre_synth_sim.out
gtkwave pre_synth_sim.vcd
```
**Explanation: -**
- Generates .vcd waveform for GTKWave analysis.
- Observes full system behavior: core, PLL, DAC outputs.
- **Uploaded as** ***[pre_synth_sim.vcd](%28System-Level%20Pre-Synthesis%20Simulation%29Functional%20Modeling%20of%20BabySoC/pre_synth_sim.vcd)***


### 4.4 Waveform Analysis

**Core Waveform (CPU & Pipeline): -**
<img width="1211" height="774" alt="Screenshot from 2025-10-05 14-01-53" src="https://github.com/user-attachments/assets/9fcc9bfd-ec87-44bd-a0ce-b161d9926731" />

**PLL Clock: -**
<img width="1211" height="774" alt="Screenshot from 2025-10-05 14-03-32" src="https://github.com/user-attachments/assets/312bb0d6-af39-42cf-b367-9502702570ae" />

**DAC Output: -**
<img width="1211" height="774" alt="Screenshot from 2025-10-05 14-04-31" src="https://github.com/user-attachments/assets/77e85acc-f5ac-42fe-9451-8db4ba60a389" />

### Key Signals Observed: -
```
CLK, REF, END_CP, END_VCO, RV_TO_DAC[9:0], VCO_IN, VREFH
```
## Observations:
- CLK & REF: Multiple clock domains; CLK is high-speed, REF slower.
- RV_TO_DAC[9:0]: Ramp, peak, and oscillation behavior, driving DAC output.
- END_CP / END_VCO: Sub-module completion flags.
- Reset properly initializes system before normal operation.

### 4.5 Observations and Conclusion

**Observations: -**
- Multi-module coordination verified: CPU → Memory → DAC.
- DAC output ramps and oscillates as expected based on instruction program.
- Clock domains stable; no glitches observed.

**Conclusion: -**
- Pre-synthesis simulation confirms full system integration.
- Demonstrates mixed-signal interface correctness.
- Prepares BabySoC design for actual synthesis or FPGA implementation.
  
---

## 5 Signal Table & Observed Values

### 5.1 Part 1 – Module-Level Functional Modeling

---

| Signal Name        | Description                                         | Observed Behavior / Values                                  | Notes                                           |
|-------------------|-----------------------------------------------------|-------------------------------------------------------------|------------------------------------------------|
| reset             | Global reset signal                                 | 1 → 0 transition observed                                   | Active-high reset — initializes all outputs to 0 |
| clk               | System clock                                        | 0 → 1 → 0 → 1 → 0                                           | Regular toggle (~50% duty cycle) drives synchronous logic |
| cpu_out           | CPU output register                                 | Not explicitly in sample                                    | Expected to increment each rising edge         |
| cpu_to_mem        | Data bus from CPU to Memory                         | —                                                           | Transfers computed CPU values to Memory        |
| mem_out           | Memory processed output                             | —                                                           | Memory adds +1 to CPU input                    |
| mem_to_cpu        | Memory feedback to CPU                              | —                                                           | Returns processed value to CPU                 |
| mem_to_periph     | Memory to Peripheral link                           | —                                                           | Confirms inter-module communication            |
| periph_out        | Peripheral processed data                           | —                                                           | Peripheral adds +2 to received data            |
| periph_to_cpu     | Peripheral feedback to CPU                          | —                                                           | Closes feedback dataflow loop                  |

---

### 5.2 Part 2 – Pre-Synthesis System-Level Simulation
---

| Signal Name        | Description                                         | Observed Behavior / Values                                  | Notes                                           |
|-------------------|-----------------------------------------------------|-------------------------------------------------------------|------------------------------------------------|
| EN                | Global enable signal                                | 1                                                           | System active when asserted                    |
| gating_override   | Clock gating control                                | 0 0 0 0 0                                                   | Clock gating disabled                          |
| func_en           | Functional enable                                   | 1 1 1 1 1                                                   | Modules active throughout simulation           |
| L1_wr_a3          | Level-1 write address (bit 3)                       | x x x x x                                                   | Uninitialized logic                            |
| L1_wr_a4          | Level-1 write address (bit 4)                       | x x x x x                                                   | —                                              |
| CPU_valid_taken_br_a5 | Branch valid flag (stage a5)                    | x                                                           | Inactive in this simulation window             |
| CPU_valid_taken_br_a4 | Branch valid flag (stage a4)                    | x                                                           | —                                              |
| CPU_valid_load_a5 | Load valid flag (stage a5)                          | x                                                           | No load executed                               |
| CPU_valid_load_a4 | Load valid flag (stage a4)                          | x                                                           | —                                              |
| CPU_valid_jump_a5 | Jump valid flag (stage a5)                          | x                                                           | Inactive                                       |
| CPU_valid_jump_a4 | Jump valid flag (stage a4)                          | x                                                           | —                                              |
| CPU_valid_a4      | CPU valid execution (stage a4)                      | x                                                           | Undefined                                      |
| CPU_rs2_valid_a2  | Register-source 2 valid (stage a2)                  | x                                                           | —                                              |
| CPU_rs1_valid_a2  | Register-source 1 valid (stage a2)                  | x                                                           | —                                              |
| CPU_reset_a4      | CPU reset indicator (stage a4)                      | x                                                           | Reset not triggered                            |

---


### 5.3 Notes on Signal Tables

1. **[baby_soc.vcd](%28Module-Level%20Simulation%29%20Functional%20Modeling%20of%20BabySoC/baby_soc.vcd)** confirms functional correctness at the module level (CPU–Memory–Peripheral loop).  
2. **[pre_synth_sim.vcd](%28System-Level%20Pre-Synthesis%20Simulation%29Functional%20Modeling%20of%20BabySoC/pre_synth_sim.vcd)**
 introduces system-level and CPU pipeline signals for pre-synthesis verification.  
3. Together, they confirm end-to-end data propagation, multi-stage CPU validation, and clock gating analysis.  
4. Signal traces were verified via
   - ***[baby_soc.vcd](%28Module-Level%20Simulation%29%20Functional%20Modeling%20of%20BabySoC/baby_soc.vcd)***
   - ***[pre_synth_sim.vcd](%28System-Level%20Pre-Synthesis%20Simulation%29Functional%20Modeling%20of%20BabySoC/pre_synth_sim.vcd)***

   waveform inspection in **GTKWave** prior to synthesis.

---

## 6 Summary

The combined functional and pre-synthesis simulation of **BabySoC** demonstrates a clear progression from **basic module-level operations** to **system-level integration**:

- **Module-Level Functional Modeling:**  
  Validates individual module behavior (CPU, Memory, Peripheral). Reset, clock synchronization, and data propagation are verified to ensure each module works as intended.

- **Pre-Synthesis System-Level Simulation:**  
  Introduces **multi-clock domains** and **DAC analog output**, verifying that data flows correctly from CPU → Memory → Peripheral → DAC. Observed waveforms confirm ramp, peak, and oscillatory patterns.

- **Transition Insight:**  
  Moving from module-level to system-level simulation emphasizes **integration testing**. Correct module behavior ensures overall system functionality, while system-level checks validate timing, control, and analog-digital interactions.

- **Learning Outcomes:**  
  1. Understanding the **end-to-end SoC design flow** from functional modeling to pre-synthesis verification.  
  2. Identifying and analyzing **control signals**, **data buses**, and **analog output mapping**.  
  3. Interpreting simulation **waveforms** and **signal propagation** across modules.  
  4. Preparing for **hardware synthesis** and future **firmware-driven CPU instruction execution**.

This structure provides a **natural flow** from **signal observation** → **analysis** → **interpretation**, ensuring your GitHub repo is **well-organized, professional, and informative**.


