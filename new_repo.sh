#! /bin/bash

echo "\n--> INSTALLING SYSTEM PKGS"
sudo apt-get update
sudo apt-get install vim vim-gnome zsh tmux python-pip htop exuberant-ctags fonts-inconsolata
pip install pip --user --upgrade
pip install ipython --user --upgrade
pip install jupyter --user --upgrade

configs=~/.configs

echo "\n--> Changing default shell to zsh"
#sudo chsh -s $(which zsh) $(whoami)
chsh -s /bin/zsh
sudo chsh -s /bin/zsh

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
rm $vimrc
#mv ~/{.vimrc,.vimrc_old}
ln -s -v ~/.configs/.vimrc $vimrc

vim_dir=~/.vim
echo "\n--> Replacing" $vim_dir "dir with link from" $configs
# create the undo dir if it doesn't already exist (but it shouldn't)
[ ! -d ~/.configs/.vim/undodir ] && mkdir ~/.configs/.vim/undodir
rm -rf $vim_dir
#mv ~/{.vim,.vim_old}
ln -s -v ~/.configs/.vim $vim_dir

tmux_conf=~/.tmux.conf
echo "\n--> Replacing" $tmux_conf "file with link from" $configs
rm $tmux_conf
#mv ~/{.tmux.conf,.tmux_old.conf}
ln -s -v ~/.configs/.tmux.conf $tmux_conf

zsh_dir=~/.zsh
echo "\n--> Replacing" $zsh_dir "dir with link from" $configs
rm -rf $zsh_dir
#mv ~/{.zsh,.zsh_old}
ln -s -v ~/.configs/.zsh $zsh_dir

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
rm $inputrc
#mv ~/{.inputrc,.inputrc_old}
ln -s -v ~/.configs/.inputrc $inputrc

echo "\n--> Updating all Vundle Bundles"
vim +BundleInstall +qall

echo "\n--> Setting up ipython to use vim keybindings"
ipython profile create
cp ~/.configs/ipy5_keybindings.py ~/.ipython/profile_default/startup/
python ~/.configs/update_ipython_config.py

echo "\n--> Setting up jupyter to use vim keybindings in notebook"
echo "--> NOTE:  for this to work, need to make sure this extension is"
echo "--> installed:  https://github.com/lambdalisue/jupyter-vim-binding"
if [ ! -d ~/.jupyter/custom ]; then
    echo "\n--> making ~/.jupyter/custom"
    cp -R $configs/.jupyter/custom ~/.jupyter
else
    echo "\n--> Updating ~/.jupyter/custom"
    cp $configs/.jupyter/custom/custom.js ~/.jupyter/custom
    cp $configs/.jupyter/custom/custom.css ~/.jupyter/custom
fi
