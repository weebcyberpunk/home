# Qtile configs

Now things get interesting.  

So, looking on the main config file you can found my keyboard shortcuts and my layouts so I'll not take time explaining they here. About widgets, I use the Wlan widget that requires some dependencies as explained in Qtile docs [here](https://docs.qtile.org/en/latest/manual/ref/widgets.html#wlan). The Cmus widget may be uselles if you do not use cmus as your music player. Some keyboard shortcuts will need to be changed if you do not use their programs too (like firefox or telegram ones). Finally, the CheckUpdates widget as it is on my config needs the `pacman-contrib` package. If you do not run Arch Linux or an Arch based system, you will need to change this widget configs.  

I use an logout script called clearine. You can check it on AUR [here](https://aur.archlinux.org/packages/clearine-git/) and on github [here](https://github.com/okitavera/clearine). If you do not use it, you may want to change the last image widget (which has a mouse callback to clearine) and it's keyboard shortcut.

Remember to check audio shortcuts and widgets too. I use pretty common stuff to audio (PulseAudio and Pamixer) but you may be using another programs.   
