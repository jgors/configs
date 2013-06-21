#! /bin/bash

echo "--> Installing Vundle in .configs/.vim/bundle/vundle..."
git clone https://github.com/gmarik/vundle.git ~/.configs/.vim/bundle/vundle

cd ~/.configs

echo -e "\n--> Replacing ~/.vimrc file with link from ~/.configs..."
rm ~/.vimrc
ln -s -v ~/.configs/.vimrc ~/.vimrc

echo -e "\n--> Replacing ~/.vim dir with link from ~/.configs..."
rm -rf ~/.vim
ln -s -v ~/.configs/.vim ~/.vim

echo -e "\n--> Replacing ~/.tmux.conf file  with link from ~/.configs..."
rm ~/.tmux.conf
ln -s -v ~/.configs/.tmux.conf ~/.tmux.conf

echo -e "\n--> Updating all Vundle Bundles..."
vim +BundleInstall +qall

