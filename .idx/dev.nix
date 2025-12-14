{ pkgs, ... }: {
  channel = "unstable"; # "stable-25.11";
  packages = [ pkgs.dotnet-sdk_10 pkgs.nodejs_20 pkgs.icu pkgs.openssl pkgs.zlib ];
  env = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}";
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    DOTNET_NOLOGO = "1";
    DOTNET_gcServer = "0";
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
    workspace = {
      onCreate = {
        # Remove docs folder (GitHub Pages) - not needed for development
        remove-docs = "rm -rf docs";
      };
      onStart = {
        # Start the development server
        run-server = "dotnet run Program.cs &";
      };
    };
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["dotnet" "run" "Program.cs"];
          manager = "web";
          env = {
            PORT = "$PORT";
          };
        };
      };
    };
  };
}
