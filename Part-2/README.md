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
**Uploaded as** ***[baby_soc.vcd]((Module-LevelSimulation)FunctionalModelingofBabySoC/baby_soc.vcd)***

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
- **Uploaded as** ***[pre_synth_sim.vcd](pre_synth_sim.vcd)***

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

| Signal Name        | Description                                         | Observed Behavior / Values                                  | Notes                                           |
|-------------------|-----------------------------------------------------|-------------------------------------------------------------|------------------------------------------------|
| reset             | Global reset signal                                 | 1 → All outputs initialized to 0                             | Active high reset                               |
| clk               | System clock                                        | Toggles regularly (~50% duty cycle)                          | Drives CPU synchronous operations              |
| cpu_out           | CPU output register                                 | Increments on each rising edge of `clk`                      | Shows correct synchronous increment            |
| cpu_to_mem        | Data bus from CPU to Memory                         | Values match CPU computations                                 | Correct propagation from CPU to Memory         |
| mem_out           | Memory output after processing CPU data            | Memory adds 1 to received CPU data                            | Confirms Memory functional correctness         |
| mem_to_cpu        | Memory response to CPU                              | Updated memory value returned to CPU                          | Matches expected memory behavior               |
| mem_to_periph     | Memory output to Peripheral module                  | Data forwarded to Peripheral                                   | Confirms inter-module communication            |
| periph_out        | Peripheral processed data                            | Adds 2 to received value                                       | Shows Peripheral module computation            |
| periph_to_cpu     | Peripheral feedback to CPU                           | Returns final processed value to CPU                           | Confirms closed-loop dataflow                  |

### 5.2 Part 2 – Pre-Synthesis System-Level Simulation

| Signal Name        | Description                                         | Observed Behavior / Values                                  | Notes                                           |
|-------------------|-----------------------------------------------------|-------------------------------------------------------------|------------------------------------------------|
| CLK               | High-speed system clock                              | Regular square wave, consistent period                       | Drives all synchronous modules                 |
| REF               | Reference clock                                     | Slower periodic pulses                                       | Multi-clock domain coordination                |
| END_CP            | Completion flag for CPU pipeline                     | 1 when CPU completes instruction program                     | Monitors CPU status                             |
| END_VCO           | Sub-module completion flag                           | 1 when VCO or DAC block ready                                 | Timing coordination signal                      |
| reset             | Global reset signal                                  | System initialized to 0 on high reset                         | Prepares system for operation                  |
| RV_TO_DAC[9:0]    | 10-bit data bus to DAC                               | Ramp → Peak → Oscillation sequence (e.g., 903 → 946 → 903±r11) | Represents digital waveform input to DAC      |
| VCO_IN            | Control input for voltage-controlled module         | Observed baseline 0 during pre-synth simulation              | Can vary for future analog control             |
| VREFH             | Voltage reference for DAC                             | Constant high reference voltage                               | Ensures DAC operates within correct range     |
| OUT               | DAC analog output                                     | ~0.882 V → 0.925 V (for r17 = 903 → 946)                     | Converted from 10-bit digital input            |
| CPU_TO_MEM        | CPU to Memory data bus                                | Matches instruction program execution                         | Shows correct propagation at system-level      |
| MEM_TO_CPU        | Memory to CPU feedback                                | Updated values returned after computation                     | Confirms CPU-memory interaction                |
| MEM_TO_PERIPH     | Memory to Peripheral data bus                          | Forwarded values processed                                     | Correct multi-module data propagation         |
| PERIPH_OUT        | Peripheral processed output                             | DAC-ready values                                             | Demonstrates peripheral computation correctness|
| PERIPH_TO_CPU     | Feedback path from Peripheral to CPU                  | Final data reflected back                                     | Ensures closed-loop operation                  |

### 5.3 Notes on Signal Tables

1. **Module-Level Signals (5.1)** focus on **functional correctness** and **dataflow** between CPU, Memory, and Peripheral.  
2. **System-Level Signals (5.2)** include **mixed-signal outputs** (DAC), **multi-clock domains**, and **completion/control flags**.  
3. Observing these signals ensures **correct operation at both module and system levels**, and builds confidence before actual hardware synthesis.  
4. Values shown are derived from simulation [.vcd](pre_synth_sim.vcd) files in **GTKWave**.

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


