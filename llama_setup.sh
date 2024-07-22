#!/bin/bash

# Update and upgrade Termux packages
pkg update && pkg upgrade -y

# Install necessary packages
pkg install clang wget git cmake make build-essential -y

# Download and set up Android NDK
NDK_VERSION="android-ndk-r26b-aarch64"
NDK_ZIP="${NDK_VERSION}.zip"
NDK_URL="https://github.com/lzhiyong/termux-ndk/releases/download/android-ndk/${NDK_ZIP}"
NDK_DIR="$HOME/${NDK_VERSION}"

# Download the NDK if not already downloaded
if [ ! -f "${NDK_ZIP}" ]; then
    wget "${NDK_URL}"
fi

# Unzip the NDK if not already unzipped
if [ ! -d "${NDK_DIR}" ]; then
    unzip "${NDK_ZIP}"
    # Rename the directory if it was unzipped with a different name
    mv $HOME/android-ndk-r26b $NDK_DIR
fi

export NDK="${NDK_DIR}"

# Locate the toolchain file
TOOLCHAIN_FILE=$(find $NDK -name "android.toolchain.cmake")
if [ -z "$TOOLCHAIN_FILE" ]; then
    echo "android.toolchain.cmake not found, searching for alternatives..."
    TOOLCHAIN_FILE=$(find $NDK -name "*.cmake" | grep toolchain | head -n 1)
    if [ -z "$TOOLCHAIN_FILE" ]; then
        echo "Error: No suitable toolchain file found!"
        exit 1
    fi
    echo "Using alternative toolchain file: $TOOLCHAIN_FILE"
else
    echo "Using toolchain file: $TOOLCHAIN_FILE"
fi

# Clone and compile alpaca.cpp
git clone https://github.com/rupeshs/alpaca.cpp.git
cd alpaca.cpp
mkdir build-android
cd build-android

# Run CMake with the correct toolchain file
cmake -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=android-23 -DCMAKE_C_FLAGS=-march=armv8.4a+dotprod ..
if [ $? -ne 0 ]; then
    echo "Error: CMake configuration failed!"
    exit 1
fi

# Run make to build the project
make -j8
if [ $? -ne 0 ]; then
    echo "Error: Make build failed!"
    exit 1
fi

# Download the model
wget https://huggingface.co/Sosaka/Alpaca-native-4bit-ggml/resolve/main/ggml-alpaca-7b-q4.bin -O ggml-alpaca-7b-q4.bin

# Check for the executable
if [ -f chat ]; then
  # Run the model
  ./chat --model ggml-alpaca-7b-q4.bin
else
  echo "Error: chat executable not found!"
  exit 1
fi
