To sync configurations across computers:

##### << To set up new repo (ex. on new machine) >>
###### (NOTE, if wanted, back config files up before running new_repo.sh, as it replaces them) 
```
cd ~
git clone http://github.com/jgors/configs.git ~/.configs
cd ~/.configs
sh ./new_repo.sh
```

##### << To upgrade all plugins/bundles to latest releases >>
```
vim +BundleInstall +qall
```

##### << To add or remove a vim plugin/bundle >> 
```
* just add/remove the plugin listing in:

~/.configs/.vimrc.vundle_bundles

* (when removing) then delete the plugin dir in either:

~/.vim/bundle dir or ~/.configs/.vim/bundle
```
