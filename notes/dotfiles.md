
## Intialize a bare repo
```
git init --bare $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no 
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```
## Intialize repo on other machine
```
git clone --bare git@github.com:ppioli/dotfiles.git $HOME/.dotfiles
```
## Checkout files
```
config checkout
```
