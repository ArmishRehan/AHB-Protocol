# AHB-Protocol
Basic AMBA AHB Protocol implementation in SystemVerilog featuring a single master, single slave architecture with read/write transactions and simulation testbench.

## Overview

This project implements a basic **AMBA AHB (Advanced High-performance Bus)** protocol using SystemVerilog. The design demonstrates communication between a single AHB master and a single AHB slave.

The purpose of this project is to understand the fundamentals of AHB bus transactions, including address phase, data phase, read/write operations, and master-slave handshaking.

---

## Features

- Single AHB Master
- Single AHB Slave
- Read and Write Transactions
- Address Phase Implementation
- Data Phase Implementation
- HREADY Handshake Signal
- HRESP Response Signal
- Simple Memory-Based Slave
- Simulation Testbench
- Fully synthesizable SystemVerilog design

---

## AHB Protocol Overview

AHB is a high-performance on-chip communication protocol developed by ARM as part of the AMBA family. It follows a master-slave architecture where the master initiates transactions and the slave responds.

Each transfer consists of:

### 1. Address Phase
The master provides:
- Address (`HADDR`)
- Transfer type (`HTRANS`)
- Read/Write control (`HWRITE`)

### 2. Data Phase
For write operations:
- Master sends data through `HWDATA`

For read operations:
- Slave returns data through `HRDATA`

The slave uses:
- `HREADY` to indicate transfer completion
- `HRESP` to indicate transfer status

---

## Project Structure
