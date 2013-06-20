## For syncing configurations across computers

#### To set up new repo (eg. on a new machine):
###### (NOTE, if wanted, back config files up before running new_repo.sh -- it replaces some dirs/files) 
```
cd ~
git clone http://github.com/jgors/configs.git ~/.configs
cd ~/.configs
sh ./new_repo.sh
```

#### To upgrade repo and all plugins to latest releases:
```
cd ~/.configs
git pull
vim +BundleInstall +qall

git add .; git commit -m 'updated all plugins & config files'; git push
```

#### To Add a vim plugin:
```
## Add plugin listing to:
vim ~/.configs/.vimrc.vundle_bundles

# Pull in the new plugin (and update the others):
vim +BundleInstall +qall

# Tell github of changes:
git add .
git commit -m 'added BUNDLE_NAME and updated others'
git push
```

#### To Remove a vim plugin:
```
## Remove plugin listing from:
vim ~/.configs/.vimrc.vundle_bundles

# Delete the plugin dir with:
# rm -rf ~/.vim/bundle/BUNDLE_NAME
# or
rm -rf ~/.configs/.vim/bundle/BUNDLE_NAME

# Tell github of changes:
cd ~/.configs
git add -A
git commit -m 'removed BUNDLE_NAME'
git push

```
