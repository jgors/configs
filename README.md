## For syncing configurations across computers

#### To set up new repo (eg. on a new machine):
###### (NOTE, if wanted, back up config files before running new_repo.sh -- it replaces current config files) 
```
cd ~
<<<<<<< HEAD
git clone https://github.com/jgors/configs.git ~/.configs
=======
git clone http://github.com/jgors/configs.git ~/.configs
>>>>>>> 27c165b3b9f10352048fe4e81f9c2c5f9faf8280
cd ~/.configs
sh ./new_repo.sh
```

#### To update repo and all plugins to latest releases:
```
cd ~/.configs
git pull

<<<<<<< HEAD
# remove any plugins that are not sourced in ~/.vim/.vimrc.vundle_bundles
=======
# remove any plugins that are not sourced in ~/.vim/vundle_bundles.vim
>>>>>>> 27c165b3b9f10352048fe4e81f9c2c5f9faf8280
vim +BundleClean +qall

# update plugins that are sourced
vim +BundleInstall +qall

git add .; git commit -m 'updated all plugins & config files'; git push
```

#### To Add a vim plugin:
```
## Add plugin listing to:
<<<<<<< HEAD
vim ~/.vim/.vimrc.vundle_bundles
=======
vim ~/.vim/vundle_bundles.vim
>>>>>>> 27c165b3b9f10352048fe4e81f9c2c5f9faf8280

# Pull in the new plugin (and update the others):
vim +BundleInstall +qall

# Tell github of changes:
git add .
git commit -m 'updated plugins and added BUNDLE_NAME'
git push
```

#### To Remove a vim plugin:
```
## Remove plugin listing from:
<<<<<<< HEAD
vim ~/.vim/.vimrc.vundle_bundles
=======
vim ~/.vim/vundle_bundles.vim
>>>>>>> 27c165b3b9f10352048fe4e81f9c2c5f9faf8280

# Delete the plugin dir with:
rm -rf ~/.vim/bundle/BUNDLE_NAME

# Tell github of changes:
cd ~/.configs
git add -A
git commit -m 'removed BUNDLE_NAME'
git push

```
