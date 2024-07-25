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

## Shortcuts

### Find and replace

|Shortcut|Command|Comment|
|-|-|-|
|<leader>h|Find & replace|Open Spectre to do find and replace|
|<leader>l|Find cursor word|Open telescope and find cursor word from current workspace|
|<leader>f|Fuzzy find|Open telescope and find characters from current workspace|

### Language Server Provider related

|Shortcut|Command|Comment|
|-|-|-|
|<leader>g|Find symbol|Find symbol from current workspace|
|<leader>o|Find symbol from buffer|Find symbol from current buffer|
|gr|Find references|Find references of the symbol from cursor word|
|]d|Next diagnostics|Jump to next diagnostics which is provided by Lsp|
|[d|Previous diagnostics|Jump to previous diagnostics which is provided by Lsp|
|;d|Show diagnostics info.|Show diagnostics info. about the line|
|<leader>rn|Rename|Rename cursor symbol with popup window|
|<leader>ca|Code action|Show code action list for current issue|
|gh|Show info.|Show code info. of cursor symbol|

### Completion

|Shortcut|Command|Comment|
|-|-|-|
|tab|Confirm|Select the highlight entry from list|
|<c-l>|Trigger completion|Show completion list manually|
|<c-k>|Close completion|Close completion list manually|
|<c-n>|Select next|Select next entry from completion list|
|<c-p>|Select previous|Select previous entry from completion list|
|<c-f>|Next placeholder|Jump to next place holder|
|<c-b>|Previous placeholder|Jump to previous place holder|

### Move cursor/jumping files

|Shortcut|Command|Comment|
|-|-|-|
|gd|Goto definition|Goto definition from cursor word|
|<c-h>|Switch header/source|Find and switch to the related (header or source), it words only when the type of current buffer is cpp|
|<c-p>|Jump files|Show file list and jump|

### File explorer

|Shortcut|Command|Comment|
|-|-|-|
|<c-j>|Open file explorer|Open file explorer with current file located|
|<leader>e|Open/Close file explorer|Open or close file explorer|

### Git related

|Shortcut|Command|Comment|
|-|-|-|
|<c-g>|Git status|Show current status of current git repo|
|]c|Goto next change|Find and move cursor to next changed hunk|
|[c|Goto previous change|Find and move cursor to previous changed hunk|
|<leader>rr|Reset hunk|Restore current changed hunk|
|<leader>bb|Show blame|Show blame info. of current line|

### Code edit

|Shortcut|Command|Comment|
|-|-|-|
|<leader>t|Format|Format current buffer with configured formatter|
|<leader>y|Doc gen.|Generate document from current line|

### Misc.

|Shortcut|Command|Comment|
|-|-|-|
|<leader>a|Plugin manager|Show plugin manager|
|<leader>m|Lsp manager|Show manager window of Lsp plugins|
