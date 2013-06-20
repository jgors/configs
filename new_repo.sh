#! /bin/bash

echo "Installing Vundle in .configs/.vim/bundle/vundle..."
git clone https://github.com/gmarik/vundle.git ~/.configs/.vim/bundle/vundle

cd ~/.configs

if [[ ( ! -f ~/.vimrc ) ]]; then
    echo "Making link for ~/.vimrc file..."
    ln -s ~/.configs/.vimrc ~/.vimrc
fi

if [[ ( ! -d ~/.vim ) ]]; then
    echo "Making link for ~/.vim dir..."
    ln -s ~/.configs/.vim ~/.vim
fi

if [[ ( ! -f ~/.tmux.conf ) ]]; then
    echo "Making link for .tmux.conf file..."
    ln -s ~/.configs/.vimrc ~/.tmux.conf
fi


echo "Updating all Vundle Bundles..."
vim +BundleInstall +qall

