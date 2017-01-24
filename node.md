<h1 align="center">Useful snippets of code</h1>
<br />
<h3 align="center">Node.js</h3>

##### Ensure index.html is not cached by the browser

app.use(function (req, res, next) {
    res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
    res.header('Expires', '-1');
    res.header('Pragma', 'no-cache');
    next()
});
