# ASCON Hardware Implementation

Hardware implementation of the **ASCON authenticated encryption algorithm** using SystemVerilog, focusing on RTL design, finite state machine control, and functional verification.

## Project Overview

This project explores the hardware implementation of ASCON, a lightweight cryptographic algorithm designed for resource-constrained embedded systems.

The objective is to design and simulate a modular digital architecture implementing the algorithm's cryptographic operations.

The implementation is written in **SystemVerilog** and tested using **ModelSim**.

## Architecture

The design is organized into several interconnected RTL modules:

- **Permutation:** Implements the ASCON permutation using its main transformation layers.
- **Substitution Layer (Ps):** Performs the nonlinear transformation.
- **Linear Diffusion Layer (Pl):** Provides diffusion across the internal state.
- **Round Constants (Pc):** Introduces round-dependent constants.
- **Finite State Machine (FSM):** Controls the execution sequence and coordinates the hardware modules.
- **Registers and Counters:** Manage intermediate states, ciphertext, authentication tags, and control signals.
- **Top-Level Module:** Integrates the different components into a complete hardware architecture.

## Technologies

- **Language:** SystemVerilog
- **Simulation:** ModelSim
- **Design methodology:** Register Transfer Level (RTL)
- **Key concepts:** Lightweight cryptography, digital hardware architecture, finite state machines, functional verification

## Repository Structure

```text
├── SRC/
│   ├── RTL/           # SystemVerilog hardware modules
│   ├── BENCH/         # Testbenches
│   ├── LIB_RTL/
│   └── LIB_BENCH/
├── LIB/               # ModelSim simulation libraries
├── ascon_pack.sv
├── compil_ascon.txt   # Compilation and simulation script
├── modelsim.ini
└── Nina_Perret_Rapport-ASCON.pdf
```

## Simulation

The project includes dedicated SystemVerilog testbenches for individual components and the integrated architecture.

To compile and simulate the design using ModelSim:

1. Open ModelSim in the repository directory.
2. Run the compilation script:

   ```tcl
   do compil_ascon.txt
   ```

3. The script compiles the RTL modules and testbenches, then launches the top-level simulation (`ascon_top_tb`).

To simulate a specific component, select the corresponding `vsim` command in `compil_ascon.txt`.

## Documentation

A detailed technical report covering the design and implementation is available here:

[ASCON Hardware Implementation – Technical Report](Nina_Perret_Rapport-ASCON.pdf)

## Author

**Nina Perret**  
Mines Saint-Étienne – ISMIN Engineering Program  
Computer Science & Microelectronics# ASCON Hardware Implementation

Hardware implementation of the **ASCON authenticated encryption algorithm** using SystemVerilog, focusing on RTL design, finite state machine control, and functional verification.

## Project Overview

This project explores the hardware implementation of ASCON, a lightweight cryptographic algorithm designed for resource-constrained embedded systems.

The objective is to design and simulate a modular digital architecture implementing the algorithm's cryptographic operations.

The implementation is written in **SystemVerilog** and tested using **ModelSim**.

## Architecture

The design is organized into several interconnected RTL modules:

- **Permutation:** Implements the ASCON permutation using its main transformation layers.
- **Substitution Layer (Ps):** Performs the nonlinear transformation.
- **Linear Diffusion Layer (Pl):** Provides diffusion across the internal state.
- **Round Constants (Pc):** Introduces round-dependent constants.
- **Finite State Machine (FSM):** Controls the execution sequence and coordinates the hardware modules.
- **Registers and Counters:** Manage intermediate states, ciphertext, authentication tags, and control signals.
- **Top-Level Module:** Integrates the different components into a complete hardware architecture.

## Technologies

- **Language:** SystemVerilog
- **Simulation:** ModelSim
- **Design methodology:** Register Transfer Level (RTL)
- **Key concepts:** Lightweight cryptography, digital hardware architecture, finite state machines, functional verification

## Repository Structure

```text
├── SRC/
│   ├── RTL/           # SystemVerilog hardware modules
│   ├── BENCH/         # Testbenches
│   ├── LIB_RTL/
│   └── LIB_BENCH/
├── LIB/               # ModelSim simulation libraries
├── ascon_pack.sv
├── compil_ascon.txt   # Compilation and simulation script
├── modelsim.ini
└── Nina_Perret_Rapport-ASCON.pdf
```

## Simulation

The project includes dedicated SystemVerilog testbenches for individual components and the integrated architecture.

To compile and simulate the design using ModelSim:

1. Open ModelSim in the repository directory.
2. Run the compilation script:

   ```tcl
   do compil_ascon.txt
   ```

3. The script compiles the RTL modules and testbenches, then launches the top-level simulation (`ascon_top_tb`).

To simulate a specific component, select the corresponding `vsim` command in `compil_ascon.txt`.

## Documentation

A detailed technical report covering the design and implementation is available here:

[ASCON Hardware Implementation – Technical Report](Nina_Perret_Rapport-ASCON.pdf)

## Author

**Nina Perret**  
Mines Saint-Étienne – ISMIN Engineering Program  
Computer Science & Microelectronics# ASCON Hardware Implementation

Hardware implementation of the **ASCON authenticated encryption algorithm** using SystemVerilog, focusing on RTL design, finite state machine control, and functional verification.

## Project Overview

This project explores the hardware implementation of ASCON, a lightweight cryptographic algorithm designed for resource-constrained embedded systems.

The objective is to design and simulate a modular digital architecture implementing the algorithm's cryptographic operations.

The implementation is written in **SystemVerilog** and tested using **ModelSim**.

## Architecture

The design is organized into several interconnected RTL modules:

- **Permutation:** Implements the ASCON permutation using its main transformation layers.
- **Substitution Layer (Ps):** Performs the nonlinear transformation.
- **Linear Diffusion Layer (Pl):** Provides diffusion across the internal state.
- **Round Constants (Pc):** Introduces round-dependent constants.
- **Finite State Machine (FSM):** Controls the execution sequence and coordinates the hardware modules.
- **Registers and Counters:** Manage intermediate states, ciphertext, authentication tags, and control signals.
- **Top-Level Module:** Integrates the different components into a complete hardware architecture.

## Technologies

- **Language:** SystemVerilog
- **Simulation:** ModelSim
- **Design methodology:** Register Transfer Level (RTL)
- **Key concepts:** Lightweight cryptography, digital hardware architecture, finite state machines, functional verification

## Repository Structure

```text
├── SRC/
│   ├── RTL/           # SystemVerilog hardware modules
│   ├── BENCH/         # Testbenches
│   ├── LIB_RTL/
│   └── LIB_BENCH/
├── LIB/               # ModelSim simulation libraries
├── ascon_pack.sv
├── compil_ascon.txt   # Compilation and simulation script
├── modelsim.ini
└── Nina_Perret_Rapport-ASCON.pdf
```

## Simulation

The project includes dedicated SystemVerilog testbenches for individual components and the integrated architecture.

To compile and simulate the design using ModelSim:

1. Open ModelSim in the repository directory.
2. Run the compilation script:

   ```tcl
   do compil_ascon.txt
   ```

3. The script compiles the RTL modules and testbenches, then launches the top-level simulation (`ascon_top_tb`).

To simulate a specific component, select the corresponding `vsim` command in `compil_ascon.txt`.

## Documentation

A detailed technical report covering the design and implementation is available here:

[ASCON Hardware Implementation – Technical Report](Nina_Perret_Rapport-ASCON.pdf)