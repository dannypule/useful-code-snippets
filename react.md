# React snippets

## Table of contents

**[Functional Component](#Functional-Component)**<br>
**[Class Component](#Class-Component)**<br>
**[Testing components](#Testing-components)**<br>
**[Emotion styles](#Emotion-styles)**<br>
**[Storybook](#Storybook)**<br>
**[Sagas](#Sagas)**<br>
**[Testing sagas](#Testing-sagas)**<br>
**[API service](#API-service)**<br>
**[Test API service](#Test-API-service)**<br>
**[Reducer](#Reducer)**<br>
**[Test reducer](#Class-Component)**<br>
**[connect()](#connect)**<br>
**[selectors](#selectors)**<br>
**[actions](#actions)**<br>
**[createReducer](#createReducer)**<br>
**[AppState type](#AppState-type)**<br>

---

## Functional Component

```tsx
/** @jsx jsx */
import * as React from 'react';
import { jsx } from '@emotion/core';

import style from './Greet.style';

interface RequiredProps {
  age: number;
}

interface DefaultProps {
  who: string;
}

export type Props = RequiredProps & DefaultProps;

const defaultProps: DefaultProps = {
  who: 'Johny Five'
};

const Greet = (props: Props) => {
  const { who, age } = props;

  return (
    <div css={style.container(props)}>
      {who} ... {age}
    </div>
  );
};

Greet.defaultProps = defaultProps;

export default Greet;
```

---
**[[Top](#React-Snippets)]**<br><br>

## Class Component

```tsx
/** @jsx jsx */
import * as React from 'react';
import { jsx } from '@emotion/core';

import style from './Greet.style';

interface RequiredProps {
  age: number;
}

interface DefaultProps {
  who: string;
}

export type Props = RequiredProps & DefaultProps;

class Greet extends React.Component<Props> {
  static defaultProps: DefaultProps = {
    who: 'Johny Five'
  };

  render() {
    const { age, who } = this.props;

    return (
      <div css={style.container(this.props)}>
        {who} ... {age}
      </div>
    );
  }
}

export default Greet;
```

---
**[[Top](#React-Snippets)]**<br><br>

## Testing components


```tsx
// Greet.test.tsx

import * as React from 'react';
import { shallow, ShallowWrapper } from 'enzyme';

import Greet from './Greet';

const initialProps = {
  age: 42
};

const additionalProps = {
  ...initialProps,
  who: 'johhny woo'
};

const SUPER_GREETER = '[data-qa="super-greeter"]';

describe('Given a Greet component', () => {
  let wrapper: ShallowWrapper;

  describe('when it is rendered', () => {
    beforeEach(() => {
      wrapper = shallow(<Greet {...initialProps} />);
    });

    it('should match the snapshot', () => {
      expect(wrapper.getElement()).toMatchSnapshot();
    });
  });
});

```

---
**[[Top](#React-Snippets)]**<br><br>

## Emotion styles

```ts
// Greet.style.ts

import { css } from '@emotion/core';

import { Theme } from 'src/design-system/theme';

import { Props } from './Greet';

const container = (props: Props) => (theme: Theme) => css`
  background-color: coral;
  margin-bottom: ${theme.margins[props.marginBottom]}px;
`;

export default { container };


```

---
**[[Top](#React-Snippets)]**<br><br>

## Storybook

```tsx
// Greet.stories.tsx

import * as React from 'react';
import { storiesOf } from '@storybook/react';

import Greet from './Greet';

storiesOf('Greet', module)
  .addDecorator(story => <div className="center-col width-600">{story()}</div>)
  .add('default', () => {
    return <Greet age={101} />;
  });
```

---
**[[Top](#React-Snippets)]**<br><br>

## Sagas

```ts
import { Action } from 'redux-actions';
import { call, put, takeLatest } from 'redux-saga/effects';

import * as someService from '../../../../../api_services/some/service';
import { getSomething } from './actions';

export function* getSomethingRequestSaga({ payload }: Action<string>) {
  try {
    const res = yield call(someService.getSomething, payload);

    yield put(getSomething.success(res.data));
  } catch (error) {
    yield put(getSomething.failure(error));
  } finally {
    yield put(getSomething.fulfill());
  }
}

export default function* sagas() {
  yield takeLatest(getSomething.REQUEST, getSomethingRequestSaga);
}

```

---
**[[Top](#React-Snippets)]**<br><br>

## Testing sagas

```ts
import axios from 'axios';
import { TestApi, testSaga } from 'redux-saga-test-plan';
import { takeLatest } from 'redux-saga/effects';

import * as someService from '../../../../../api_services/some/service';
import { getSomething } from './actions';
import sagas, { getSomethingRequestSaga } from './sagas';

describe('Given getSomethingRequestSaga', () => {
  const ID = 'some-id';

  const RESPONSE = {
    data: 33
  };
  const ERROR = new Error('some error');

  axios.get = jest.fn().mockResolvedValue(RESPONSE);

  let saga: TestApi;

  beforeEach(() => {
    saga = testSaga(getSomethingRequestSaga, getSomething.request(ID));
  });

  it('dispatches "success" then "fulfill" actions correctly', () => {
    saga
      .next()
      .call(someService.getStuff, ID)

      .next(RESPONSE)
      .put(getSomething.success(RESPONSE.data))
      .next()
      .put(getSomething.fulfill())
      .next()
      .isDone();
  });

  it('dispatches "failure" then "fulfill" actions correctly', () => {
    saga
      .next()
      .throw(ERROR)
      .put(getSomething.failure(ERROR))
      .next()
      .put(getSomething.fulfill())
      .next()
      .isDone();
  });
});

describe('Given sagas', () => {
  const sagasTest = sagas();

  it('should take getSomething.REQUEST', () => {
    expect(sagasTest.next().value).toStrictEqual(takeLatest(getSomething.REQUEST, getSomethingRequestSaga));
  });
});

```

---
**[[Top](#React-Snippets)]**<br><br>

## API service

```ts
import axios from 'axios';

export const getStuff = (id: string) => {
  const url = `/api/things/${id}/stuff`;

  return axios.get(url);
};

```

---

## Test API service

```js
import axios from 'axios';

import * as service from './service';

const AXIOS_GET_MOCK = jest.fn();
axios.get = AXIOS_GET_MOCK;
const ID = 'some-id';

describe('Given a stuff api service', () => {
  beforeEach(() => {
    jest.resetAllMocks();
  });

  describe('getStuff', () => {
    const url = `/api/things/${ID}/stuff`;

    beforeEach(() => {
      service.getStuff(ID);
    });

    it('should call axios.get with the correct url', () => {
      expect(AXIOS_GET_MOCK).toHaveBeenCalledWith(url);
    });
  });
});

```

---
**[[Top](#React-Snippets)]**<br><br>

## Reducer

```ts
import { createReducer } from './createReducer';
import { Stuff } from 'utils/types';

import { getStuff } from './actions';

export interface State {
  stuff: {
    data: Stuff[];
    loading: boolean;
    error: string;
  };
}

const initialState: State = {
  stuff: {
    data: [],
    loading: false,
    error: ''
  }
};

const getStuffRequest = (state: State): State => ({
  ...state,
  stuff: {
    ...state.stuff,
    loading: true
  }
});

const getStuffSuccess = (state: State, { payload }: { payload: Stuff[] }): State => ({
  ...state,
  stuff: {
    ...state.stuff,
    data: payload
  }
});

const getStuffFailure = (state: State): State => ({
  stuff: {
    ...state.stuff,
    error: 'TBC'
  }
});

const getStuffFullfill = (state: State): State => ({
  ...state,
  stuff: {
    ...state.stuff,
    loading: false
  }
});

const someReducer = createReducer(
  initialState,
  {
    [getStuff.REQUEST]: getStuffRequest,
    [getStuff.SUCCESS]: getStuffSuccess,
    [getStuff.FAILURE]: getStuffFailure,
    [getStuff.FULFILL]: getStuffFullfill
  }
);

export default someReducer;

```

---
**[[Top](#React-Snippets)]**<br><br>

## Test reducer

```ts
import * as actions from './actions';
import reducer, { State } from './reducer';

const defaultState = {
  stuff: {
    data: [],
    loading: false,
    error: ''
  }
};

describe('Given a reducer', () => {
  describe('when it is initiated', () => {
    let state: State;

    beforeEach(() => {
      state = reducer(undefined, { type: 'FAKE_ACTION', payload: [] });
    });

    it('should return the default state', () => {
      expect(state).toStrictEqual(defaultState);
    });

    describe('and getStuff.REQUEST action is received', () => {
      beforeEach(() => {
        state = reducer(state, actions.getStuff.request());
      });

      it('should return the correct state', () => {
        expect(state).toStrictEqual({
          ...state,
          stuff: {
            ...state.stuff,
            loading: true
          }
        });
      });
    });

    describe('and getStuff.SUCCESS action is received', () => {
      const mockSubs = ['some', 'subs'];
      beforeEach(() => {
        state = reducer(state, actions.getStuff.success(mockSubs));
      });

      it('should return the correct state', () => {
        expect(state).toStrictEqual({
          ...state,
          stuff: {
            ...state.stuff,
            data: mockSubs
          }
        });
      });
    });

    describe('and getStuff.FAILURE action is received', () => {
      beforeEach(() => {
        state = reducer(state, actions.getStuff.failure());
      });

      it('should return the correct state', () => {
        expect(state).toStrictEqual({
          ...state,
          stuff: {
            ...state.stuff,
            error: 'TBC'
          }
        });
      });
    });

    describe('and getStuff.FULLFILL action is received', () => {
      beforeEach(() => {
        state = reducer(state, actions.getStuff.fulfill());
      });

      it('should return the correct state', () => {
        expect(state).toStrictEqual({
          ...state,
          stuff: {
            ...state.stuff,
            loading: false
          }
        });
      });
    });
  });
});
```

---
**[[Top](#React-Snippets)]**<br><br>

## connect()

```ts
import * as selectors from './redux/selectors'
import * as actions from './redux/actions'

export const stateToProps = (state: AppState) => ({
  cats: selectors.selectCats(state)
});

export const dispatchToProps = {
  getCatsRequest: actions.getCats.request,
  addCatRequest: actions.addCat.request
};

export { Greet as UnwrappedGreet };

export default connect(
  stateToProps,
  dispatchToProps
)(Greet);
```

---
**[[Top](#React-Snippets)]**<br><br>

## selectors

```
import { AppState } from 'src/store';

export const selectCats = (state: AppState) => state.cats.data;
```



---
**[[Top](#React-Snippets)]**<br><br>

## actions

```
import { createRoutine } from 'redux-saga-routines';

const PREFIX = '@CATS_PAGE';

export const getCats = createRoutine(`${PREFIX}/GET_CATS`);

```






---
**[[Top](#React-Snippets)]**<br><br>

## createReducer

```ts
export type GenericAction = { type: string; payload: any };

export const createReducer = <State>(
  initialState: State,
  handlers: Record<string, (state: State, action: GenericAction) => State>
) => {
  return function reducer(state = initialState, action: GenericAction) {
    return (handlers[action.type] && handlers[action.type](state, action)) || state;
  };
};
```

---
**[[Top](#React-Snippets)]**<br><br>

## AppState type

import configureStore from './configureStore';
import rootReducer from './rootReducer';

export type AppState = ReturnType<typeof rootReducer>;
export { configureStore };
  
---
  
