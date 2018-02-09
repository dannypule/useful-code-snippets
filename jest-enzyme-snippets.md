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
