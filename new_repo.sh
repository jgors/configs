#! /bin/bash

echo "--> Installing Vundle in .configs/.vim/bundle/vundle..."
git clone https://github.com/gmarik/vundle.git ~/.configs/.vim/bundle/vundle

cd ~/.configs

echo
echo "--> Replacing ~/.vimrc file with link from ~/.configs..."
rm ~/.vimrc
ln -s -v ~/.configs/.vimrc ~/.vimrc

echo
echo "--> Replacing ~/.vim dir with link from ~/.configs..."
rm -rf ~/.vim 
ln -s -v ~/.configs/.vim ~/.vim

echo
echo "--> Replacing ~/.tmux.conf file with link from ~/.configs..."
rm ~/.tmux.conf 
ln -s -v ~/.configs/.tmux.conf ~/.tmux.conf

echo
echo "--> Replacing ~/.zsh dir with link from ~/.configs..."
rm -rf ~/.zsh
ln -s -v ~/.configs/.zsh ~/.zsh
echo "############################################"
echo "NOTE:  ADD THIS AT THE TOP OF ~/.zshrc file:"
echo "source ~/.zsh/zsh_cmds_under_version_control.zsh"
echo "############################################"

echo
echo "--> Replacing ~/.inputrc file with link from ~/.configs..."
rm ~/.inputrc
ln -s -v ~/.configs/.inputrc ~/.inputrc

echo
echo "--> Updating all Vundle Bundles..."
vim +BundleInstall +qall
