# General

##### Chrome Dev Tools
Reminder: Chrome DevTools can list the event handlers registered on any element. 
Inspect element > expand the 'Event Listeners' panel (to the right of your DOM tree). 
BOOM. All there.
[via Twitter] https://plus.google.com/+AddyOsmani/posts/9WvgE2K2QTF

<br>

##### `git co` as a shortcut for `git checkout`
`git config --global alias.co checkout`

<br>

##### Change remote git repo

`git remote set-url origin https://github.com/USERNAME/OTHERREPOSITORY.git`

`git remote -v`

More info: https://help.github.com/articles/changing-a-remote-s-url/

<br>

##### remove git repo
`rm -rf .git`

<br>
##### Getting unstuck from vim while merging git branches

1) press "i"

2) write your merge message

3) press "esc"

4) write ":wq"

5) then press "enter"

<br>

##### Mouse settings on Linux
`xinput set-prop 8 272 2`

<br>
##### CSS Clearfix

http://www.webtoolkit.info/css-clearfix.html#.VyofoFYrL0o

<br>
##### Make any page's content editable

Paste into console:

`javascript:document.body.contentEditable='true'; document.designMode='on'; void 0`
