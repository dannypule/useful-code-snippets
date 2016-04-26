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










































