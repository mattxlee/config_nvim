# Nvim config file

## Setup NeoVim for different purposes

There are two branches: main, lsp.

* main - The branch contains the config files without any LSP support.

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
alias sv=`sudo -E -s nvim`
```
