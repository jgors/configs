#!/usr/bin/env python

#----------------------------------------------------------------
# Author: Jason Gors <jasonDOTgorsATgmail>
# Creation Date: 10-11-2016
# Purpose: get better vim keybindings for ipython v5.x
#          This file goes in ~/.ipython/profile_default/startup/
# See:
# https://stackoverflow.com/questions/38443907/how-does-one-set-specific-vim-bindings-in-ipython-5-0-0
# https://python-prompt-toolkit.readthedocs.io
# https://ipython.readthedocs.io/en/stable/config/details.html#keyboard-shortcuts
# https://ipython.readthedocs.io/en/latest/config/details.html#keyboard-shortcuts
# https://stackoverflow.com/questions/10394302/how-do-i-use-vi-keys-in-ipython-under-nix/38329940#38329940
#----------------------------------------------------------------

import sys

from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, HasSelection, ViInsertMode, ViNavigationMode
from prompt_toolkit.key_binding.vi_state import InputMode
from prompt_toolkit.key_binding.bindings.named_commands import get_by_name
# from prompt_toolkit.key_binding.bindings.utils import create_handle_decorator


from prompt_toolkit import prompt
from prompt_toolkit.styles import Style


def switch_to_navigation_mode(event):
    vi_state = event.cli.vi_state
    # vi_state.reset(InputMode.NAVIGATION)    # only works in Ipython2
    vi_state.input_mode = InputMode.NAVIGATION    # works in Ipython2 & 3

def go_to_start_of_line(event):
    buf = event.current_buffer
    buf.cursor_position += buf.document.get_start_of_line_position(after_whitespace=True)

def go_to_end_of_line(event):
    buf = event.current_buffer
    buf.cursor_position += buf.document.get_end_of_line_position()


ip = get_ipython()
ip.editing_mode = 'vi'  # make sure vi is set
insert_mode = ViInsertMode()
nav_mode = ViNavigationMode()

# better history navigation
prev_history = get_by_name('previous-history')
next_history = get_by_name('next-history')

python_version = sys.version_info.major
if python_version == 2:
    if getattr(ip, 'pt_cli', None):   # for python2.x
        registry = ip.pt_cli.application.key_bindings_registry
elif python_version == 3:
    if getattr(ip, 'pt_app', None):     # for python3.x
        registry = ip.pt_app.key_bindings

try:
    registry.add_binding(u'j', u'j',
                         filter=(HasFocus(DEFAULT_BUFFER)
                                 & insert_mode))(switch_to_navigation_mode)
    registry.add_binding(u'H',
                         filter=(HasFocus(DEFAULT_BUFFER)
                                 # & ~HasSelection()
                                 ### this one goes to the very beg of the line
                                 # & nav_mode))(get_by_name('beginning-of-line'))
                                 ### this one just goes to the beg of where text starts on the line
                                 & nav_mode))(go_to_start_of_line)

    registry.add_binding(u'L',
                         filter=(HasFocus(DEFAULT_BUFFER)
                                 # & ~HasSelection()
                                 ### these two are the same
                                 # & nav_mode))(get_by_name('end-of-line'))
                                 & nav_mode))(go_to_end_of_line)

    registry.add_binding(u'K',
                         filter=(HasFocus(DEFAULT_BUFFER) &
                                 ViNavigationMode()))(prev_history)
    registry.add_binding(u'J',
                         filter=(HasFocus(DEFAULT_BUFFER) &
                                 ViNavigationMode()))(next_history)

    '''
    # Or this (used to work, but is broken now)
    handle_in_mode = create_handle_decorator(registry, ViInsertMode())
    handle_in_mode(u'j', u'j')(switch_to_navigation_mode)

    # get_by_name looks for a readline cmd (like ~/.inputrc); not all cmds supported
    handle_nav_mode = create_handle_decorator(registry, ViNavigationMode())
    handle_nav_mode(u'H')(get_by_name('beginning-of-line'))
    handle_nav_mode(u'L')(get_by_name('end-of-line'))
    '''
except Exception as e:
    print('EXCEPTION: could not add vi keybindings to registry:\n{}'.format(e))

