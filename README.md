<h1 align="center">Useful snippets of code</h1>
<p align="center">Contributor(s): Danny Pule</p>

<br />
<h3 align="center">Vanilla Javascript</h3>

##### Get value of parameter from url
```
function getQueryParam(param) {
    var found;
    window.location.search.substr(1).split("&").forEach(function(item) {
        if (param ==  item.split("=")[0]) {
            found = item.split("=")[1];
        }
    });
    return found;
};
```

##### Random number between max and min

```
var max = 40;
var min = 20;
var randonNumber = Math.ceil(Math.random() * (max - min) + min);
document.writeln(randonNumber);
```

##### Displays calling function as string
```
console.log("caller is " + arguments.callee.caller);
```

##### Prints call stack
```
function print_call_stack() {
  var stack = new Error().stack;
  console.log("PRINTING CALL STACK");
  console.log( stack );
}
```

##### Remove spaces from a string
```
var str = " thi s str ing has sp aces".replace(/ /g,'');
console.log(str);
```

##### How to copy JSON data from the console
```
// where res.data is the JSON object
copy(JSON.stringify(res.data))
```

<h3 align="center">jQuery</h3>

##### Attribute selector for jquery
```
[data-id="appStore"]  // attribute selector for jquery
```

##### Scroll to position
```
$('html, body').animate({scrollTop: $("#foo").offset().top - 100}, 300);
```

##### Launching bootstrap modals
```
data-toggle="modal" data-target="#fullDetailsModal"
```

<h3 align="center">CSS</h3>

##### Element highlighting turned off
```
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
```

##### Cursor is grabbing hand
```
cursor: -webkit-grabbing; 
cursor: -moz-grabbing;
```

##### Preserve line breaks in html
```
white-space: pre-wrap; (preserves line breaks in html)
```

##### Background gradients
```
background: linear-gradient(45deg, #E4C654 0%, #E4C654 49%,#D6BC5B 50%);
```

##### Load images based on screen width - optimize images for mobile or desktop
```
<style>
    /* for mobile screens widths up to 479px --- based on Bootstraps breakpoints */ 
    .hero-image { 
        background: url("https://d1f9hf6w7e7i7b.cloudfront.net/www/views/img/plan-pages/first-5k-run-sm.jpg"); 
    }
    @media (min-width : 480px) { /* for screens widths between up to 480px and 1119px */
        .hero-image { background: url("https://d1f9hf6w7e7i7b.cloudfront.net/www/views/img/plan-pages/first-5k-run-md.jpg"); }
    }
    @media (min-width : 992px) { /* for screens widths 992px or more */
        .hero-image { background: url("https://d1f9hf6w7e7i7b.cloudfront.net/www/views/img/plan-pages/first-5k-run-lg.jpg"); }
    }
</style>
```




































