
# LLaMA Model Setup Script for Termux on Android

This repository contains a bash script to set up and run the LLaMA model using Termux on Android phones. This script automates the process of downloading necessary packages, the Android NDK, and compiling the LLaMA model using `llama.cpp`.

## Features
- Updates and upgrades Termux packages.
- Installs necessary dependencies.
- Downloads and sets up the Android NDK.
- Clones and compiles the `alpaca.cpp` repository.
- Downloads the LLaMA model.
- Runs the model on your Android device.

## Prerequisites
- Termux installed on your Android device.
- Sufficient storage space for the NDK and model files.

## Usage
1. **Download the Script:**
   Clone this repository to your Termux environment:
   ```bash
   git clone https://github.com/cycloarcane/llama-termux-setup.git
   cd llama-termux-setup
   ```

2. **Run the Script:**
   ```bash
   chmod +x setup_llama3_quantized.sh
   ./setup_llama3_quantized.sh
   ```

3. **Follow the On-Screen Instructions:**
   The script will guide you through the process and ensure all necessary components are downloaded and set up correctly.

## Acknowledgements
- [Termux](https://termux.com/)
- [LLaMA Model](https://github.com/facebookresearch/llama)
- [alpaca.cpp](https://github.com/rupeshs/alpaca.cpp)
- [Termux NDK](https://github.com/lzhiyong/termux-ndk)

## Author
Created by [cycloarcane](https://github.com/cycloarcane). For any issues or suggestions, please open an issue on GitHub or contact me at cycloarkane@gmail.com.
