# React snippets

## Table of contents

**[Functional Component](#Functional-Component)**<br>
**[Class Component](#Class-Component)**<br>
**[Testing components](#Testing-components)**<br>
**[Emotion styles](#Emotion-styles)**<br>
**[Storybook](#Storybook)**<br>
**[Actions](#Actions)**<br>
**[Sagas](#Sagas)**<br>
**[Testing sagas](#Testing-sagas)**<br>
**[API service](#API-service)**<br>
**[Test API service](#Test-API-service)**<br>
**[Reducer](#Reducer)**<br>
**[Test reducer](#Test-reducer)**<br>
**[connect()](#connect)**<br>
**[selectors](#selectors)**<br>
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

## Actions

```
import { createActionCreator } from 'deox';

import { GetThingsData } from 'src/api_services/apps/types';
import { Params } from 'src/api_services/types';

const PREFIX = '@WEBSITE_CREATION';
const GET_THINGS = `${PREFIX}/GET_THINGS`;
const GET_THINGS_SUCCESS = `${PREFIX}/GET_THINGS_SUCCESS`;
const GET_THINGS_ERROR = `${PREFIX}/GET_THINGS_ERROR`;

export const getThings = {
  next: createActionCreator(GET_THINGS, resolve => ({ orgId, params }: { orgId: string; params: Params }) =>
    resolve({ orgId, params })
  ),
  success: createActionCreator(GET_THINGS_SUCCESS, resolve => (data: GetThingsData) => resolve(data)),
  error: createActionCreator(GET_THINGS_ERROR, resolve => (error: Error) => resolve(error))
};
```

---
**[[Top](#React-Snippets)]**<br><br>

## Sagas

```ts
import { ActionType, getType } from 'deox';
import { call, put, takeLatest } from 'redux-saga/effects';

import * as apiService from 'src/api_services/things/service';

import { getThings } from './actions';

export function* getThingsRequestSaga({ payload }: ActionType<typeof getThings.next>) {
  try {
    const res = yield call(apiService.getThings, payload);
    yield put(getThings.success(res));
  } catch (error) {
    yield put(getThings.error(error));
  }
}

export function* thingsSaga() {
  yield takeLatest(getType(getThings.next), getThingsRequestSaga);
}
```

---
**[[Top](#React-Snippets)]**<br><br>

## Testing sagas

```ts
import axios from 'axios';
import { getType } from 'deox';
import { TestApi, testSaga } from 'redux-saga-test-plan';
import { takeLatest } from 'redux-saga/effects';

import * as apiService from 'src/api_services/things/service';
import { REDUCER_META_MOCK } from 'src/mocks/_common/reducer-meta.mock';

import { getThings } from './actions';
import { thingsSaga, getThingsRequestSaga } from './sagas';

jest.mock('axios');

describe('Given getThingsRequestSaga', () => {
  const PAYLOAD = {
    orgId: 'some-id',
    params: {}
  };
  const RESPONSE = {
    meta: REDUCER_META_MOCK,
    items: []
  };
  const ERORR_MSG = 'some error';
  const ERROR = new Error(ERORR_MSG);
  axios.get = jest.fn().mockResolvedValue(RESPONSE);

  let sagaTest: TestApi;

  beforeEach(() => {
    sagaTest = testSaga(getThingsRequestSaga, getThings.next(PAYLOAD));
  });

  it('dispatches "success" actions correctly', () => {
    sagaTest
      .next()
      .call(apiService.getThings, PAYLOAD)
      .next(RESPONSE)
      .put(getThings.success(RESPONSE))
      .next()
      .isDone();
  });

  it('dispatches "error" actions correctly', () => {
    sagaTest
      .next()
      .throw(ERROR)
      .put(getThings.error(ERROR))
      .next()
      .isDone();
  });
});

describe('Given thingsSaga', () => {
  const sagasTest = thingsSaga();

  it('should take getThings.REQUEST', () => {
    expect(sagasTest.next().value).toStrictEqual(takeLatest(getType(getThings.next), getThingsRequestSaga));
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
import { createReducer } from 'deox';

import * as actions from './actions';
import { State } from './types';

export const initialState: State = {
  meta: {
    total: 0,
    offset: 0,
    limit: 0,
    sortBy: '',
    sortOrder: '',
    search: ''
  },
  data: [],
  loading: true,
  error: ''
};

export const thingsReducer = createReducer(initialState, handleAction => [
  handleAction(actions.getThings.next, state => ({
    ...state,
    loading: true
  })),
  handleAction(actions.getThings.success, (state, { payload: { meta, items } }) => ({
    ...state,
    meta: {
      ...state.meta,
      ...meta
    },
    data: items,
    loading: false
  })),
  handleAction(actions.getThings.error, state => ({
    ...state,
    error: 'TBC',
    loading: false
  }))
]);
```

---
**[[Top](#React-Snippets)]**<br><br>

## Test reducer

```ts
import { REDUCER_META_MOCK } from 'src/mocks/_common/reducer-meta.mock';
import { thingsMock10 } from 'src/mocks/things/things.mock';

import * as actions from './actions';
import { thingsReducer, initialState } from './reducer';
import { State } from './types';

describe('Given thingsReducer', () => {
  let state: State;

  describe('when it is initiated', () => {
    beforeEach(() => {
      state = thingsReducer(undefined, { type: 'FAKE_ACTION', payload: new Error('some error'), error: true });
    });

    it('should return the default state', () => {
      expect(state).toStrictEqual(initialState);
    });
  });

  describe('and getThings.next action is received', () => {
    const mock = {
      orgId: 'id',
      params: {}
    };
    beforeEach(() => {
      state = thingsReducer(state, actions.getThings.next(mock));
    });

    it('should return the correct state', () => {
      expect(state).toStrictEqual({
        ...state,
        loading: true
      });
    });
  });

  describe('and getThings.success action is received', () => {
    const mockResponse = {
      items: thingsMock10,
      meta: REDUCER_META_MOCK
    };
    beforeEach(() => {
      state = thingsReducer(state, actions.getThings.success(mockResponse));
    });

    it('should return the correct state', () => {
      expect(state).toStrictEqual({
        ...state,
        data: mockResponse.items,
        meta: mockResponse.meta,
        loading: false
      });
    });
  });

  describe('and getThings.error action is received', () => {
    beforeEach(() => {
      state = thingsReducer(state, actions.getThings.error(new Error('some error')));
    });

    it('should return the correct state', () => {
      expect(state).toStrictEqual({
        ...state,
        error: 'TBC',
        loading: false
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
export const selectMeta = (state: AppState) => state.cats.meta;
export const selectLoading = (state: AppState) => state.cats.loading;
export const selectError = (state: AppState) => state.cats.error;
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
  
