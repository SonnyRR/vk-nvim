# 🏝️ Vasil Kotsev's Neovim Config

A nvim configuration with sensible defaults. Supports `C#`, `Elixir`, `Lua`, `JS`, `TS` & `Angular` projects.

<img width="1095" height="964" alt="Landing" src="https://github.com/user-attachments/assets/07487b80-eec1-488a-9069-f8c5977a9202" />

## Pre-requisites

In order to use this configuration you'll need the following dependencies:

### 🪟 Windows

#### 📦 Packages

```pwsh
winget install BrechtSanders.WinLibs.POSIX.UCRT
winget install BurntSushi.ripgrep.MSVC
winget install junegunn.fzf
winget install Microsoft.DotNet.SDK.10
winget install OpenJS.NodeJS

bun add -g tree-sitter-cli
# or
npm install -g tree-sitter-cli
```

#### ⚗️ XDG Base Directory Variables (Optional)

```pwsh
[System.Environment]::SetEnvironmentVariable('XDG_DATA_HOME', 'D:\', 'User')
[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', 'D:\dotfiles', 'User')
```

### 🍎 MacOS

#### 📦 Packages

```sh
brew install ripgrep
brew install fzf
brew install --cask dotnet-sdk@10
brew install node
brew install tree-sitter-cli
```

### 🟪 .NET CLI tools

```sh
dotnet tool install -g easydotnet
dotnet tool install -g dotnet-outdated-tool
dotnet tool install -g dotnet-ef
```
