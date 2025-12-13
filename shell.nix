# How to run:
# podman run -it --rm -p 3000:3000 --name vscodelocal -v %cd%:/app -w /app nixos/nix nix-shell --run run-vscode-web
#
# Open VS Code Server:
# - 웹 브라우저에서 http://localhost:3000 으로 접속
# - 인증 없이 바로 사용 가능

let
  # 1. Unstable 채널
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  pkgs = import nixpkgs {};

  # 2. dev.nix 가져오기
  devNixFunc = import ./.idx/dev.nix;
  devConfig = devNixFunc { inherit pkgs; };

  # 3. 환경변수 변환 헬퍼
  envToExport = envAttrs: 
    pkgs.lib.concatStringsSep "\n" (
      pkgs.lib.mapAttrsToList (key: val: "export ${key}=\"${val}\"") envAttrs
    );

  # 4. 확장 설치 명령 생성 헬퍼
  extensions = devConfig.idx.extensions or [];
  installExtensionsCmd = pkgs.lib.concatMapStringsSep "\n" (ext: 
    ''${pkgs.openvscode-server}/bin/openvscode-server --install-extension ${ext} || echo "⚠️  Failed to install: ${ext}"''
  ) extensions;

  # 5. run-vscode-web 스크립트 (openvscode-server 사용)
  runVSCodeWeb = pkgs.writeShellScriptBin "run-vscode-web" ''
    echo ""
    echo "* Installing extensions..."
    ${installExtensionsCmd}
    echo ""
    echo "* Starting Open VS Code Server..."
    echo "* Open your browser at: http://localhost:3000"
    echo ""
    ${pkgs.openvscode-server}/bin/openvscode-server --host 0.0.0.0 --port 3000 --without-connection-token --accept-server-license-terms --start-server
  '';

in pkgs.mkShell {
  buildInputs = (devConfig.packages or []) ++ [ 
    pkgs.openvscode-server
    runVSCodeWeb
  ];

  shellHook = ''
    ${envToExport (devConfig.env or {})}

    echo "========================================================="
    echo " * Loaded environment from .idx/dev.nix"
    echo " * Type 'run-vscode-web' to start VS Code Web Server!"
    echo " * Then open http://localhost:3000 in your browser"
    echo "========================================================="
  '';
}