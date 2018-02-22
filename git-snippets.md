Also using https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet

```
// push and bypass githooks
gp --no-verify origin feature/my-cool-branch-1997
```

```
// push and create new branch on origin
gp -u origin feature/my-cool-branch-1997
```

```
// force push
gp -f origin feature/my-cool-branch-1997
```

```
// squash commits
git rebase -i HEAD~4 (where 4 is the number of commits you want to edit)
in the editor, use s or squash to squash those commits into to the last picked commit
`esc`
`:wq` (use this to save)
in next editor window, you can edit the commit message or `:wq` to save and exit
in next window, `:wq` to save and exit
```

```
// instruct git to remember how you handled merge conflicts and fix them the same way again
git config --global rerere.enabled true

// https://hackernoon.com/fix-conflicts-only-once-with-git-rerere-7d116b2cec67
// https://git-scm.com/book/en/v2/Git-Tools-Rerere
```

```
// pull and rebase if you have the "x up y down" issue
gl --rebase
```


