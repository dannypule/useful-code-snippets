# General

##### Chrome Dev Tools
Reminder: Chrome DevTools can list the event handlers registered on any element. 
Inspect element > expand the 'Event Listeners' panel (to the right of your DOM tree). 
BOOM. All there.
[via Twitter] https://plus.google.com/+AddyOsmani/posts/9WvgE2K2QTF

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

<br>
##### Heroku deployment

Install Heroku toolbelt from here: https://toolbelt.heroku.com/

On your computer, open the terminal in your app's root folder

WINDOWS USERS ENTER THIS LINE: `start cmd` 

This opens cmd.exe and is a workaround to a Windows issue with Heroku when you start the command line any other way. Don't ask me why this works but I had to do this on my Windows 10 machine. More info here: https://github.com/heroku/cli/issues/84. Anyway, onwards

`heroku login`

Input your Heroku login email and hit return.

Input your Heroku password and hit return.

`ssh-keygen -t rsa` (press enter all the way through the prompts) --- TODO - not sure if needed

`heroku keys:add` (type 'y' and hit return when prompted) --- TODO - not sure if needed

<br>
CREATE and PUSH to 'test'

`git remote add release-heroku-test https://git.heroku.com/YOUR-TEST-HEROKU-APP.git` (you've now added your 'test' remote)

`git push release-heroku-test master` (you've now deployed to 'test')

<br>
CREATE and PUSH to 'prod'

`git remote add release-heroku-prod https://git.heroku.com/YOUR-PRODUCTION-HEROKU-APP.git` (you've now added your 'prod' remote)

`git push release-heroku-prod master` (you've now deployed to 'prod')

`git remote -v` (this shows you a list of your remotes and confirm your previous actions)

<br>
---------------------------------
<br>

Once you're set up, deploying is easy:

`git checkout YOUR-TEST-BRANCH`

`git push release-heroku-test YOUR-TEST-BRANCH:master`

`git checkout YOUR-PROD-BRANCH`

`git push release-heroku-prod YOUR-PROD-BRANCH:master`

<br>
View deployed code here:

`https://YOUR-TEST-HEROKU-APP.herokuapp.com`

`https://YOUR-PRODUCTION-HEROKU-APP.herokuapp.com`

##### How to copy JSON data from the console
```
// where res.data is the JSON object
copy(JSON.stringify(res.data))
```

##### Start redis
`redis-server . &`

##### Check if redis is running
`redis-cli ping`
More redis info here: https://medium.com/@petehouston/install-and-config-redis-on-mac-os-x-via-homebrew-eb8df9a4f298

##### Get value of cookie in browser console
`document.cookie.split(';').filter(name => name.includes('featuresOverride'))[0].split("=")[1]`

##### sort dynamically imported Storybook categories

```
// config.jsx
import { sortCategoryPaths } from './storybook.utils';

// ...

const req = require.context('../src', true, /.stories.(js|jsx|ts|tsx)$/);


function loadStories() {
  addDecorator(withInfo);
  addDecorator(withA11y);
  addDecorator(withIntl);
  addDecorator(withThemesProvider(themes));
  addDecorator(withThemeAndGlobalStyles);
  addDecorator(withKnobs);
  addParameters({
    backgrounds: [{ name: 'grey', value: '#f2f2f2', default: true }, { name: 'white', value: '#ffffff' }]
  });
  sortCategoryPaths(req.keys()).forEach(req);
}

configure(loadStories, module);
```

```
// storybook.utils.ts

const getFileName = path => {
  const array = path.split('/');
  return array[array.length - 1];
};

export const sortCategoryPaths = arrayOfStories =>
  arrayOfStories.sort((pathA, pathB) => {
    const fileA = getFileName(pathA);
    const fileB = getFileName(pathB);

    if (fileA < fileB) {
      return -1;
    }

    if (fileA > fileB) {
      return 1;
    }

    return 0;
  });

```
