#!/usr/bin/env python

#----------------------------------------------------------------
# Author: Jason Gors <jasonDOTgorsATgmail>
# Creation Date: 10-12-2016
# Purpose:  sets ipython to use vim keybindings by default
#----------------------------------------------------------------

import os
from os.path import join as pjoin


user_path = os.path.expanduser('~')
ipy_profile_dir = pjoin(user_path, '.ipython', 'profile_default')

ipy_config = pjoin(ipy_profile_dir, 'ipython_config.py')
ipy_config_old = pjoin(ipy_profile_dir, 'ipython_config_old.py')
os.rename(ipy_config, ipy_config_old)
new_config = open(ipy_config, 'w')
vim_mode = "c.TerminalInteractiveShell.editing_mode = 'vi'"
vim_mode += "   # need for vi keybindings in ipython v5.x\n"

with open(ipy_config_old, 'r') as old_config:
    ln_found = False
    for ln in old_config:
        if 'c.TerminalInteractiveShell.editing_mode' in ln:
            ln = vim_mode
            ln_found = True
        new_config.write(ln)
    if not ln_found:    # not sure this is needed
        new_config.write(vim_mode)
os.remove(ipy_config_old)
