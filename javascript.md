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

##### Random number between max and min

```
var max = 40;
var min = 20;
var randonNumber = Math.ceil(Math.random() * (max - min) + min);
document.writeln(randonNumber);
```

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
