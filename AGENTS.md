# AGENTS.md

## Overview

This is a dotfiles repository providing automated development environment setup for macOS and Ubuntu. It configures shell (zsh), terminal tools, and Neovim.

## Repository Structure

```
├── macos/          # macOS-specific setup and configs
├── ubuntu/         # Ubuntu-specific setup and configs
├── nvim/           # Shared Neovim configuration (Lua-based)
└── README.md
```

## Key Components

### Setup Scripts

- `macos/setup.sh` - Installs Homebrew, CLI tools, GUI apps, language version managers
- `ubuntu/setup.sh` - Installs packages via apt, bob (nvim manager), Docker, tmux

### Shell Configuration

- Uses zsh with zplug plugin manager
- Plugins: autosuggestions, completions, syntax-highlighting, git
- Starship prompt
- Custom aliases in `env.zsh` files

### Neovim Configuration

- Plugin manager: lazy.nvim (`nvim/lua/leunguu/lazy.lua`)
- Core settings: `nvim/lua/leunguu/core/` (options, keymaps)
- Plugins: `nvim/lua/leunguu/plugins/` (telescope, neo-tree, LSP, treesitter, etc.)
- Leader key: `<Space>`

## Conventions

- Shell configs follow zplug patterns
- Neovim plugins use lazy.nvim spec format
- Each nvim plugin has its own file in `plugins/`
- LSP configs are in `plugins/lsp/`

## Common Tasks

- Add new nvim plugin: Create file in `nvim/lua/leunguu/plugins/`
- Add shell alias: Edit `macos/env.zsh` or `ubuntu/env.zsh`
- Add brew package: Edit `PACKAGES` array in `macos/setup.sh`
- Add apt package: Edit `ubuntu/setup.sh`
