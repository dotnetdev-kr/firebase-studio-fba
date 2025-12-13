@echo off
pushd "%~dp0"
podman run -it --rm -p 3000:3000 --name vscodelocal -v %cd%:/app -w /app docker.io/nixos/nix nix-shell --run run-vscode-web
:exit
popd
echo on
