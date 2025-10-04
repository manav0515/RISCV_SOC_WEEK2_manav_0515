# 🧩 Week 2 – BabySoC Fundamentals & Functional Modelling  
### **Part 1: Conceptual Understanding**

---

## 📑 Table of Contents
1. [What is a System-on-Chip (SoC)?](#1-what-is-a-system-on-chip-soc)
2. [Components of a Typical SoC](#2-components-of-a-typical-soc)
3. [Why BabySoC is a Simplified Learning Model](#3-why-babysoc-is-a-simplified-learning-model)
4. [Role of Functional Modelling in SoC Design Flow](#4-role-of-functional-modelling-in-soc-design-flow)
5. [Summary](#5-summary)
6. [Deliverable](#deliverable)
7. [References](#-references)
   
---

## 1. What is a System-On-Chip(SOC) ?

A **System-on-Chip (SoC)** is an integrated circuit that consolidates all the essential components of a computing system—such as a processor core, memory, input/output interfaces, and control logic—onto a **single silicon die**.  

Unlike traditional systems where these components exist on separate boards or chips, an SoC offers **compactness, high performance, low power consumption, and reduced communication delay**.  

SoCs are found in almost every modern device including **smartphones, IoT sensors, routers, and embedded controllers**. They represent the convergence of **hardware, firmware, and communication subsystems** into one integrated chip.

---

## 2. Components of a Typical SoC

A typical SoC consists of multiple blocks that communicate through standardized interconnects:

### **a. Processor / CPU Core**
- The **brain** of the SoC.  
- Executes instructions, handles control signals, and manages system-level tasks.  
- Common architectures: **RISC-V**, **ARM**, or **MIPS**.  
- Includes ALU, control unit, and internal registers.

### **b. Memory Subsystem**
- Stores instructions and data for the CPU.  
- Divided into:  
  - **Volatile memory (SRAM, DRAM)** – for temporary runtime data.  
  - **Non-volatile memory (ROM, Flash)** – for permanent firmware and boot programs.

### **c. Peripherals**
- Provide interfaces to the external world.  
- Examples: **UART**, **SPI**, **I2C**, **Timers**, **GPIOs**, **ADC/DACs**.  
- Enable communication with external sensors and devices.

### **d. Interconnect / Bus System**
- Acts as the **communication backbone** of the SoC.  
- Ensures smooth data transfer between CPU, memory, and peripherals.  
- Common bus standards: **AMBA (AHB/APB)** and **Wishbone**.  
- Handles arbitration, timing, and bandwidth sharing.

### **e. Clock and Reset Circuits**
- **Clock** provides the timing reference for synchronous operations.  
- **Reset** initializes all modules into a known startup state.  

---

## 3. Why BabySoC is a Simplified Learning Model

The **BabySoC** used in the VSD Journey is a **simplified representation** of a real-world SoC, designed for educational and functional understanding rather than complexity.  

**Key reasons it’s ideal for learning:**
- Demonstrates how CPU, memory, and peripherals interact through buses.  
- Avoids the overhead of complex instruction pipelines and multi-core setups.  
- Easy to simulate using **open-source tools (Icarus Verilog, GTKWave)**.  
- Encourages experimentation with resets, clocks, and signal dataflow.  

The BabySoC thus helps students **visualize SoC-level interactions** and **build confidence** before diving into advanced RTL or physical design topics.

---

## 4. Role of Functional Modelling in SoC Design Flow

**Functional Modelling** is performed **before RTL and physical design** stages.  
Its main goal is to ensure that all blocks behave correctly as per the architecture specification.

### **Purpose:**
- Validate the **logical behavior** of modules.  
- Detect design or communication errors **early** in the flow.  
- Visualize **waveforms** to study clock, reset, and data movement.  
- Build confidence in the SoC structure before committing to synthesis.

### **Tools Used:**
- **Icarus Verilog (iverilog):** Compiles and simulates Verilog designs.  
- **GTKWave:** Displays `.vcd` (Value Change Dump) files to view signal transitions.  

**Example Workflow:**
1. Compile BabySoC Verilog modules with `iverilog`.  
2. Run simulation to generate waveform output.  
3. Analyze the `.vcd` file using `gtkwave` for reset, clock, and data signals.  

Functional Modelling acts as a **bridge** between SoC theory and hands-on design implementation, ensuring that your architecture performs logically correct before moving to synthesis and layout.

---

## 5. Summary

The **BabySoC project** provides a practical environment to understand:
- SoC architecture hierarchy (CPU, memory, peripherals).  
- Signal communication and synchronization.  
- The significance of **early functional verification** using open-source EDA tools.  

By mastering BabySoC, learners gain a strong foundation for progressing into **RTL design**, **synthesis**, and **physical design**, completing the end-to-end SoC learning cycle.

---

## **Deliverable**

Include:
- Explanation of SoC fundamentals.  
- Components of SoC.  
- Why BabySoC is used.  
- Role of functional modelling before RTL/physical design.  

---

## **References**

1. Hemanth Kumar D M, *SFAL-VSD SoC Journey – Fundamentals of SoC Design*, GitHub Repository.  
   🔗 [https://github.com/hemanthkumardm/SFAL-VSD-SoC-Journey/tree/main/11.%20Fundamentals%20of%20SoC%20Design](https://github.com/hemanthkumardm/SFAL-VSD-SoC-Journey/tree/main/11.%20Fundamentals%20of%20SoC%20Design)

2. VLSI System Design (VSD) Initiative – *BabySoC Learning Modules and Simulation Framework.*  
3. Documentation and open-source tools: *Icarus Verilog* and *GTKWave* user manuals.  
