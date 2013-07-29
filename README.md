## For syncing configurations across computers

#### To set up new repo (eg. on a new machine):
###### (NOTE, if wanted, back up config files before running new_repo.sh -- it replaces current config files) 
```
cd ~
git clone http://github.com/jgors/configs.git ~/.configs
cd ~/.configs
sh ./new_repo.sh
```

#### To update repo and all plugins to latest releases:
```
cd ~/.configs
git pull

# remove any plugins that are not sourced in ~/.vim/.vimrc.vundle_bundles
vim +BundleClean +qall

# update plugins that are sourced
vim +BundleInstall +qall

git add .; git commit -m 'updated all plugins & config files'; git push
```

#### To Add a vim plugin:
```
## Add plugin listing to:
vim ~/.vim/.vimrc.vundle_bundles

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
vim ~/.vim/.vimrc.vundle_bundles

# Delete the plugin dir with:
rm -rf ~/.vim/bundle/BUNDLE_NAME

# Tell github of changes:
cd ~/.configs
git add -A
git commit -m 'removed BUNDLE_NAME'
git push

```
