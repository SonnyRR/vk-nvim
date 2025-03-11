# 🏝️ Vasil Kotsev's Neovim Config

A nvim configuration with sensible defaults. Supports C#, JS, TS & Angular projects.

## Pre-requisites

In order to use this configuration you'll need the following dependencies:

### 🪟 Windows

#### 📦 Packages

```powershell
winget install BurntSushi.ripgrep.MSVC
winget install zig.zig
winget install junegunn.fzf
winget install Microsoft.DotNet.SDK.9
winget install OpenJS.NodeJS
```
#### ⚗️ Variables (Optional)

```powershell
[System.Environment]::SetEnvironmentVariable('XDG_DATA_HOME', 'D:\', 'User')
[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', 'D:\dotfiles', 'User')
```

### 🍎 MacOS

#### 📦 Packages
```shell
brew install ripgrep
brew install fzf
brew install --cask dotnet-sdk
brew install node
```
