# Nvim config file

## Install Neovim

Please use version 0.11.x otherwise you will meet some issues. From macOS, use
`brew` to install header version:

```bash
brew install --head neovim
```

## Initialize config files

Run the following command to initialize the config files:

```bash
git clone https://github.com/mattxlee/config_nvim ~/.config/nvim
```

After the repo is cloned, simply run `nvim` and it will start to download all
plugins automatically.

## Run with root privileges with config files applied

Add the following line to your `$HOME/.profile` and ensure it will be executed
by `.bashrc` or `.zshrc`. And you can use command `sv` to run nvim with root
privileges but preserve the environment.

```bash
alias sv='sudo -E -s nvim'
```

## Setup with tmux

You need to modify the tmux config file `$HOME/.tmux.conf`.

### Use vim key bindings

Add the following line to tmux config file:

```
setw -g mode-keys vi
```

### Setup colors and fonts

Please install WezTerm under your macOS and config it with following
instructions. Add following lines to tmux config file to apply the terminal
settings, nvim from a tmux session will has font italic/bold support.

* macOS

```
set -g default-terminal "xterm-256color"
set -ga terminal-overrides ",xterm-256color:RGB"
```

* Linux

```
set -g default-terminal 'tmux-256color'
set -ga terminal-overrides ',xterm*:Tc:sitm=\E[3m'
```

## Use install script

The main function of the script `install.sh` from root dir of the project is
used to prepare config and related files for oh-my-zsh. Run it directly and it
will clone necessary repos from github and also copy the necessary dot files.

Please note: The script will not copy those dot files which exists already from
your $HOME dir. Thus, you might need to copy them manually, especially the file
`.zshrc`.

## External tools

You need to install the following tools from your os in order to work with nvim
properly.

* Lazygit - the default git manager tool the nvim with <c-g>.

```bash
brew install lazygit
```

* Ripgrep - for searching in files.

```bash
brew install ripgrep
```

* Python3 - some of the lsp will require Python3, you might need to install pip
  as well.

* Tailwindcss - edit with css related files will cause an error that the
  tailwindcss command cannot be found, install `Tailwindcss` by using the
  following command to fix the issue (install npm first):

```bash
npm install -g @tailwindcss/language-server
```