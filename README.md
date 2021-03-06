# Neovim config scripts

This is my config script for nvim, feel free to use it.

## Prepare

* You need to install Git or the git related plugin will be disabled automatically.

* You need to install python3 and pip3 in order to obtain `pynvim`.

* You need to install `universal-ctags` to use ctags from nvim. Under macOS, you can use Homebrew to install it `brew install universal-ctags`.

* You need to install silver ag searcher on your system in order to search text from all files in your project. For example, you can use Homebrew to install the searcher by typing the command `brew install the_silver_searcher`.

## Install

First you need to install the plugin `packer` by cloning the repo from github:

*MacOS(Or Linux):*

`curl -s -L https://github.com/mattxlee/config_nvim/raw/master/install.sh | bash`

*Windows (Run the command under powershell):*

`git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"`

`git clone https://github.com/mattxlee/config_nvim "$env:LOCALAPPDATA\nvim"`

After those 2 repo have been downloaded to the correct place, please ensure the plugin 'pynvim' has been installed by using the following command

`python -m pip install --user --upgrade pynvim`

## Update plugins

Use `:PackerSync` to install/update plugins. Or you can just run shell command `nvim +PackerSync` to invoke the syncing procedure. Please ignore the errors on the first one.

For more information about the plugin manager, please visit [Packer](https://github.com/wbthomason/packer.nvim)

## Manage git repo

* Use `ctrl+g` to show file status and make new commit.

* Use `gu` to push current branch to remote repo.

## Format current file

Use `shift+c` to format current file (normal mode).

## Trim whitespace on the end of line

Use `ctrl+t` to get ride of the whitespace on the end of line.

## Global search in files

Use `<leader>ff` to type and search text in the files from current project.

* To paste text from system clipboard, press `ctrl+r` with `*`

* To paste text from vim yark buffer, press `ctrl+r` with `"`

Learn more about the text search plugin, please visit [vim-esearch](https://github.com/eugen0329/vim-esearch)

## Jump to tags

* Use `<leader>o` to show the functions list from current opened file.

* Use `<leader>g` to global search tags.

* Use `ctrl+]` to jump to the location of the declaration of the tag above the cursor.

* Use `ctrl+o` to return to the previous position.

## File explorer (Nvim-tree)

Use `ctrl+j` to show the explorer.

## Select and open file

Use `ctrl+p` to show local files filter, type name and open file.

## Working with workspaces

* Use `<leader><leader>a` to add current dir to workspace and also start session autosaving.

* Use `<leader>a` to select a workspace.

* Use `<leader><leader>d` to remove all buffers.

## Make and CMake support

**Note: AsyncRun is the plugin make task running in async mode. Use shortcut `ctrl+k` to stop current running task.**

* Command `mk`: When `Makefile` file exists from the root of the project folder, shortcut `mk` will run command `make` to compile the file. Otherwise `mk` will try to run make script generated by CMake under the folder `./build`.

* Use `ctrl+k` to kill the making process.

* Command `mc`: Clear the output files with the same logic of command `mk`.

* Command `<leader>n`: Show next compile errors and jump to the related file.

* Command `<leader>p`: Show previous compile errors and jump to the related file.

## Close tool panels

Use shortcut `shift+m` to close all other tool panels in normal mode.

## Autocomplete by using LSP

Use `ctrl+l` to trigger the autocomplete, `ctrl+n` or `ctrl+p` to select the items.

Use command `:LspInstallInfo` to show all language server and use key `i` to install, or `X` to uninstall.
