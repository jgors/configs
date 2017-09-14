#!/usr/bin/env python

#----------------------------------------------------------------
# Author: Jason Gors <jasonDOTgorsATgmail>
# Creation Date: 10-11-2016
# Purpose: get better vim keybindings for ipython v5.x
#          This file goes in ~/.ipython/profile_default/startup/
# See:
# http://python-prompt-toolkit.readthedocs.io/en/latest/pages/building_prompts.html#adding-custom-key-bindings
# http://ipython.readthedocs.io/en/stable/config/details.html#keyboard-shortcuts
#----------------------------------------------------------------
from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, HasSelection, ViInsertMode, ViNavigationMode
from prompt_toolkit.key_binding.vi_state import InputMode
from prompt_toolkit.key_binding.bindings.named_commands import get_by_name
# from prompt_toolkit.key_binding.bindings.utils import create_handle_decorator


ip = get_ipython()
insert_mode = ViInsertMode()
nav_mode = ViNavigationMode()


def switch_to_navigation_mode(event):
    vi_state = event.cli.vi_state
    vi_state.reset(InputMode.NAVIGATION)

def go_to_start_of_line(event):
    buf = event.current_buffer
    buf.cursor_position += buf.document.get_start_of_line_position(after_whitespace=True)

def go_to_end_of_line(event):
    buf = event.current_buffer
    buf.cursor_position += buf.document.get_end_of_line_position()


# Register keybindings if IPython is using prompt_toolkit
if getattr(ip, 'pt_cli'):
    registry = ip.pt_cli.application.key_bindings_registry

    # Either this to go to normal mode by pressing 'jj' (like from ipython's docs)
    # http://ipython.readthedocs.io/en/stable/config/details.html#keyboard-shortcuts
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
    '''
    # Or this (used to work, but is broken now)
    handle_in_mode = create_handle_decorator(registry, ViInsertMode())
    handle_in_mode(u'j', u'j')(switch_to_navigation_mode)

    # get_by_name looks for a readline cmd (like ~/.inputrc); not all cmds supported
    handle_nav_mode = create_handle_decorator(registry, ViNavigationMode())
    handle_nav_mode(u'H')(get_by_name('beginning-of-line'))
    handle_nav_mode(u'L')(get_by_name('end-of-line'))
    '''

