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
