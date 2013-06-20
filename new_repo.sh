#! /bin/bash

echo "Installing Vundle in .configs/.vim/bundle/vundle..."
git clone https://github.com/gmarik/vundle.git ~/.configs/.vim/bundle/vundle

cd ~/.configs

echo "Making link for ~/.vimrc file..."
rm ~/.vimrc
ln -s ~/.configs/.vimrc ~/.vimrc

echo "Making link for ~/.vim dir..."
rm -rf ~/.vim
ln -s ~/.configs/.vim ~/.vim

echo "Making link for .tmux.conf file..."
ln -s ~/.configs/.tmux.conf ~/.tmux.conf

echo "Updating all Vundle Bundles..."
vim +BundleInstall +qall

