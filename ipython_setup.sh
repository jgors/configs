echo "Creating ipython profile."
ipython profile create
echo "Adding customized ipython vim keybindings."
ln -sfv ~/.configs/ipy_keybindings.py ~/.ipython/profile_default/startup/
echo "Making vim the default keybindings in ipython."
python3 ~/.configs/update_ipython_config.py
