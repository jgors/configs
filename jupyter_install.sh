echo "\n--> INSTALLING PYTHON PKG jupyter"
pip3 install jupyter --user --upgrade

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
ln -sfv ~/.configs/.jupyter/custom/custom.js $jupyter_custom
ln -sfv ~/.configs/.jupyter/custom/custom.css $jupyter_custom
