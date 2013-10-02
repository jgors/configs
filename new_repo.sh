#! /bin/bash

echo "--> Installing Vundle in .configs/.vim/bundle/vundle..."
git clone https://github.com/gmarik/vundle.git ~/.configs/.vim/bundle/vundle

cd ~/.configs

<<<<<<< HEAD
echo "\n--> Replacing ~/.vimrc file with link from ~/.configs..."
rm ~/.vimrc
ln -s -v ~/.configs/.vimrc ~/.vimrc

echo "\n--> Replacing ~/.vim dir with link from ~/.configs..."
rm -rf ~/.vim
ln -s -v ~/.configs/.vim ~/.vim

echo "\n--> Replacing ~/.tmux.conf file  with link from ~/.configs..."
rm ~/.tmux.conf
ln -s -v ~/.configs/.tmux.conf ~/.tmux.conf

echo "\n--> Updating all Vundle Bundles..."
=======
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
echo "--> Updating all Vundle Bundles..."
>>>>>>> 27c165b3b9f10352048fe4e81f9c2c5f9faf8280
vim +BundleInstall +qall

