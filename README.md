# 🏝️ Vasil Kotsev's Neovim Config

![CI](https://github.com/SonnyRR/vk-nvim/actions/workflows/ci.yml/badge.svg?branch=main)

A nvim configuration with sensible defaults. Supports `C#`, `Elixir`, `Lua`, `JS`, `TS` & `Angular` projects.

<img width="919" height="813" alt="Landing" src="https://github.com/user-attachments/assets/e8f1a831-39c8-418a-8fdf-b0ff1d081f3a" />

## 🗂️ Config Structure

```
📦 vk-nvim
├── init.lua                  # Entry point, requires options, keymaps, & lazy
├── lua/                      # Lua source directory
│   ├── options.lua           # Editor options (number, clipboard, etc.)
│   ├── keymaps.lua           # Core key mappings
│   ├── lazy-bootstrap.lua    # Bootstrap lazy.nvim plugin manager
│   ├── lazy-plugins.lua      # Central plugin spec loader
│   ├── health.lua            # :checkhealth provider for vk-nvim
│   └── plugins/              # Per-plugin configuration specs
│       ├── autocompletion.lua    # blink.cmp + LuaSnip completion
│       ├── autopairs.lua         # Auto-close brackets & quotes
│       ├── conform.lua           # Code formatting
│       ├── debug.lua             # DAP integration (nvim-dap + nvim-dap-ui)
│       ├── dotnet.lua            # .NET development (easy-dotnet.nvim)
│       ├── dracula.lua           # Dracula colorscheme
│       ├── gitsigns.lua          # Git gutter signs & keymaps
│       ├── indent-line.lua       # Indentation guides (indent-blankline)
│       ├── lazy-dev.lua          # Lua LSP helpers for Neovim config
│       ├── lint.lua              # Linting framework (nvim-lint)
│       ├── lsp.lua               # LSP client setup (mason, lspconfig)
│       ├── mini.lua              # mini.ai, mini.surround, mini.statusline
│       ├── neo-tree.lua          # File explorer
│       ├── neotest.lua           # Test runner (Elixir, Jest, Vitest, Playwright, .NET)
│       ├── noice.lua             # UI notifications & command-line
│       ├── opencode.lua          # AI coding assistant
│       ├── snacks.lua            # Dashboard & quickfile
│       ├── telescope.lua         # Fuzzy finder
│       ├── todo-comments.lua     # TODO / FIXME comment highlighting
│       ├── treesitter.lua        # Treesitter parsers
│       ├── ts-tools.lua          # TypeScript LSP enhancements
│       └── which-key.lua         # Keybinding popup
├── lazy-lock.json            # Locked plugin versions
├── .stylua.toml              # StyLua formatter config
└── selene.toml               # Selene linter config
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

```sh
# OpenSUSE Tumbleweed
sudo zypper install ripgrep fzf fd nodejs
```

For the .NET SDK, follow the [official Microsoft installation guide](https://learn.microsoft.com/dotnet/core/install/linux).

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
| ------- | ---------------- |
| 0.10+   | 0.12.4           |

The configuration is validated in CI against **Neovim 0.12.4** and requires **0.10+** (enforced by the built-in health check). It uses vim.lsp.config (0.11+), vim.treesitter (0.10+), and other modern APIs.

## ⚗️ XDG Base Directory Variables

Neovim follows the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/) to locate its configuration, data, and cache directories. You can customize these paths per operating system.

### 🪟 Windows

```powershell
[System.Environment]::SetEnvironmentVariable('XDG_DATA_HOME', 'D:\', 'User')
[System.Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', 'D:\dotfiles', 'User')
```

### 🍎 macOS

XDG base directories are not set by default on macOS. Add the following to your shell profile (`~/.zshrc`, `~/.bashrc`, etc.):

```sh
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
```

### 🐧 Linux

XDG base directories are typically pre-configured on most Linux distributions. To customize them, add the following to your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):

```sh
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
```
