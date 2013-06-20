#! /bin/bash

echo "--> Installing Vundle in .configs/.vim/bundle/vundle..."
git clone https://github.com/gmarik/vundle.git ~/.configs/.vim/bundle/vundle

cd ~/.configs

echo "--> Replacing ~/.vimrc file with link from ~/.configs..."
rm ~/.vimrc
ln -s ~/.configs/.vimrc ~/.vimrc

echo "--> Replacing ~/.vim dir with link from ~/.configs..."
rm -rf ~/.vim
ln -s ~/.configs/.vim ~/.vim

echo "--> Replacing ~/.tmux.conf file  with link from ~/.configs..."
rm ~/.tmux.conf
ln -s ~/.configs/.tmux.conf ~/.tmux.conf

echo "--> Updating all Vundle Bundles..."
vim +BundleInstall +qall

