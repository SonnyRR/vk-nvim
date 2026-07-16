# 🏝️ Vasil Kotsev's Neovim Config

![CI](https://github.com/SonnyRR/vk-nvim/actions/workflows/ci.yml/badge.svg?branch=main)

A nvim configuration with sensible defaults. Supports `C#`, `Elixir`, `Lua`, `JS`, `TS` & `Angular` projects.

<img width="919" height="813" alt="Landing" src="https://github.com/user-attachments/assets/e8f1a831-39c8-418a-8fdf-b0ff1d081f3a" />

## 🗂️ Config Structure

```
📦 vk-nvim
├── init.lua
├── lua/
│   ├── options.lua
│   ├── keymaps.lua
│   ├── lazy-bootstrap.lua
│   ├── lazy-plugins.lua
│   ├── health.lua
│   └── plugins/
│       ├── autocompletion.lua
│       ├── autopairs.lua
│       ├── conform.lua
│       ├── debug.lua
│       ├── dotnet.lua
│       ├── dracula.lua
│       ├── gitsigns.lua
│       ├── indent-line.lua
│       ├── lazy-dev.lua
│       ├── lint.lua
│       ├── lsp.lua
│       ├── mini.lua
│       ├── neo-tree.lua
│       ├── neotest.lua
│       ├── noice.lua
│       ├── opencode.lua
│       ├── snacks.lua
│       ├── telescope.lua
│       ├── todo-comments.lua
│       ├── treesitter.lua
│       ├── ts-tools.lua
│       └── which-key.lua
├── lazy-lock.json
├── .stylua.toml
└── selene.toml
```

## 🧩 Pre-requisites

In order to use this configuration you'll need the following dependencies:

### 🪟 Windows

#### 📦 Packages

```powershell
winget install BrechtSanders.WinLibs.POSIX.UCRT
winget install BurntSushi.ripgrep.MSVC
winget install junegunn.fzf
winget install sharkdp.fd
winget install Microsoft.DotNet.SDK.10
winget install OpenJS.NodeJS

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
brew install fd
brew install --cask dotnet-sdk@10
brew install node
brew install tree-sitter-cli
```

#### ⚗️ XDG Base Directory Variables (Optional)

On macOS, XDG base directories are not set by default. Add the following to your shell profile (`~/.zshrc`, `~/.bashrc`, etc.):

```sh
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
```

### 🐧 Linux

#### 📦 Packages

```sh
# Debian / Ubuntu
sudo apt install ripgrep fzf fd-find nodejs npm
```

```sh
# Fedora / RHEL
sudo dnf install ripgrep fzf fd-find nodejs
```

For the .NET SDK, follow the [official Microsoft installation guide](https://learn.microsoft.com/dotnet/core/install/linux).

#### ⚗️ XDG Base Directory Variables (Optional)

XDG base directories are typically pre-configured on most Linux distributions. To customize them, add the following to your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):

```sh
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
```

### 🟪 .NET CLI tools

```sh
dotnet tool install -g easydotnet
dotnet tool install -g dotnet-outdated-tool
dotnet tool install -g dotnet-ef
```

## 📦 Installation

Clone the repository to your Neovim config directory and start Neovim to let `lazy.nvim` install the plugins:

```sh
git clone https://github.com/SonnyRR/vk-nvim.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

> [!NOTE]
> On Windows, replace `~/.config/nvim` with your configured `$env:XDG_CONFIG_HOME\nvim` or the default `$env:LOCALAPPDATA\nvim`.

## 🔧 Supported Neovim Version

| Minimum | CI / Recommended |
|---------|------------------|
| 0.10+   | 0.12.4           |

The configuration is validated in CI against **Neovim 0.12.4** and requires **0.10+** (enforced by the built-in health check). It uses vim.lsp.config (0.11+), vim.treesitter (0.10+), and other modern APIs.
```
