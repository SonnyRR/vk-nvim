# 🏝️ Vasil Kotsev's Neovim Config

A nvim configuration with sensible defaults. Supports `C#`, `Elixir`, `Lua`, `JS`, `TS` & `Angular` projects.

<img width="919" height="813" alt="Landing" src="https://github.com/user-attachments/assets/e8f1a831-39c8-418a-8fdf-b0ff1d081f3a" />

## 🧩 Pre-requisites

In order to use this configuration you'll need the following dependencies:

### 🪟 Windows

#### 📦 Packages

```powershell
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

```powershell
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
