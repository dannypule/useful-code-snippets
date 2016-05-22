<h1 align="center">Useful snippets of code</h1>
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

<br>
##### Displays calling function as string
```
console.log("caller is " + arguments.callee.caller);
```

<br>
##### Prints call stack
```
function print_call_stack() {
  var stack = new Error().stack;
  console.log("PRINTING CALL STACK");
  console.log( stack );
}
```

<br>
##### Remove spaces from a string
```
var str = " thi s str ing has sp aces".replace(/ /g,'');
console.log(str);
```

<br>
##### How to copy JSON data from the console
```
// where res.data is the JSON object
copy(JSON.stringify(res.data))
```

<br>
##### Random number between max and min

```
var max = 40;
var min = 20;
var randonNumber = Math.ceil(Math.random() * (max - min) + min);
document.writeln(randonNumber);
```

<br>
##### Function to validate url where https or http is optional but it will accept parameters etc
```
function validateUrl(value){
	var re_weburl = new RegExp(
	  "^" +
	    // protocol identifier
	    "(?:(?:https?|(?!https?))://|(?!://))" +
	    "(?:www\.)" +
	    // user:pass authentication
	    "(?:\\S+(?::\\S*)?@)?" +
	    "(?:" +
	      // IP address exclusion
	      // private & local networks
	      "(?!(?:10|127)(?:\\.\\d{1,3}){3})" +
	      "(?!(?:169\\.254|192\\.168)(?:\\.\\d{1,3}){2})" +
	      "(?!172\\.(?:1[6-9]|2\\d|3[0-1])(?:\\.\\d{1,3}){2})" +
	      // IP address dotted notation octets
	      // excludes loopback network 0.0.0.0
	      // excludes reserved space >= 224.0.0.0
	      // excludes network & broacast addresses
	      // (first & last IP address of each class)
	      "(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])" +
	      "(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}" +
	      "(?:\\.(?:[1-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))" +
	    "|" +
	      // host name
	      "(?:(?:[a-z\\u00a1-\\uffff0-9]-*)*[a-z\\u00a1-\\uffff0-9]+)" +
	      // domain name
	      "(?:\\.(?:[a-z\\u00a1-\\uffff0-9]-*)*[a-z\\u00a1-\\uffff0-9]+)*" +
	      // TLD identifier
	      "(?:\\.(?:[a-z\\u00a1-\\uffff]{2,}))" +
	      // TLD may end with dot
	      "\\.?" +
	    ")" +
	    // port number
	    "(?::\\d{2,5})?" +
	    // resource path
	    "(?:[/?#]\\S*)?" +
	  "$", "i"
	);

	return re_weburl.exec(value);
}
```

<br>
##### Close drop down menu when other element is clicked

```
$(document).mouseup(function (e) {
    var $container = $(".myAccount");
    var $accountMenu = $('.subMenu');

    if (!$container.is(e.target) // if the target of the click isn't the container...
        && $container.has(e.target).length === 0) // ... nor a descendant of the container
    {
        $accountMenu.hide();
        $container.removeClass('goesUp');
    }
});
```

<br>
##### console functions
```
console.log();
console.warn();
console.info();
console.debug();
console.error();
```

```
console.log('hello %s, my number is %d and this is my object %o', 'world', 42, {foo: 'bar'});
```

```
console.log('hello %cworld', '{font-size: 12px, color: tomato}'); // add css styles to console.log statements
```

```
console.group('hello world'); // or .groupCollapse()
console.log('foo');
console.log('bar');
console.groupEnd();
```

```
console.count();
```

```
console.time('myKey');
// calculations....
console.timeEnd('myKey');
```

```
console.table(...); // arr of objects output as nice table
console.table(arr, 'propName'); // arr of objects output as nice table restricted to property(ies)
```





