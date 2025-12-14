# Firebase Studio Template: .NET 10 File-based App

A simple ASP.NET Core application demonstrating the new .NET 10 file-based application feature with Minimal APIs. This single-file approach provides a clean and simple project structure, perfect for small applications, prototypes, and learning purposes.

## Quick Start

Click the button below to create a workspace from this template:

[![Open in IDX](https://cdn.idx.dev/btn/open_light_32.svg)](https://idx.google.com/import?url=https://github.com/dotnetdev-kr/firebase-studio-fba)

## Getting Started

The server should run automatically when you start the workspace. To run it manually, use the following command in the terminal:

```sh
dotnet run Program.cs
```

The application will start on port `3000` by default (configurable via `PORT` environment variable).

## Project Structure

```
├── Program.cs          # Main application file with embedded SDK configuration
├── .idx/               # Firebase Studio (IDX) configuration
│   ├── dev.nix         # Nix-based development environment
│   └── mcp.json        # MCP server configuration
├── .vscode/            # VS Code settings and extensions
├── GEMINI.md           # Gemini AI context file
└── README.md           # This file
```

## How It Works

The `Program.cs` file uses .NET 10's file-based application feature with special directives:

```csharp
#!/usr/bin/env dotnet
#:sdk Microsoft.NET.Sdk.Web
#:property PublishAot=false
```

- `#!/usr/bin/env dotnet` - Shebang for direct execution
- `#:sdk` - Specifies the SDK to use
- `#:property` - Sets MSBuild properties inline

## Features

* **ASP.NET Core 10:** Built on the latest .NET 10 preview with file-based app support.
* **Single-File Application:** No `.csproj` file required - SDK and properties defined inline.
* **Minimal APIs:** A streamlined way to build fast HTTP APIs with minimal boilerplate.
* **Environment Variables:** Configurable via `PORT` and `TARGET` environment variables.
* **Ready for IDX:** Pre-configured to run in Google's Firebase Studio (IDX) environment.
* **Microsoft Learn MCP Server:** Integrated MCP server for enhanced AI-assisted development.

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT`   | `3000`  | The port number the server listens on |
| `TARGET` | `World` | The greeting target (e.g., "Hello World!") |

## Docker Support

> ⚠️ **Coming Soon:** Docker container support is currently on hold due to version compatibility issues. This feature will be available in a future update.
