# 📦 Synchronous FIFO Design & Verification (Verilog)

## 📌 Project Overview

This project implements a **Synchronous FIFO (First-In-First-Out)** buffer using **Verilog HDL**, along with a comprehensive **testbench** for functional verification.

The FIFO ensures **ordered data flow**, making it useful in buffering, pipelining, and communication systems.

---

## 🚀 Key Highlights

* 📥 **FIFO-based data buffering**
* 🔁 **First-In-First-Out behavior**
* 🧠 **Pointer-based control logic**
* ⚠️ **Full & Empty detection**
* 🧪 **Task-based verification**
* 🖥️ **Waveform + simulation log validation**
* 🧩 **Parameterized RTL design**

---

## 🧠 FIFO Architecture

```text
Write Logic → FIFO Memory → Read Logic
           ↘ Pointer Control ↙
```

---

## 📦 Modules

| Module         | Description                     |
| -------------- | ------------------------------- |
| `fifo_sync`    | Synchronous FIFO implementation |
| `fifo_sync_tb` | Testbench for verification      |

---

## ⚙️ Design Parameters

```verilog
parameter fifo_depth = 8;
parameter data_width = 32;
```

---

## 🧠 Internal Design

### 🔢 Pointer Logic

* Write Pointer → Tracks write location
* Read Pointer → Tracks read location
* Extra MSB bit used for **full detection**

---

## 📥 Write Operation

```verilog
if(cs && !full && w_enable)
```

✔ Writes data into FIFO
✔ Increments write pointer

---

## 📤 Read Operation

```verilog
if(cs && !empty && r_enable)
```

✔ Reads data from FIFO
✔ Increments read pointer

---

## ⚠️ FIFO Status Flags

### 🟢 Empty

```verilog
assign empty = (read_pointer == write_pointer);
```

---

### 🔴 Full

```verilog
assign full = (read_pointer == {~write_pointer[fifo_depth_log], write_pointer[fifo_depth_log-1:0]});
```

✔ Prevents overwrite
✔ Uses MSB inversion logic

---

## 📊 Simulation Waveform

The waveform verifies:

* Write and read pointer movement
* Data flow through FIFO
* Full and empty conditions
* Correct sequencing of operations

![Waveform](images/waveform.png)

---

## 🖥️ Simulation Log Output

The simulation log provides visibility of FIFO operations:

### 🔍 Includes:

* Input data (`data_in`)
* Output data (`data_out`)
* FIFO status flags (`full`, `empty`)
* Operation sequence (write/read)

### 📄 Sample Output

```
============Test case 1 : no.of.write operations == no.of.read operation===========
data_in = 10
data_in = 20
data_in = 30
data_out = 10
data_out = 20
data_out = 30

===========Test Case 2 : writing and reading at a time===========
data_in = 1
data_out = 1
------- empty = 1  full = 0 -------

data_in = 2
data_out = 2
------- empty = 1  full = 0 -------

============Test case 3 : No.of write operations are greater than fifo depth===========
data_in = 0
data_in = 2
data_in = 4
...
------- empty = 0  full = 1 -------

Test case 3 sub case : Reading content of fifo
data_out = 0
data_out = 2
data_out = 4
...
```

📄 Full logs available in: `simulation_log.txt`

---

## 🧪 Testbench Coverage

### ✔ Functional Tests

* Normal write & read
* Sequential operations

### ✔ FIFO Behavior

* Continuous write-read
* Full condition validation

### ✔ Edge Cases

* Overflow attempt
* Read from empty FIFO

---

## 🔧 Design Methodology

✔ Synchronous design
✔ Asynchronous reset
✔ Modular RTL coding
✔ Task-based verification

---

## 📂 Project Structure

```text
fifo-design/
│
├── fifo_sync.v
├── fifo_sync_tb.v
├── simulation_log.txt
├── README.md
└── images/
    └── waveform.png
```

---

## 🚀 How to Run (Vivado)

1. Open **Xilinx Vivado**
2. Add design + testbench files
3. Run **Behavioral Simulation**
4. Observe:
   → Waveforms
   → Console logs

---

## 🛠️ Tools Used

* Verilog HDL
* Xilinx Vivado

---

## 📈 Skills Demonstrated

* FIFO Design
* Pointer Logic
* RTL Coding
* Verification & Debugging

---

## 👨‍💻 Author

**SHAIK ABDUL MATHEEN**

---

## 📌 Acknowledgement

This project demonstrates core digital design concepts:

* FIFO Buffering
* Pointer-Based Control
* Simulation-Based Verification

It builds a strong base for:

* Asynchronous FIFO
* Clock Domain Crossing (CDC)
* High-speed data systems

---
