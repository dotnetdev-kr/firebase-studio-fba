{ pkgs, ... }: {
  channel = "unstable"; # "stable-25.11";
  packages = [ pkgs.dotnet-sdk_10 pkgs.nodejs_20 pkgs.icu pkgs.openssl pkgs.zlib ];
  env = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}";
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.openssl
      pkgs.icu
      pkgs.zlib
      pkgs.clang
      pkgs.stdenv.cc.cc.lib
    ];
    LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.openssl
      pkgs.icu
      pkgs.zlib
      pkgs.stdenv.cc.cc.lib
    ];
  };
  idx = {
    extensions = [
      "echoapi.echoapi-for-vscode"
      "dotnetdev-kr-custom.csharp"
      "ms-dotnettools.vscode-dotnet-runtime"
      "formulahendry.code-runner"
    ];
  };
}
