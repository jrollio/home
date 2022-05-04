# home

A repo of dotfiles for tailoring vs code dev shell environments to suit personal tastes in CLI navigation and usage :-)

## Configuration
To use the automation in VS Code, configure VS Code settings.json as:
    "dotfiles.repository": "jonathanroll/home",
    "dotfiles.targetPath": "~/home",
    "remote.containers.dotfiles.installCommand": "install.sh",
    "remote.containers.dotfiles.repository": "jonathanroll/home",
    "remote.containers.dotfiles.targetPath": "~/home"

### .alias
Define your command aliases in this file

### .env
The "container" file that reads in the definition files

### .paths
Define your command and manpaths here

### install.sh
Implements the customizations in home directory of VS Code Remote Containers (and other places, if needed)
#### Actions
1. Copies dotfiles to home directory
2. Inserts modf.txt stanza into .bashrc
 
### modf.txt
The excerpt of code that install.sh inserts into .bashrc
