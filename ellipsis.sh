#!/usr/bin/env bash

pkg.install() {
    # Only install if we're in WSL2
    if [ "$(os.platform)" = "wsl2" ]; then
        # Look for choco.exe and add to $PATH if it's not already
        if ! utils.cmd_exists choco.exe; then
            for drive in /mnt/[[:alnum:]]; do
                if [ -x "$drive/ProgramData/chocolatey/bin/choco.exe" ]; then
                    PATH="$drive/ProgramData/chocolatey/bin:$PATH"
                    break
                fi
            done
        fi

        # We need wudo from the wsl-tools package in order to install
        if ! utils.cmd_exists wudo; then
            $ELLIPSIS_PATH/bin/ellipsis install thomshouse-ellipsis/wsl-tools
        fi

        # Install Chocolatey if it's not found on the path
        if ! utils.cmd_exists choco.exe; then
            echo "Installing Chocolatey..."
            wudo $PKG_PATH/choco-install.bash
        fi
    fi
}

pkg.link() {
    fs.link_rfiles "$PKG_PATH/bin" "$ELLIPSIS_PATH/bin"
}

pkg.unlink() {
    for file in "$PKG_PATH/bin"/*; do
        rm "$ELLIPSIS_PATH/bin/$(basename $file)"
    done
}