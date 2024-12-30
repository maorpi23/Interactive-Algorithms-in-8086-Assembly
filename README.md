# Interactive-Algorithms-in-8086-Assembly
---

This repository contains an assembly language project showcasing interactive algorithms implemented in 8086 assembly. The project demonstrates fundamental programming concepts in assembly through two primary features: a prime number checker and a Caesar cipher encoder.

## Features

1. **Prime Number Checker**:
   - Accepts a positive integer \( N \) (between 3 and 255).
   - Determines whether the input number is prime.
   - Outputs the result interactively.

2. **Caesar Cipher Encoder**:
   - Accepts a string of lowercase English letters.
   - Applies a Caesar cipher shift based on an integer offset (between 2 and 9).
   - Outputs the encoded string.

3. **Exit Option**:
   - Cleanly terminates the program.

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/maorpi23/Interactive-Algorithms-in-8086-Assembly.git
   cd Interactive-Algorithms-in-8086-Assembly
   ```
2. Assemble the code using your preferred assembler, such as NASM:
   ```bash
   nasm -f bin PROJECT1.ASM -o PROJECT1.COM
   ```
3. Run the program on an emulator like DOSBox or a compatible environment:
   ```bash
   dosbox PROJECT1.COM
   ```

## Project Structure

- `PROJECT1.ASM`: The main assembly source file containing the implementation.

## Sample Outputs

### Prime Number Checker
```plaintext
>> Enter a positive integer number N (255 > N > 2): 7
Result: 7 is a prime number!
```

### Caesar Cipher Encoder
```plaintext
>> Type a string (only small characters in English): hello
>> Enter one decimal digit (between 2 to 9): 3
Result: khoor
```

## Requirements

- An 8086 assembler (e.g., NASM, MASM).
- DOSBox or similar x86 emulation software.

## Notes

- This project was developed as part of a computer science curriculum.
- Input validation and error handling have been implemented to ensure smooth operation.
- Feel free to explore and modify the code for learning purposes.

