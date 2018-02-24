#! /bin/bash

echo "\n--> INSTALLING SYSTEM PKGS"
sudo apt-get update
sudo apt-get install vim vim-gnome zsh tmux python-pip htop exuberant-ctags fonts-inconsolata xclip git
pip install pip --user --upgrade
pip install ipython --user --upgrade
pip install jupyter --user --upgrade
pip install pylint --user --upgrade
pip install autopep8 --user --upgrade


configs=~/.configs

echo "\n--> Changing default shell to zsh"
sudo chsh -s $(which zsh) $(whoami)
#chsh -s /bin/zsh
#sudo chsh -s /bin/zsh

vundle_dir=~/.configs/.vim/bundle/vundle
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
ln -sfv ~/.configs/.vimrc $vimrc

vim_dir=~/.vim
echo "\n--> Replacing" $vim_dir "dir with link from" $configs
# create the undo dir if it doesn't already exist (but it shouldn't)
[ ! -d ~/.configs/.vim/undodir ] && mkdir ~/.configs/.vim/undodir
ln -sfv ~/.configs/.vim ~/

tmux_conf=~/.tmux.conf
echo "\n--> Replacing" $tmux_conf "file with link from" $configs
ln -sfv ~/.configs/.tmux.conf $tmux_conf

zsh_dir=~/.zsh
echo "\n--> Replacing" $zsh_dir "dir with link from" $configs
ln -sfv ~/.configs/.zsh ~/

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
ln -sfv ~/.configs/.inputrc $inputrc

echo "\n--> Updating all Vundle Bundles"
vim +BundleInstall +qall

echo "\n--> Setting up ipython to use vim keybindings"
ipython profile create
ln -sfv ~/.configs/ipy_keybindings.py ~/.ipython/profile_default/startup/
python ~/.configs/update_ipython_config.py

echo "\n--> Setting up jupyter to use vim keybindings in notebook"
echo "--> NOTE:  for this to work, need to make sure this extension is"
echo "--> installed:  https://github.com/lambdalisue/jupyter-vim-binding"
jupyter_custom=~/.jupyter/custom
if [ ! -d $jupyter_custom ]; then
    echo "\n--> Making" $jupyter_custom
    mkdir $jupyter_custom
else
    echo "--> Updating" $jupyter_custom
fi
ln -sfv $configs/.jupyter/custom/custom.js $jupyter_custom
ln -sfv $configs/.jupyter/custom/custom.css $jupyter_custom

redshift_conf=~/.config/redshift.conf
echo "\n--> Replacing" $redshift_conf "file with link from" $configs
ln -sfv ~/.configs/redshift.conf $redshift_conf
