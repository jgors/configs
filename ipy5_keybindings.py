#!/usr/bin/env python

#----------------------------------------------------------------
# Author: Jason Gors <jasonDOTgorsATgmail>
# Creation Date: 10-11-2016
# Purpose: get better vim keybindings for ipython v5.x
#          This file goes in ~/.ipython/profile_default/startup/
#----------------------------------------------------------------


from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, ViInsertMode, ViNavigationMode
from prompt_toolkit.key_binding.vi_state import InputMode
from prompt_toolkit.key_binding.bindings.utils import create_handle_decorator
from prompt_toolkit.key_binding.bindings.named_commands import get_by_name



def switch_to_navigation_mode(event):
    vi_state = event.cli.vi_state
    vi_state.reset(InputMode.NAVIGATION)


ip = get_ipython()

# Register keybindings if IPython is using prompt_toolkit
if getattr(ip, 'pt_cli'):
    registry = ip.pt_cli.application.key_bindings_registry

    # Either this to go to normal mode by pressing 'jj' (like from ipython's docs)
    # http://ipython.readthedocs.io/en/stable/config/details.html#keyboard-shortcuts
    # registry.add_binding(u'j', u'j',
                         # filter=(HasFocus(DEFAULT_BUFFER) & ViInsertMode()))(switch_to_navigation_mode)
    # Or this
    handle_in_mode = create_handle_decorator(registry, ViInsertMode())
    handle_in_mode(u'j', u'j')(switch_to_navigation_mode)

    # get_by_name looks for a readline cmd (like ~/.inputrc); not all cmds supported
    handle_nav_mode = create_handle_decorator(registry, ViNavigationMode())
    handle_nav_mode(u'H')(get_by_name('beginning-of-line'))
    handle_nav_mode(u'L')(get_by_name('end-of-line'))
