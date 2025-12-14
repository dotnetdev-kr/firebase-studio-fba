#!/usr/bin/env sh
set -eu
podman run -it --rm -p 3000:3000 --memory=4g --memory-swap=6g -v "$PWD:/app" -w /app docker.io/nixos/nix nix-shell --run run-vscode-web
