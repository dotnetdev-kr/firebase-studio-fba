#!/usr/bin/env sh
set -eu

# Minimal Podman launcher for shell.nix
podman run -it --rm -p 3000:3000 --name vscodelocal -v "$PWD:/app" -w /app docker.io/nixos/nix nix-shell --run run-vscode-web
