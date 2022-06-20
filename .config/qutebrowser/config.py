#
# GG's (cute)browser configs ;)
#

# general
config.load_autoconfig(False)

# web surf
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
c.content.prefers_reduced_motion = True
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.images', True, 'chrome-devtools://*')
c.content.javascript.can_access_clipboard = True
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
c.content.notifications.enabled = True
c.downloads.remove_finished = 5
config.set('content.blocking.method', 'both')

# tabs
c.tabs.last_close = 'close'
c.tabs.show = 'multiple'
c.tabs.tabs_are_windows = True

# start pages
c.url.start_pages = 'file:///home/gg/proj/cool-web-homepage/home.html'
c.url.default_page = 'file:///home/gg/proj/cool-web-homepage/home.html'

# window
c.window.title_format = '{perc}{current_title}'
c.statusbar.show = 'in-mode'
c.scrolling.bar = 'never'
c.completion.scrollbar.width = 0
c.content.fullscreen.window = True
c.new_instance_open_target = 'window'
c.confirm_quit = ['downloads']

# default zoom
c.zoom.default = '125'

# darkmode
c.colors.webpage.preferred_color_scheme = 'dark'

# font
c.fonts.default_family = 'Fira Code Nerd Font'
c.fonts.default_size = '15pt'
c.fonts.web.family.fixed = 'Fira Code Nerd Font'

# 
# catppuccin color scheme
#

fg           = "#D9E0EE"
bg           = "#1E1E2E"
green        = "#ABE9B3"
yellow       = "#FAE3B0"
magenta      = "#F5C2E7"
cyan         = "#89DCEB"

c.colors.completion.odd.bg = bg 
c.colors.completion.even.bg = bg 

c.colors.completion.category.bg = magenta
c.colors.completion.category.fg = bg

c.colors.completion.item.selected.bg = magenta 
c.colors.completion.item.selected.fg = bg 
c.colors.completion.item.selected.border.top = magenta 
c.colors.completion.item.selected.border.bottom = magenta 

c.colors.completion.item.selected.match.fg = cyan 
c.colors.completion.match.fg = yellow 

c.colors.statusbar.normal.bg = cyan 
c.colors.statusbar.insert.bg = green 
c.colors.statusbar.insert.fg = bg 
c.colors.statusbar.command.bg = bg 

c.colors.tabs.bar.bg = bg 
c.colors.tabs.odd.bg = bg 
c.colors.tabs.even.bg = bg 
c.colors.tabs.selected.odd.bg = magenta 
c.colors.tabs.selected.even.bg = magenta 

#
# bindings
#
config.bind('b', 'set-cmd-text -s :quickmark-load ')
config.bind('e', 'hint links spawn mpv --ytdl {hint-url}')
