# Useful snippets of code.
Contributor(s): Danny Pule


## Vanilla Javascript

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

## CSS

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

# TODO: FORMAT EVERYTHING BELOW THIS LINE

[data-id="appStore"]  // attribute selector for jquery
..

white-space: pre-wrap; (preserves line breaks in html)
..

$('html, body').animate({scrollTop: $("#foo").offset().top - 100}, 300);

..

       function getQueryParam(param) {
	    var found;
	    window.location.search.substr(1).split("&").forEach(function(item) {
	        if (param ==  item.split("=")[0]) {
	            found = item.split("=")[1];
	        }
	    });
	    return found;
	};

..

background: linear-gradient(45deg, #E4C654 0%, #E4C654 49%,#D6BC5B 50%);
..

// for launching bootstrap modals
data-toggle="modal" data-target="#fullDetailsModal"
..

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


..
How to copy JSON data from the console

// where res.data is the JSON object
copy(JSON.stringify(res.data))



































