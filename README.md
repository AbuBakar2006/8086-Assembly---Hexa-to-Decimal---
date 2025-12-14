# 🖥️ 16-Bit Hex to Decimal Converter (8086 Assembly)

A low-level **System Utility** written in **x86 Assembly Language (MASM/TASM)**. This program operates in Real Mode (16-bit) to accept a Hexadecimal number from the user, process it using bitwise operations, and output the corresponding Decimal value using the system stack.

## 🚀 Features

* **Input Processing:** Reads character input directly from the keyboard (using DOS Interrupt `21H`).
* **Bitwise Logic:** Uses bit-shifting (`SHL`) to construct the hexadecimal value from ASCII characters without complex multiplication.
* **Stack Operations:** Utilizes the system stack (`PUSH`/`POP`) to reverse the order of decimal digits for correct printing.
* **Modular Design:** Divided into procedures (`INPUT`, `CONVERSION`, `OUTPUT`) for clean code structure.

## 🛠️ Internal Logic & Register Usage

The program manipulates specific CPU registers to handle data:

| Register | Purpose in Code |
| :--- | :--- |
| **AX** | **Accumulator:** Used for all arithmetic (`ADD`, `SUB`, `DIV`) and I/O interrupts. |
| **BX** | **Base:** Holds temporary values during the input construction phase. |
| **CX** | **Counter:** Counts the number of decimal digits pushed to the stack to control the printing loop. |
| **DX** | **Data:** Stores the remainder during division and addresses strings for printing. |

### The Conversion Algorithm
1.  **Hex to Binary (Input):**
    * Read char.
    * Convert ASCII to Int (e.g., 'A' $\rightarrow$ 10).
    * Shift current total Left by 4 bits (`SHL AX, 4`).
    * Add new digit.
2.  **Binary to Decimal (Output):**
    * Repeatedly divide the number by 10 (`DIV TEN`).
    * Push the **Remainder** (DX) onto the Stack.
    * Repeat until the quotient is 0.
    * Pop values from the Stack and add `30H` to convert back to ASCII for printing.

## 💻 How to Run

Since this is 16-bit Assembly, you need an emulator like **DOSBox** and an assembler like **MASM** or **TASM**.

#### 1. Prerequisites
Install **emu8086**.

#### 2. Assemble and Link
Mount your file in emu8086.

#### 3. Execution
Run the file.

## 📝 Example Usage
#### Scenario 1: Simple Conversion
```text
Enter A Hexadecimal Number (0-FFFF) : 1A
Decimal : 26
```
#### Scenario 2: Maximum Value (16-bit)
```text
Enter A Hexadecimal Number (0-FFFF) : FFFF
Decimal : 65535
```
#### Scenario 3: Mixed Digits
```text
Enter A Hexadecimal Number (0-FFFF) : B2
Decimal : 178
```

## ⚠️ Requirements
  * **Assembler:** MASM (Microsoft Macro Assembler) or TASM.
  * **Emulator:** DOSBox/emu8086 (Required for 64-bit Windows/Linux/Mac).
  * **Architecture:** x86 Real Mode (16-bit).
