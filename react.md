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
// Greet.tsx

/** @jsx jsx */
import * as React from 'react';
import { jsx } from '@emotion/core';

import { Margins } from 'src/design-system/style-types';

import { style } from './Greet.style';

interface RequiredProps {}

interface DefaultProps {
  marginBottom: Margins;
}

export type Props = RequiredProps & DefaultProps;

const defaultProps: DefaultProps = {
  marginBottom: '0'
};

const Greet = (props: Props) => {
  const { marginBottom } = props;

  return <div css={style.container(props)}>yo</div>;
};

Greet.defaultProps = defaultProps;

export default Greet;

```

---
**[[Top](#React-Snippets)]**<br><br>

## Class Component

```tsx
// Greet.tsx

/** @jsx jsx */
import * as React from 'react';
import { jsx } from '@emotion/core';

import { Margins } from 'src/design-system/style-types';

import { style } from './Greet.style';

interface RequiredProps {}

interface DefaultProps {
  marginBottom: Margins;
}

export type Props = RequiredProps & DefaultProps;


interface State {
  showResults: boolean;
}

class Greet extends React.Component<Props> {
  state = {
    showResults: false
  };
  
  static defaultProps: DefaultProps = {
    marginBottom: '0'
  };

  render() {
    const { marginBottom } = this.props;

    return <div css={style.container(this.props)}>yo</div>;
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

import Greet, { Props } from './Greet';

const props: Partial<Props> = {
  marginBottom: '0'
};

const CONTINUE_BUTTON = '[data-qa="continue-button"]';

describe('Given a Greet component', () => {
  let wrapper: ShallowWrapper;

  describe('When it is rendered', () => {
    beforeEach(() => {
      wrapper = shallow(<Greet {...props} />);
    });

    it('Then should match the snapshot', () => {
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

export const style = { container };

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
    return <Greet />;
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
  request: createActionCreator(GET_THINGS, resolve => ({ orgId, params }: { orgId: string; params: Params }) =>
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

export function* getThingsRequestSaga({ payload }: ActionType<typeof getThings.request>) {
  try {
    const res: apiService.GetAppCategoriesResponse = yield call(apiService.getThings, payload);
    yield put(getThings.success(res));
  } catch (error) {
    yield put(getThings.error(error));
  }
}

export function* thingsSaga() {
  yield takeLatest(getType(getThings.request), getThingsRequestSaga);
}
```

---
**[[Top](#React-Snippets)]**<br><br>

## Testing sagas

```ts
import axios from 'axios';
import { getType } from 'deox';
import { SagaType, TestApi, testSaga } from 'redux-saga-test-plan';
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
    sagaTest = testSaga(getThingsRequestSaga as SagaType, getThings.request(PAYLOAD));
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
    expect(sagasTest.next().value).toStrictEqual(takeLatest(getType(getThings.request), getThingsRequestSaga));
  });
});

```

---
**[[Top](#React-Snippets)]**<br><br>

## API service

```ts
import axios from 'axios';

export interface GetThingsResponse {
  meta: ReducerMeta;
  items: Things[];
}


const getThings = async ({ orgId, params }: { orgId: string; params?: Params }): Promise<GetThingsResponse> => {
  const url = `/api/things`;

  const response: { total: number; items: Things[] } = await axios.get(url, {
    params
  });
  const { total, items } = response;

  const output: {
    meta: ReducerMeta;
    items: Things[];
  } = {
    meta: {
      total,
      ...params
    },
    items
  };

  return output;
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
  handleAction(actions.getThings.request, state => ({
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
      state = thingsReducer(undefined, { type: '@@INIT' } as any);
    });

    it('should return the default state', () => {
      expect(state).toStrictEqual(initialState);
    });
  });

  describe('and getThings.request action is received', () => {
    const mock = {
      orgId: 'id',
      params: {}
    };
    beforeEach(() => {
      state = thingsReducer(state, actions.getThings.request(mock));
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
  
