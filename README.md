# Nvim config file

## Setup NeoVim for different purposes

There are two branches: main, lsp.

* main - The branch contains the config files without any LSP support but treesitter is installed.

* lsp - The branch contains the config files with LSP and treesitter support.

### Normal text editor

Normally, clone the branch `main` to setup NeoVim as a text-editor, run the following command to initialize the settings:

```bash
git clone https://github.com/mattxlee/config_nvim ~/.config/nvim
```

After the repo is cloned, simply run `nvim` and it will start to download all plugins automatically.

### Act like an IDE

The default config path for NeoVim is `$HOME/.config/nvim`, but you can set a new value to environment varialbe `NVIM_APPNAME` to change it. For example, after you setup `NVIM_APPNAME=nvim-lsp` and run NeoVim, it will load config from path `$HOME/.config/nvim-lsp`, we can use this mechanism to run NeoVim with different setup.

**Setup your system environment**

Add the following line to your `$HOME/.profile` and ensure it will be executed by `.bashrc` or `.zshrc`.

```bash
alias vl='NVIM_APPNAME=nvim-lsp nvim'
```

Logout and login again to apply the changes or use command `source ~/.profile`.

**Clone repo**

```bash
git clone -b lsp https://github.com/mattxlee/config_nvim ~/.config/nvim-lsp
```

**Setup NeoVim on first time it starts up**

Run command `vl`, the new settings will drive NeoVim to download plugins.

### Preserve config with `sudo`

Add another alias command to `$HOME/.profile`, and use `sv` to run nvim with root privileges but preserve the environment.

```bash
alias sv='sudo -E -s nvim'
```

## How to setup with tmux

You need to modify the tmux config file `$HOME/.tmux.conf`

### Use vim key bindings

Add the following line to tmux config file:

```
setw -g mode-keys vi
```

### Setup colors and fonts

Please install WezTerm under your macOS and config it with following instructions. Add following lines to tmux config file to apply the terminal settings, nvim from a tmux session will has font italic/bold support.

* macOS

```
set -g default-terminal "xterm-256color"
set -ga terminal-overrides ",xterm-256color:RGB"
```

* Linux

```
set -g default-terminal 'tmux-256color'
set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'
```

## External tools

You need to install the following tools from your os in order to work with nvim properly.

* Lazygit - the default git manager tool the nvim with <c-g>.

* Ripgrep - for searching in files.

* Python3 - some of the lsp will require Python3, you might need to install pip as well.