To sync configurations across computers:


```
#    << To set up new repo (ex. on new machine) >>

cd ~
git clone http://github.com/jgors/config_set-ups.git ~/.configs
cd ~/.configs
sh ./new_repo.sh
```

```
#    << To upgrade all plugins/pkgs to latest releases >>

cd ~/.configs
vim +BundleInstall +qall
```
