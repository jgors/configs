#! /bin/bash

echo "--> INSTALLING SYSTEM PKGS"
sudo apt-get update
sudo apt-get install vim vim-gnome zsh tmux python-pip htop
pip install pip --user --upgrade
pip install ipython --user --upgrade

echo "--> Changing default shell to zsh"
#sudo chsh -s $(which zsh) $(whoami)
sudo chsh -s /bin/zsh

echo "--> Installing Vundle in .configs/.vim/bundle/vundle"
git clone https://github.com/gmarik/vundle.git ~/.configs/.vim/bundle/vundle

cd ~/.configs

echo
echo "--> Replacing ~/.vimrc file with link from ~/.configs"
mv ~/{.vimrc,.vimrc_old}
ln -s -v ~/.configs/.vimrc ~/.vimrc

echo
echo "--> Replacing ~/.vim dir with link from ~/.configs"
# create the undo dir if it doesn't already exist (but it shouldn't)
[ ! -d ~/.configs/.vim/undodir ] && mkdir ~/.configs/.vim/undodir
#rm -rf ~/.vim
mv ~/{.vim,.vim_old}
ln -s -v ~/.configs/.vim ~/.vim

echo
echo "--> Replacing ~/.tmux.conf file with link from ~/.configs"
#rm ~/.tmux.conf
mv ~/{.tmux.conf,.tmux_old.conf}
ln -s -v ~/.configs/.tmux.conf ~/.tmux.conf

echo
echo "--> Replacing ~/.zsh dir with link from ~/.configs"
#rm -rf ~/.zsh
mv ~/{.zsh,.zsh_old}
ln -s -v ~/.configs/.zsh ~/.zsh
echo "############################################"
#echo "NOTE:  ADD THIS AT THE TOP OF ~/.zshrc file:"
#echo "source ~/.zsh/zsh_cmds_under_version_control.zsh"
echo "source ~/.zsh/zsh_cmds_under_version_control.zsh" >> ~/.zshrc
echo "############################################"

echo
echo "--> Replacing ~/.inputrc file with link from ~/.configs"
#rm ~/.inputrc
mv ~/{.inputrc,.inputrc_old}
ln -s -v ~/.configs/.inputrc ~/.inputrc

echo
echo "--> Updating all Vundle Bundles..."
vim +BundleInstall +qall
