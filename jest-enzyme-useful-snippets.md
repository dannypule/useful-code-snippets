# Testing (Jest/Enzyme)

```
const input = wrapper.find('input').first(); input.simulate('change', {
  target: { value: item } 
})
```

```
const button = wrapper.find('button').first(); 
expect(button.props().disabled ).toBe(false);
```

```
expect(
  wrapper.state().item
).toEqual(item);
```

```
const form = wrapper.find('form').first(); form.simulate('submit', {
  preventDefault: () => {},
});
```

```
expect(
  wrapper.state().items
).toContain(item);
```

```
expect(
  wrapper.containsMatchingElement(<td>{item}</td>) 
).toBe(true);
```

```
expect(
  wrapper.contains(<td>{item}</td>) 
).toBe(true);
```

```
const input = wrapper.find('input').first(); expect(
  input.props().value
).toEqual('');
```

```
const myMock = jest.fn(); 
console.log(myMock.mock.calls.length); // -> 0
myMock('Paris'); 
console.log(myMock.mock.calls.length); // -> 1
myMock('Paris', 'Amsterdam'); 
console.log(myMock.mock.calls.length); // -> 2
```

```
const myMock = jest.fn(); console.log(myMock.mock.calls);
// -> []
myMock('Paris'); console.log(myMock.mock.calls);
// -> [ [ 'Paris' ] ]
myMock('Paris', 'Amsterdam'); console.log(myMock.mock.calls);
// -> [ [ 'Paris' ], [ 'Paris', 'Amsterdam' ] ]
```

```
// Jest has a mock generator for entire modules. When a function from that module is called inside the component we're testing // then it will call the Jest mock and we can do assertions on it.
import Client from '../Client'; 
jest.mock('../Client');
```

```
const firstInvocation = Client.search.mock.calls[0];
console.log('First invocation:');
console.log(firstInvocation);
console.log('All invocations: ');
console.log(Client.search.mock.calls);
```

```
// clear mocks
afterEach(() => {
  Client.search.mockClear();
});
```

```
it('should call `Client.search() with `value`', () => {
  const invocationArgs = Client.search.mock.calls[0];
  expect(
   invocationArgs[0]
  ).toEqual(value);
});
```
