#[Dreymar's Big Bag of tricks](https://forum.colemak.com/topic/1438-dreymars-big-bag-of-keyboard-tricks-linuxxkb-files-included/)

One time run
```
$ setxkbmap -layout us -variant altgr-intl -option 'lv5:caps_switch_lock,misc:extend'
```
Persistent configuration /etc/default/keyboard
```conf
XKBLAYOUT=us
XKBVARIANT=altgr-intl
BACKSPACE=guess
XKBOPTIONS=lv5:caps_switch_lock,misc:extend
```