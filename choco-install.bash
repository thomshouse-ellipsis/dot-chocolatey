#!/usr/bin/env bash

# Install Chocolatey
cmd.exe /C @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
cmd.exe /C SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin" && echo -e "\nChocolatey added to Windows path.\n"

read -n 1 -s -r -p "Press any key to continue..."
read -s -t 0.001 # Clear any extra keycodes (e.g. arrows)
