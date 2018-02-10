# Jest and Enzyme snippets

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


