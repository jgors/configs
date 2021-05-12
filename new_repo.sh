#! /bin/bash

echo "\n--> INSTALLING SYSTEM PKGS"
sudo apt update && sudo apt upgrade -y
sudo apt-get install vim vim-gtk3 zsh tmux python3-pip htop exuberant-ctags fonts-inconsolata xclip git

echo "\n--> INSTALLING PYTHON PKGS"
pip install ipython --user --upgrade
pip install pylint --user --upgrade
pip install autopep8 --user --upgrade

configs=~/.configs

echo "\n--> Changing default shell to zsh"
sudo chsh -s $(which zsh) $(whoami)
#sudo chsh -s $(which zsh)

vundle_dir=$configs/.vim/bundle/vundle
if [ ! -d $vundle_dir ]; then
    echo "\n--> Installing Vundle in" $vundle_dir
    git clone https://github.com/gmarik/vundle.git $vundle_dir
else
    echo "\n--> Updating Vundle in" $vundle_dir
    cd $vundle_dir
    git pull
fi

vimrc=~/.vimrc
echo "\n--> Replacing" $vimrc "file with link from" $configs
ln -sfv $configs/.vimrc $vimrc

vim_dir=~/.vim
echo "\n--> Replacing" $vim_dir "dir with link from" $configs
# create the undo dir if it doesn't already exist (but it shouldn't)
[ ! -d $configs/.vim/undodir ] && mkdir $configs/.vim/undodir
ln -sfv $configs/.vim ~/

tmux_conf=~/.tmux.conf
echo "\n--> Replacing" $tmux_conf "file with link from" $configs
ln -sfv $configs/.tmux.conf $tmux_conf

zsh_dir=~/.zsh
echo "\n--> Replacing" $zsh_dir "dir with link from" $configs
ln -sfv $configs/.zsh ~/

zshrc=~/.zshrc
echo "\nAdding sourced zsh file to" $zshrc
if [ ! -e $zshrc ]; then
    echo "source ~/.zsh/zsh_cmds_under_version_control.zsh" >> $zshrc
else
    echo '#########################################'
    echo $zshrc "ALREADY EXISTS -- make sure this is at the top of it:"
    echo "source ~/.zsh/zsh_cmds_under_version_control.zsh"
    echo '#########################################'
fi

inputrc=~/.inputrc
echo "\n--> Replacing" $inputrc "file with link from" $configs
ln -sfv $configs/.inputrc $inputrc

echo "\n--> Updating all Vundle Bundles"
vim +BundleInstall +qall

echo "\n--> Setting up ipython to use vim keybindings"
sh $configs/ipython_setup.sh

#echo "\n--> INSTALLING PYTHON PKG jupyter"
#sh $configs/jupyter_install.sh
