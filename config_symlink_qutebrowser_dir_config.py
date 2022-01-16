# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')

config.set('content.cookies.accept', 'all', 'devtools://*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version} Edg/{upstream_browser_version}', 'https://accounts.google.com/*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')

# Load images automatically in web pages.
config.set('content.images', True, 'chrome-devtools://*')

# Load images automatically in web pages.
config.set('content.images', True, 'devtools://*')

config.set('content.javascript.enabled', True, 'chrome-devtools://*')

config.set('content.javascript.enabled', True, 'devtools://*')

config.set('content.javascript.enabled', True, 'chrome://*/*')

config.set('content.javascript.enabled', True, 'qute://*/*')

# Leave insert mode if a non-editable element is clicked.
c.input.insert_mode.auto_leave = True

# Leave insert mode when starting a new page load. Patterns may be
# unreliable on this setting, and they may match the url you are
# navigating to, or the URL you are navigating from.
c.input.insert_mode.leave_on_load = True

# When to show the statusbar.
# Type: String
# Valid values:
#   - always: Always show the statusbar.
#   - never: Always hide the statusbar.
#   - in-mode: Show the statusbar when in modes other than normal mode.
c.statusbar.show = 'never'

# When to show the tab bar.
# Type: String
# Valid values:
#   - always: Always show the tab bar.
#   - never: Always hide the tab bar.
#   - multiple: Hide the tab bar if only one tab is open.
#   - switching: Show the tab bar when switching tabs.
c.tabs.show = 'multiple'

c.zoom.default = '200%'

c.fonts.default_size = '20pt'

c.content.user_stylesheets = '~/git/dotfiles/qutebrowser_user_stylesheets.css'

# key binding in insert mode
config.bind('<Ctrl-l>', 'fake-key <Right>', mode='insert')
config.bind('<Ctrl-h>', 'fake-key <Left>', mode='insert')
config.bind('<Ctrl-w>', 'fake-key <Ctrl-Right>', mode='insert')
config.bind('<Ctrl-b>', 'fake-key <Ctrl-Left>', mode='insert')
config.bind('<Ctrl-j>', 'fake-key <Down>', mode='insert')
config.bind('<Ctrl-k>', 'fake-key <Up>', mode='insert')
config.bind('<Ctrl-0>', 'fake-key <Home>', mode='insert')
config.bind('<Ctrl-e>', 'fake-key <End>', mode='insert')

# Map ; to : key in normal mode
config.bind(';', 'set-cmd-text :', mode='normal')

config.bind('<Ctrl-g>', 'stop', mode='normal')
config.bind('<Space><Space>', 'set-cmd-text :', mode='normal')
config.bind('<Ctrl-B>', 'scroll-page 0 -0.5', mode='normal')
config.bind('<Ctrl-D>', 'scroll-page 0 0.5', mode='normal')
config.bind('<Space>y', 'history --tab', mode='normal')
config.bind('<Space>rr', 'restart', mode='normal')
config.bind('<Space>rw', 'quickmark-save', mode='normal')
config.bind('<Space>rl', 'set-cmd-text -s :quickmark-load', mode='normal')
config.bind('m', 'mode-enter set_mark', mode='normal')
config.bind('`', 'mode-enter jump_mark', mode='normal')
config.bind('<Space>mm', 'bookmark-add', mode='normal')
config.bind('<Space>ml', 'bookmark-list', mode='normal')
config.bind('<Space>mo', 'set-cmd-text -s :bookmark-load', mode='normal')
config.bind('<Space>mO', 'set-cmd-text -s :bookmark-load -t', mode='normal')
config.bind('<Space>md', 'set-cmd-text -s :bookmark-del', mode='normal')

config.bind('<Ctrl-g>', 'mode-leave', mode='command')
config.bind('<Ctrl-j>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl-k>', 'completion-item-focus prev', mode='command')

config.bind('<Ctrl-g>', 'mode-leave', mode='caret')
config.bind('<Ctrl-B>', 'run-with-count 10 move-to-prev-line', mode='caret')
config.bind('<Ctrl-D>', 'run-with-count 10 move-to-next-line', mode='caret')
