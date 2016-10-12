#!/usr/bin/env python

#----------------------------------------------------------------
# Author: Jason Gors <jasonDOTgorsATgmail>
# Creation Date: 10-12-2016
# Purpose:
#----------------------------------------------------------------

import os
from os.path import join as pjoin


user_path = os.path.expanduser('~')
profile_dir = '.ipython/profile_default'

ipy_config = pjoin(user_path, profile_dir, 'ipython_config.py')
ipy_config_old = pjoin(user_path, profile_dir, 'ipython_config_old.py')
os.rename(ipy_config, ipy_config_old)
old_config = open(ipy_config_old, 'r')
new_config = open(ipy_config, 'w')

vim_mode = "c.TerminalInteractiveShell.editing_mode = 'vi'"
vim_mode += "   # need for vi keybindings in ipython v5.x"

ln_found = False
for ln in old_config:
    if 'c.TerminalInteractiveShell.editing_mode' in ln:
        ln = vim_mode
        ln_found = True
    new_config.write(ln)
if not ln_found:
    new_config.write(vim_mode)
