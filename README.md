# Password Validator 🛡️🔑

## Description

This is a **Password Validator** written in Assembly language. It evaluates the strength of a user-provided password based on various criteria such as length, character types, repetition, and strength. The password is categorized into one of the following:

- **TOO SHORT** 🛑
- **TOO WEAK** 🔒
- **WEAK** 💪
- **MEDIUM** 🔐
- **STRONG** 🔑
- **TOO STRONG** 💥
- **TOO REPETITIVE** 🔄

The program checks for:

- Minimum length of 8 characters 📝
- Presence of uppercase, lowercase, digits, and special characters 💡
- Repetition of characters (too repetitive is bad) 🔁
- Ensuring that the password has at least two different types of characters to avoid weakness 🛡️

## Features 🎯

- **Password Strength Evaluation**: Categorizes passwords based on predefined strength criteria.
- **Character Analysis**: Counts uppercase, lowercase, digits, and special characters.
- **Repetition Detection**: Flags passwords with excessive repetition of characters.
- **Length Validation**: Ensures passwords are at least 8 characters long.

## Requirements 🖥️

To run the program, you need:

- A Linux environment (tested on x86_64 architecture).
- Assembly (NASM) assembler and GNU linker (ld).
  
## How to Run 🚀

1. **Clone this repository:**

   ```bash
   git clone https://github.com/Dynamo2k1/Password-Validator.git
   cd Password-Validator
   ```

2. **Assemble the code:**

   ```bash
   nasm -f elf64 -o password_validator.o pass.asm
   ```

3. **Link the object file:**

   ```bash
   ld -s -o password_validator password_validator.o
   ```

4. **Run the program:**

   ```bash
   ./password_validator
   ```

   It will prompt you to enter a password and then provide feedback on its strength! 🔑

## Example 📋

- **Input**: `HuRah@89247`
- **Output**: `Password is STRONG! 🔑`

## How It Works 🔍

1. The program prompts the user to enter a password.
2. It checks the length of the password. If it's less than 8 characters, it returns `Password is TOO SHORT!` 🛑.
3. It evaluates the password for:
    - **Character types**: Uppercase, lowercase, digits, special characters.
    - **Repetition**: Too much repetition of the same character will return `Password has too much repetition!` 🔄.
4. Based on the above checks, it classifies the password as:
    - **TOO WEAK** if it only has one type of character.
    - **WEAK**, **MEDIUM**, **STRONG**, or **TOO STRONG** based on the variety and quantity of character types.
5. The program then prints the corresponding message based on the result.

## Messages 📢

- **TOO SHORT**: Password is less than 8 characters long.
- **TOO WEAK**: Password has only one character type (e.g., only lowercase letters).
- **WEAK**: Password is not strong enough with some improvement needed.
- **MEDIUM**: Password is decent, but could be stronger.
- **STRONG**: Password is robust, but not over-the-top.
- **TOO STRONG**: Password is overly complex with 10+ characters and well-balanced types.
- **TOO REPETITIVE**: Password contains excessive repetition of characters.

## License 📄

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments 🙏

- Inspired by password strength evaluation algorithms.
- Uses Assembly language to demonstrate low-level system programming skills.
- Special thanks to all the open-source contributors who provide valuable insights into password security!

---

Stay safe online! 💻🔒
