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

#### To add or remove a vim plugin/bundle:
```
# Add/Remove plugin listing in:
vim ~/.configs/.vimrc.vundle_bundles

# (If removing) then delete the plugin dir with:
# rm -rf ~/.vim/bundle/BUNDLE_NAME
# or
rm -rf ~/.configs/.vim/bundle/BUNDLE_NAME

# Lastly, tell github of changes:
cd ~/.configs
git add .
git commit -m 'added/removed BUNDLE_NAME'
git push

```
