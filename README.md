### To sync configurations across computers:

#### To set up new repo (ex. on new machine)
###### (NOTE, if wanted, back config files up before running new_repo.sh, as it replaces them) 
```
cd ~
git clone http://github.com/jgors/configs.git ~/.configs
cd ~/.configs
sh ./new_repo.sh
```

#### To upgrade repo and all plugins/bundles to latest releases
```
cd ~/.configs
git pull
vim +BundleInstall +qall
```

#### To add or remove a vim plugin/bundle
```
# Add/Remove plugin listing in:
vim ~/.configs/.vimrc.vundle_bundles

# (If removing) then delete the plugin dir with:
# rm -rf ~/.vim/bundle/BUNDLE_TO_DELETE
# or
rm -rf ~/.configs/.vim/bundle/BUNDLE_NAME

# Lastly, tell github of changes:
git add .
git commit -m 'added/removed BUNDLE_NAME'
git push

```
