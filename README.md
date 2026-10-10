# Smart Math Plugin for Notepad++

**Smart Math** is a lightweight, powerful plugin that turns Notepad++ into a dynamic calculator, inspired by tools like *Soulver*, *Numara* and *SpeQ Mathematics*. It allows you to perform calculations naturally in plain text, showing results in real-time without altering your file content.

![image](https://i.ibb.co/ZPdC5VL/img01.jpg)

![image](https://i.ibb.co/NgC1jsN9/img02.jpg)

### ✨ Features
*   **Real-Time Evaluation:** Instantly evaluates addition, subtraction, multiplication, and division as you type.
*   **Non-Invasive Annotations:** Results are displayed using Scintilla’s End-of-Line (EOL) annotations. Your actual text remains untouched.
*   **Per-Tab Persistence:** The plugin operates independently for each document. It remembers which tabs have "Smart Math" enabled even after restarting Notepad++, allowing you to keep calculation sheets active alongside source code.
*   **Variable Support:** Define variables (e.g., `base = 100`) and reference them in subsequent lines (e.g., `base * 1.15`).
*   **Arrays:** Use array arguments and variables (e.g. `(1, 2, 3)*10` and `a = (pi/4, pi/2); sin(a)`).
*   **Percentage Logic:** Intuitive handling of the `%` character (e.g., `500 + 21%`).
*   **Customizable Precision:** Set result output from 0 to 8 decimal places via the plugin menu.
*   **Hexadecimal, Octal and Binary Numbers:** SmartMath supports prefixes for hexadecimal numbers (`0x7F`), octal numbers (`0o15`) and binary numbers (`0b01001`). The output formatting functions `hex`, `oct` and `bin` are available.
*   **Built-in Functions:** SmartMath supports most of the functions you usually find in calculators (e.g. `abs`, `sin`, `log`, `max` etc.).
*   **User-Defined Functions:** Define your own functions (e.g. `f(x,y) = x**2 + y**2; f(5,6)`).
*   **Copy the Result to the Clipboard:** Double-click the result to copy it to the clipboard.

### 🛠 Technical Details
*   **Language:** 100% FreeBASIC.
*   **Interface:** Based on the Notepad++ Plugin SDK and Scintilla API.
*   **Architecture:** Compatible and compilable for both **x86** (32-bit) and **x64** (64-bit).
*   **Dependencies:** None. It is a native, standalone binary.
*   **Storage:** Settings and tab states are saved in an `.ini` file within the Notepad++ plugins configuration folder.

### ⚙️ Compilation
To compile the plugin yourself:
1.  Ensure you have the **FreeBASIC** compiler installed and added to your PATH.
2.  Open a terminal in the project's root folder.
3.  Run the `Compile.bat` file.
4.  Use `Compile32.bat` to get a 32-bit (x86) binary and `Compile64.bat` to get a 64-bit (x86_64) binary. Note: path to `fbc` should either be in PATH or explicitly specified as `FB_HOME` in these `.bat` files.

### 📦 Installation
1.  Create a folder named `SmartMath` inside the `plugins` directory of your Notepad++ installation.
    *   Typical path: `C:\Program Files\Notepad++\plugins\SmartMath\`
2.  Copy the compiled DLL (`SmartMath.dll`) into that folder.
3.  Copy the following files:
    * documentation - "Notepad++\plugins\doc";
    * user-defined language - "Notepad++\userDefineLangs";
    * auto-completion - "Notepad++\autoCompletion".
4.  Restart Notepad++.

### Development
1. The mathematical "heart" of SmartMath, its math parser and evaluator, is "MathParser.bas", "MathParserFactorInt.bas" and "MathParserRawResult.bas".  
These files are developed using AI in the scope of the following project:  
https://github.com/c-sanchez/AkelPad-Smart-Math  
It is highly recommended to do all the changes related to the math parser and evaluator there, by means of the existing AI-skills which automatically maintain the documentation and the unit and regression tests.  
The existing AI-skills are: `add-mathparser-function` and `parser-reusability-cleanup`.  
2. The "Smart-Math*.bas" files are specific to Notepad++ and can be developed separately.

### 🙏 Special Thanks
This project was originally started in FreePascal. However, seeking better binary size optimization and a cleaner code structure, I decided to port it to **FreeBASIC**.

I would like to express my deepest gratitude to **Mysoft**, who was instrumental in this transition. He not only convinced me of FreeBASIC's benefits for plugin development but also generously shared his original code to serve as the template and backbone for **SmartMath**.