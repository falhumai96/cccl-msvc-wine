#!/bin/bash

# Default target is "X64".
if [ -z "$CCCL_MSVC_WINE_SHELL_ARCH" ]; then
    CCCL_MSVC_WINE_SHELL_ARCH="x64"
fi

# Default MSVC version is "17".
if [ -z "$CCCL_MSVC_WINE_SHELL_MSVC" ]; then
    CCCL_MSVC_WINE_SHELL_MSVC="17"
fi

# Default Wine debug level is "-1".
if [ -z "$CCCL_MSVC_WINE_SHELL_WINEDEBUG" ]; then
    CCCL_MSVC_WINE_SHELL_WINEDEBUG="-1"
fi

CCCL_MSVC_WINE_SHELL_SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CCCL_MSVC_WINE_SHELL_CCCL_MSVC_WINE_DIR="$(realpath --canonicalize-missing --no-symlinks "$CCCL_MSVC_WINE_SHELL_SCRIPT_DIR/..")"
CCCL_MSVC_WINE_SHELL_CCCL_MSVC_WINE_INSTALL_DIR="$CCCL_MSVC_WINE_SHELL_CCCL_MSVC_WINE_DIR/install"

CCCL_MSVC_WINE_SHELL_NEW_PATH="$CCCL_MSVC_WINE_SHELL_CCCL_MSVC_WINE_INSTALL_DIR/cccl/bin:$CCCL_MSVC_WINE_SHELL_CCCL_MSVC_WINE_INSTALL_DIR/msvc-wine-$CCCL_MSVC_WINE_SHELL_MSVC/toolchain/bin/$CCCL_MSVC_WINE_SHELL_ARCH"
if [ -z "$PATH" ]; then
    export PATH="$CCCL_MSVC_WINE_SHELL_NEW_PATH"
else
    export PATH="$CCCL_MSVC_WINE_SHELL_NEW_PATH:$PATH"
fi

export WINEPREFIX="$CCCL_MSVC_WINE_SHELL_CCCL_MSVC_WINE_INSTALL_DIR/msvc-wine-$CCCL_MSVC_WINE_SHELL_MSVC/wineprefix" && \
export WINEDEBUG="$CCCL_MSVC_WINE_SHELL_WINEDEBUG" && \
export CC="cccl" && \
export CXX="cccl" && \
export LD="cccl" && \
/bin/bash "$@"
