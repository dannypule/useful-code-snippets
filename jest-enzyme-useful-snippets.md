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

```
const field = 'email'
it('should call setFormField when prop setField is called', () => {
  const { wrapper, instance } = renderedComponent
  expect(instance.props.setFormField).not.toHaveBeenCalled()
  wrapper.find(`Connect(Input) [name="${field}"]`).prop('setField')(field)(event)
  expect(instance.props.setFormField).toHaveBeenCalledTimes(1)
  expect(instance.props.setFormField).toHaveBeenLastCalledWith('footerNewsletter', field, event.target.value)
})
```

```
describe('@events', () => {
  let renderedComponent
  const event = {
    target: {
      value: 123
    },
    preventDefault: jest.fn()
  }
  beforeEach(() => {
    renderedComponent = renderComponent(initialProps)
    jest.resetAllMocks()
  })
  describe('email Input', () => {
    const field = 'email'
    it('should call setFormField when prop setField is called', () => {
      const { wrapper, instance } = renderedComponent
      expect(instance.props.setFormField).not.toHaveBeenCalled()
      wrapper.find(`Connect(Input) [name="email"]`).prop('setField')(field)(event)
      expect(instance.props.setFormField).toHaveBeenCalledTimes(1)
      expect(instance.props.setFormField).toHaveBeenLastCalledWith('footerNewsletter', field, event.target.value)
    })
    it('should call touchedFormField when prop touchedField is called', () => {
      const { wrapper, instance } = renderedComponent
      expect(instance.props.touchedFormField).not.toHaveBeenCalled()
      wrapper.find(`Connect(Input) [name="email"]`).prop('touchedField')(field)(event)
      expect(instance.props.touchedFormField).toHaveBeenCalledTimes(1)
      expect(instance.props.touchedFormField).toHaveBeenLastCalledWith('footerNewsletter', field)
    })
  })
  describe('form submit', () => {
    it('should call e.preventDefault() ', () => {
      const { wrapper } = renderedComponent
      expect(event.preventDefault).not.toHaveBeenCalled()
      wrapper.find('form').simulate('submit', event)
      expect(event.preventDefault).toHaveBeenCalledTimes(1)
    })
    it('should call redirectUser if no errors', () => {
      const { instance, wrapper } = renderedComponent
      instance.getErrors = jest.fn(() => ({}))
      instance.redirectUser = jest.fn()
      expect(instance.redirectUser).not.toHaveBeenCalled()
      wrapper.find('form').simulate('submit', event)
      expect(instance.redirectUser).toHaveBeenCalledTimes(1)
    })
    it('should not call redirectUser if errors', () => {
      const { instance, wrapper } = renderedComponent
      instance.redirectUser = jest.fn()
      instance.getErrors = jest.fn(() => ({
        email: 'has errors'
      }))
      wrapper.find('form').simulate('submit', event)
      expect(instance.redirectUser).not.toHaveBeenCalled()
    })
  })
})
```

```
import React from 'react'
import { shallow, mount } from 'enzyme'
import toJson from 'enzyme-to-json'
const wrapper = shallow( // wrapper
  <Component {...props}>{children}</Component>,
  { ...mountCommonContext, ...mountOptions }
)

const instance = wrapper.instance() // instance - used like expect(instance.props).toEqual(props) etc etc
const getTree = () => toJson(wrapper) // getTree() used like expect(renderComponent(props).getTree()).toMatchSnapshot()

component.wrapper.find(selector).simulate(eventName, event)
```

```
// click on the component
const props = { someProp: jest.fn() } 
const { wrapper } = renderComponent(props)
wrapper.node.props.onClick()
// .... stuff happens and prop gets called - maybe with an instance method or something
expect(props.someProp).toHaveBeenCalledTimes(1)
```
