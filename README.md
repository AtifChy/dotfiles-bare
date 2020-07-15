#  Dotfiles

Dotfiles are the customization files that are used to personalize your Linux or other Unix-based system.  You can tell that a file is a dotfile because the name of the file will begin with a period--a dot!  The period at the beginning of a filename or directory name indicates that it is a hidden file or directory.  This repository contains my personal dotfiles.  They are stored here for convenience so that I may quickly access them on new machines or new installs.  Also, others may find some of my configurations helpful in customizing their own dotfiles.  

#  Install dotfiles
Clone Repo:
```
git clone --bare https://github.com/AtifChy/dotfiles.git $HOME/Documents/Dotfiles
```
Add dotfile alias to .bashrc or .zshrc:
```
alias dotfile='git --git-dir=$HOME/Documents/Dotfiles/ --work-tree=$HOME'
```
Ignore unnecessary files (IMPORTANT):
```
dotfile config --local status.showUntrackedFiles no
```
Replace existing files with the files from the repo:
```
dotfile checkout -f
```
